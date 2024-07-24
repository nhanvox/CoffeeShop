import 'dart:convert';

import 'package:coffeeshop/page/product/cartpage.dart';
import 'package:coffeeshop/page/product/view/sizeoption.dart';
import 'package:flutter/material.dart';
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
  bool _hasCart = false;
  Map<String, dynamic>? _cart;

  int selectedSize = 1;
  int quantity = 1;

  int productsugarselected = 2;
  int producticeselected = 2;
  bool productisfavorite = false;

  @override
  void initState() {
    super.initState();
    _checkCart();
  }

  String getSizeText(int size) {
    switch (size) {
      case 0:
        return 'Nhỏ';
      case 1:
        return 'Vừa';
      case 2:
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

  Future<void> _checkCart() async {
    String? userId = LoginStatus.instance.userID;

    if (userId == null) return;

    try {
      Uri getCartUrl = Uri.parse(getCartsByUser + userId);
      var response = await http.get(getCartUrl);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          var cart = jsonResponse['carts'];
          setState(() {
            _hasCart = cart != null;
            _cart = cart;
          });
        }
      } else {
        print('Failed to get profile');
      }
    } catch (e) {
      print('Error checking profile: $e');
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
      Uri addCartUrl = Uri.parse(addCarts);
      var addCartResponse = await http.post(addCartUrl,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartData));

      if (addCartResponse.statusCode == 200) {
        var addCartJsonResponse = jsonDecode(addCartResponse.body);
        if (addCartJsonResponse['success'] == true) {
          print('Product added to cart successfully.');
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

  Future<void> _fetchToCart() async {
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
      // Fetch the user's current cart
      Uri fetchCartUrl = Uri.parse(getCartsByUser + userID);
      var fetchCartResponse = await http
          .get(fetchCartUrl, headers: {"Content-Type": "application/json"});

      if (fetchCartResponse.statusCode == 200) {
        var fetchCartJsonResponse = jsonDecode(fetchCartResponse.body);
        if (fetchCartJsonResponse['success'] == true) {
          List carts = fetchCartJsonResponse['carts'] ?? [];

          // Find if there is an existing cart item
          var existingCartItem = carts.firstWhere(
              (cartItem) =>
                  cartItem['productid']['_id'] == widget.product['_id'] &&
                  cartItem['size'] == cartData['size'] &&
                  cartItem['sugar'] == cartData['sugar'] &&
                  cartItem['ice'] == cartData['ice'],
              orElse: () => null);

          if (existingCartItem != null) {
            // Update the existing cart item quantity
            Uri updateCartUrl = Uri.parse(updateCart + existingCartItem['_id']);
            var updateCartData = {
              'quantity': existingCartItem['quantity'] + quantity,
              'total': widget.product['price'] *
                  (existingCartItem['quantity'] + quantity),
            };
            var updateCartResponse = await http.put(updateCartUrl,
                headers: {"Content-Type": "application/json"},
                body: jsonEncode(updateCartData));

            if (updateCartResponse.statusCode == 200) {
              var updateCartJsonResponse = jsonDecode(updateCartResponse.body);
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
            // Add the product to the cart as a new item
            Uri addCartUrl = Uri.parse(addCarts);
            var addCartResponse = await http.post(addCartUrl,
                headers: {"Content-Type": "application/json"},
                body: jsonEncode(cartData));

            if (addCartResponse.statusCode == 200) {
              var addCartJsonResponse = jsonDecode(addCartResponse.body);
              if (addCartJsonResponse['success'] == true) {
                print('Product added to cart successfully.');
              } else {
                print('Failed to add product to cart.');
              }
            } else {
              print(
                  'Failed to add product to cart with status code: ${addCartResponse.statusCode}');
            }
          }
        }
      } else {
        print(
            'Failed to fetch cart with status code: ${fetchCartResponse.statusCode}');
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
            title: Text(
              widget.product['name'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
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
                        setState(() {
                          productisfavorite = !productisfavorite;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product['description'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          )),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(
              'Chọn kích cỡ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
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
                    isSelected: selectedSize == 0,
                    onTap: () => setState(() {
                      selectedSize = 0;
                    }),
                  ),
                  SizeOption(
                    label: 'Vừa',
                    icon: Icons.local_cafe,
                    iconSize: 34.0,
                    isSelected: selectedSize == 1,
                    onTap: () => setState(() {
                      selectedSize = 1;
                    }),
                  ),
                  SizeOption(
                    label: 'Lớn',
                    icon: Icons.local_cafe,
                    iconSize: 44.0,
                    isSelected: selectedSize == 2,
                    onTap: () => setState(() {
                      selectedSize = 2;
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(
              'Đường',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('30%'),
                    value: 1,
                    groupValue: productsugarselected,
                    onChanged: (int? value) {
                      setState(() {
                        productsugarselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('50%'),
                    value: 2,
                    groupValue: productsugarselected,
                    onChanged: (int? value) {
                      setState(() {
                        productsugarselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('100%'),
                    value: 3,
                    groupValue: productsugarselected,
                    onChanged: (int? value) {
                      setState(() {
                        productsugarselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(
              'Đá',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('30%'),
                    value: 1,
                    groupValue: producticeselected,
                    onChanged: (int? value) {
                      setState(() {
                        producticeselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('50%'),
                    value: 2,
                    groupValue: producticeselected,
                    onChanged: (int? value) {
                      setState(() {
                        producticeselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('100%'),
                    value: 3,
                    groupValue: producticeselected,
                    onChanged: (int? value) {
                      setState(() {
                        producticeselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
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
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(quantity.toString(),
                      style: const TextStyle(fontSize: 34)),
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
                        size: 40,
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
                    if (_hasCart) {
                      await _fetchToCart();
                    } else {
                      await _addToCart();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      formatCurrency.format(widget.product['price'] * quantity),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
