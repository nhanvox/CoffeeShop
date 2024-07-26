import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coffeeshop/page/product/cartpage.dart';
import 'package:coffeeshop/page/product/view/sizeoption.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:coffeeshop/config/config.dart';
import 'package:coffeeshop/config/login_status.dart';

class UpdateCartPage extends StatefulWidget {
  final Map cart;
  const UpdateCartPage({super.key, required this.cart});

  @override
  State<UpdateCartPage> createState() => _UpdateCartPage();
}

class _UpdateCartPage extends State<UpdateCartPage> {
  int selectedSize = 3;
  int quantity = 1;
  int productsugarselected = 3;
  int producticeselected = 3;
  bool productisfavorite = false;

  @override
  void initState() {
    super.initState();
    // Initialize state with values from the cart
    selectedSize = getSizeIndex(widget.cart['size']);
    quantity = widget.cart['quantity'];
    productsugarselected = getSugarIndex(widget.cart['sugar']);
    producticeselected = getIceIndex(widget.cart['ice']);
  }

  int getSizeIndex(String size) {
    switch (size) {
      case 'Nhỏ':
        return 1;
      case 'Vừa':
        return 2;
      case 'Lớn':
        return 3;
      default:
        return 3;
    }
  }

  int getSugarIndex(String sugar) {
    switch (sugar) {
      case '30%':
        return 1;
      case '50%':
        return 2;
      case '100%':
        return 3;
      default:
        return 3;
    }
  }

  int getIceIndex(String ice) {
    switch (ice) {
      case '30%':
        return 1;
      case '50%':
        return 2;
      case '100%':
        return 3;
      default:
        return 3;
    }
  }

  Future<void> _updateCart() async {
    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      return;
    }

    int adjustedPrice = widget.cart['productid']['price'];
    if (selectedSize == 1) {
      adjustedPrice -= 10000;
    } else if (selectedSize == 3) {
      adjustedPrice += 10000;
    }

    final cartData = {
      'productid': widget.cart['productid'],
      'userid': userID,
      'size': getSizeText(selectedSize),
      'total': adjustedPrice * quantity,
      'quantity': quantity,
      'sugar': getSugarText(productsugarselected),
      'ice': getIceText(producticeselected),
    };

    Uri url = Uri.parse(updateCart + widget.cart['_id']);

    try {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(cartData));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Response JSON: $jsonResponse');
        if (jsonResponse['success'] == true) {
          print('Cart updated successfully.');
        } else {
          print('Failed to update cart.');
        }
      } else {
        print('Failed to update cart with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while updating the cart: $e');
    }
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
        return 'Lớn';
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
        return '100%';
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
        return '100%';
    }
  }

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');

  @override
  Widget build(BuildContext context) {
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
              widget.cart['productid']['name'],
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
                          widget.cart['productid']['image'],
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
                    widget.cart['productid']['description'],
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

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Số lượng',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await _updateCart();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF725E),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Cập nhật giỏ hàng'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
