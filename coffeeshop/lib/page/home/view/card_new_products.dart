import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../../config/login_status.dart';
import '../../product/cartpage.dart';
import '../../product/view/productdetailpage.dart';

class CardNewProducts extends StatefulWidget {
  final Map product;
  const CardNewProducts({super.key, required this.product});

  @override
  State<CardNewProducts> createState() => _CardNewProductsState();
}

class _CardNewProductsState extends State<CardNewProducts> {
  bool _hasCart = false;
  @override
  void initState() {
    super.initState();
    checkCart();
  }

  Future<void> checkCart() async {
    String? userId = LoginStatus.instance.userID;

    try {
      Uri getCartUrl = Uri.parse(getCartsByUser + userId!);
      var response = await http.get(getCartUrl);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          var cart = jsonResponse['carts'];
          setState(() {
            _hasCart = cart != null;
          });
        }
      } else {
        print('Failed to get profile');
      }
    } catch (e) {
      print('Error checking profile: $e');
    }
  }

  Future<void> addToCart() async {
    String? userID = LoginStatus.instance.userID;

    final cartData = {
      'productid': widget.product['_id'],
      'userid': userID,
      'size': 'Lớn',
      'total': widget.product['price'],
      'quantity': 1,
      'sugar': '100%',
      'ice': '100%',
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

  Future<void> fetchToCart() async {
    String? userID = LoginStatus.instance.userID;

    final cartData = {
      'productid': widget.product['_id'],
      'userid': userID,
      'size': 'Lớn',
      'total': widget.product['price'],
      'quantity': 1,
      'sugar': '100%',
      'ice': '100%',
    };

    try {
      // Fetch the user's current cart
      Uri fetchCartUrl = Uri.parse(getCartsByUser + userID!);
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
              'quantity': existingCartItem['quantity'] + 1,
              'total':
                  widget.product['price'] * (existingCartItem['quantity'] + 1),
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

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductDetailPage(
              product: widget.product,
            ),
          ),
        );
      },
      child: Container(
        width: 270,
        height: 110,
        margin: const EdgeInsets.only(right: 10, bottom: 8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFE2DCCA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
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
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: 110,
              child: Image.network(
                widget.product['image'],
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product['name'],
                      maxLines: 1, // Chỉ hiển thị một dòng
                      overflow:
                          TextOverflow.ellipsis, // Thêm dấu ba chấm nếu quá dài
                      style: GoogleFonts.getFont(
                        'Quicksand',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.60,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formatCurrency.format(widget.product['price']),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.52,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          width: 24,
                          height: 24,
                          margin: const EdgeInsets.only(),
                          clipBehavior: Clip.antiAlias,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFFF725E),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if (_hasCart) {
                                await fetchToCart();
                              } else {
                                await addToCart();
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartPage(),
                                ),
                              );
                            },
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
