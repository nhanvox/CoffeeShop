import 'dart:convert';

import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/product/cartpage.dart';
import 'package:coffeeshop/page/product/view/sizeoption.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/config.dart';
import '../../../config/login_status.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  final Map product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSize = 3;
  int quantity = 1;

  int productsugarselected = 3;
  int producticeselected = 3;
  bool productisfavorite = false;
  bool isExpanded = false;
  String? favProductId;

  @override
  void initState() {
    super.initState();
    _checkIfProductIsFavorite();
  }

  String getSizeText(int size) {
    switch (size) {
      case 1:
        return 'Nhỏ';
      case 2:
        return 'Vừa';
      case 3:
        return 'Lớn';
      default:
        return 'Unknown';
    }
  }

  String getSugarText(int sugar) {
    switch (sugar) {
      case 1:
        return '30%';
      case 2:
        return '50%';
      case 3:
        return '100%';
      default:
        return 'Unknown';
    }
  }

  String getIceText(int ice) {
    switch (ice) {
      case 1:
        return '30%';
      case 2:
        return '50%';
      case 3:
        return '100%';
      default:
        return 'Unknown';
    }
  }

  Future<void> _checkIfProductIsFavorite() async {
    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      return;
    }
    //Lấy toàn bộ fav product theo userID
    Uri url = Uri.parse(getFavProductsByUser + userID);
    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      //check nếu res trả về toàn bộ sản phẩm có
      if (response.statusCode == 200) {
        //trả về kiểu map
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('favproduct')) {
          //lặp kiểm tra từng id sản phẩm trùng với id sản phẩm đang thể hiện nếu có thì đổi trạng thái nút sang true
          for (var favproduct in jsonResponse['favproduct']) {
            if (favproduct['productid']['_id'] == widget.product['_id']) {
              setState(() {
                productisfavorite = true;
                favProductId = favproduct['_id'];
              });
              break;
            }
          }
        }
      } else {
        throw 'Failed to load fav products: ${response.statusCode}';
      }
    } catch (e) {
      print('An error occurred while checking fav product status: $e');
    }
  }

  Future<void> toggleFavorite() async {
    final newFavoriteStatus = !productisfavorite;
    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      return;
    }

    Uri url;
    if (newFavoriteStatus) {
      url = Uri.parse(addFavProduct);
    } else {
      if (favProductId == null) {
        print('No favProductId found for deletion');
        return;
      }
      url = Uri.parse(deleteFavProduct + favProductId!);
    }

    try {
      http.Response response;
      if (newFavoriteStatus) {
        response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'productid': widget.product['_id'],
            'userId': userID,
          }),
        );
      } else {
        response = await http.delete(
          url,
          headers: {'Content-Type': 'application/json'},
        );
      }
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          //setState() được gọi, Flutter sẽ gọi lại phương thức build() của widget hiện tạt và cập nhật giao diện người dùng dựa trên trạng thái mới của productisfavorite
          productisfavorite = newFavoriteStatus;
          if (newFavoriteStatus) {
            favProductId = jsonResponse['_id']; // Assuming API returns the ID
          } else {
            favProductId = null;
          }
        });
      } else {
        throw Exception('Failed to update favorite status');
      }
    } catch (error) {
      print('Error updating favorite status: $error');
    }
  }

  Future<void> _addToCart() async {
    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      return;
    }

    final cartData = {
      'productid': widget.product['_id'],
      'userid': userID,
      'size': getSizeText(selectedSize),
      'total': widget.product['price'] * quantity,
      'quantity': quantity,
      'sugar': getSugarText(productsugarselected),
      'ice': getIceText(producticeselected),
    };

    try {
      // Add the product to the cart first
      Uri addCartUrl = Uri.parse(addCarts);
      var addCartResponse = await http.post(addCartUrl,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartData));

      if (addCartResponse.statusCode == 200) {
        var addCartJsonResponse = jsonDecode(addCartResponse.body);
        if (addCartJsonResponse['success'] == true) {
          print('Product added to cart successfully.');

          // Fetch the user's current cart to check for duplicates
          Uri fetchCartUrl = Uri.parse(getCartsByUser + userID);
          var fetchCartResponse = await http
              .get(fetchCartUrl, headers: {"Content-Type": "application/json"});

          if (fetchCartResponse.statusCode == 200) {
            var fetchCartJsonResponse = jsonDecode(fetchCartResponse.body);
            if (fetchCartJsonResponse['success'] == true &&
                fetchCartJsonResponse.containsKey('carts')) {
              List carts = fetchCartJsonResponse['carts'];
              var existingCartItem = carts.firstWhere(
                  (cartItem) =>
                      cartItem['productid']['_id'] == widget.product['_id'] &&
                      cartItem['size'] == cartData['size'] &&
                      cartItem['sugar'] == cartData['sugar'] &&
                      cartItem['ice'] == cartData['ice'],
                  orElse: () => null);

              if (existingCartItem != null) {
                // Update the existing cart item quantity
                Uri updateCartUrl =
                    Uri.parse(updateCart + existingCartItem['_id']);
                var updateCartData = {
                  'quantity': existingCartItem['quantity'] + quantity,
                  'total': widget.product['price'] *
                      (existingCartItem['quantity'] + quantity),
                };
                var updateCartResponse = await http.put(updateCartUrl,
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode(updateCartData));

                if (updateCartResponse.statusCode == 200) {
                  var updateCartJsonResponse =
                      jsonDecode(updateCartResponse.body);
                  if (updateCartJsonResponse['success'] == true) {
                    print('Product updated in cart successfully.');
                  } else {
                    print('Failed to update product in cart.');
                  }
                } else {
                  print(
                      'Failed to update product in cart with status code: ${updateCartResponse.statusCode}');
                }
              } else {
                print('Product added to cart as a new item.');
              }
            } else {
              print('Failed to fetch cart or cart is empty.');
            }
          } else {
            print(
                'Failed to fetch cart with status code: ${fetchCartResponse.statusCode}');
          }
        } else {
          print('Failed to add product to cart.');
        }
      } else {
        print(
            'Failed to add product to cart with status code: ${addCartResponse.statusCode}');
      }
    } catch (e) {
      print('An error occurred while adding/updating product in cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFFFFEF2),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                iconSize: 36,
              ),
            ),
            centerTitle: true,
            title: TextQuicksand(
              widget.product['name'],
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 30),
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Color(0xFFFF725E),
                  shape: OvalBorder(),
                ),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    }),
              ),
            ],
            floating: true,
            pinned: true,
          ),
          // Product image
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Stack(
                children: [
                  Container(
                    height: 318,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.product['image'],
                        ),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 25,
                    child: IconButton(
                      icon: Icon(
                        productisfavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: const Color(0xff2A4261),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                            spreadRadius: 0,
                          )
                        ],
                        size: 40,
                      ),
                      onPressed: () {
                        toggleFavorite();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCrossFade(
                  firstChild: Text(
                    widget.product['description'],
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.getFont(
                      'Quicksand',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  secondChild: Text(
                    widget.product['description'],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.getFont(
                      'Quicksand',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: TextQuicksand(
                    isExpanded ? 'Thu gọn' : 'Xem thêm',
                    color: const Color(0xffadb5bd),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            child: TextQuicksand(
              'Chọn kích cỡ',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizeOption(
                    label: 'Nhỏ',
                    icon: Icons.local_cafe,
                    iconSize: 24.0,
                    isSelected: selectedSize == 1,
                    onTap: () => setState(() {
                      selectedSize = 1;
                    }),
                  ),
                  SizeOption(
                    label: 'Vừa',
                    icon: Icons.local_cafe,
                    iconSize: 34.0,
                    isSelected: selectedSize == 2,
                    onTap: () => setState(() {
                      selectedSize = 2;
                    }),
                  ),
                  SizeOption(
                    label: 'Lớn',
                    icon: Icons.local_cafe,
                    iconSize: 44.0,
                    isSelected: selectedSize == 3,
                    onTap: () => setState(() {
                      selectedSize = 3;
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            child: TextQuicksand(
              'Đường',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: const Color(0xFFFF725E),
                          value: 1,
                          groupValue: productsugarselected,
                          onChanged: (int? value) {
                            setState(() {
                              productsugarselected = value!;
                            });
                          }),
                      const TextQuicksand(
                        '30%',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 25,
                      width: 10,
                      child: VerticalDivider(
                        color: Color.fromARGB(75, 0, 0, 0),
                        width: 40,
                        thickness: 2,
                      )),
                  Row(
                    children: [
                      Radio(
                          activeColor: const Color(0xFFFF725E),
                          value: 2,
                          groupValue: productsugarselected,
                          onChanged: (int? value) {
                            setState(() {
                              productsugarselected = value!;
                            });
                          }),
                      const TextQuicksand(
                        '50%',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 25,
                      width: 10,
                      child: VerticalDivider(
                        color: Color.fromARGB(75, 0, 0, 0),
                        width: 40,
                        thickness: 2,
                      )),
                  Row(
                    children: [
                      Radio(
                          activeColor: const Color(0xFFFF725E),
                          value: 3,
                          groupValue: productsugarselected,
                          onChanged: (int? value) {
                            setState(() {
                              productsugarselected = value!;
                            });
                          }),
                      const TextQuicksand(
                        '100%',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: TextQuicksand(
              'Đá',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: const Color(0xFFFF725E),
                          value: 1,
                          groupValue: producticeselected,
                          onChanged: (value) {
                            setState(() {
                              producticeselected = value!;
                            });
                          }),
                      const TextQuicksand(
                        '30%',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 25,
                      width: 10,
                      child: VerticalDivider(
                        color: Color.fromARGB(75, 0, 0, 0),
                        width: 40,
                        thickness: 2,
                      )),
                  Row(
                    children: [
                      Radio(
                          activeColor: const Color(0xFFFF725E),
                          value: 2,
                          groupValue: producticeselected,
                          onChanged: (value) {
                            setState(() {
                              producticeselected = value!;
                            });
                          }),
                      const TextQuicksand(
                        '50%',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 25,
                      width: 10,
                      child: VerticalDivider(
                        color: Color.fromARGB(75, 0, 0, 0),
                        width: 40,
                        thickness: 2,
                      )),
                  Row(
                    children: [
                      Radio(
                          activeColor: const Color(0xFFFF725E),
                          value: 3,
                          groupValue: producticeselected,
                          onChanged: (value) {
                            setState(() {
                              producticeselected = value!;
                            });
                          }),
                      const TextQuicksand(
                        '100%',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                      child: Container(
                        decoration: const ShapeDecoration(
                            color: Color.fromARGB(255, 89, 119, 159),
                            shape: CircleBorder()),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        quantity.toString(),
                        style: GoogleFonts.getFont('Quicksand',
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        decoration: const ShapeDecoration(
                            color: Color.fromARGB(255, 89, 119, 159),
                            shape: CircleBorder()),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 60,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF725E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      await _addToCart();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        formatCurrency
                            .format(widget.product['price'] * quantity),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Quicksand',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
