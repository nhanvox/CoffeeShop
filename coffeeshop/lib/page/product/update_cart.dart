import 'dart:convert';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isExpanded = false;

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
            title: TextQuicksand(
              widget.cart['productid']['name'],
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
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
                    widget.cart['productid']['description'],
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
                    widget.cart['productid']['description'],
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
                          )),
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
                          textStyle: GoogleFonts.getFont(
                            'Quicksand',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text(
                          'CẬP NHẬT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  // Expanded(
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 30),
                  //     height: 60,
                  //     decoration: ShapeDecoration(
                  //       color: const Color(0xFFFF725E),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //     ),
                  //     child: InkWell(
                  //       onTap: () async {
                  //         if (_hasCart) {
                  //           await fetchToCart();
                  //         } else {
                  //           await addToCart();
                  //         }
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const CartPage(),
                  //           ),
                  //         );
                  //       },
                  //       child: Center(
                  //         child: Text(
                  //           formatCurrency
                  //               .format(widget.product['price'] * quantity),
                  //           textAlign: TextAlign.center,
                  //           style: const TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 22,
                  //             fontFamily: 'Quicksand',
                  //             fontWeight: FontWeight.w400,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                  )
            ],
          ),
        ),
      ),
    );
  }
}
