import 'dart:convert';

import 'package:coffeeshop/page/payment/paymentpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/login_status.dart';
import 'view/card_order_product.dart';
import '../../config/config.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List? cartsList;
  @override
  void initState() {
    super.initState();
    _getCartsByUser();
  }

  void _getCartsByUser() async {
    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      return;
    }

    Uri url = Uri.parse(getCartsByUser + userID);

    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Response JSON: $jsonResponse'); // Log the entire response

        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('carts')) {
          setState(() {
            cartsList = jsonResponse['carts'];
          });
        } else {
          setState(() {
            cartsList = [];
          });
          print('No products found for this user.');
        }
      } else {
        print(
            'Failed to load products with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalQuantity = 0;
    num totalPrice = 0;

    if (cartsList != null) {
      for (var cart in cartsList!) {
        totalQuantity += cart['quantity'] as int;
        totalPrice += cart['total'] as num;
      }
    }
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFFFFEF2),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                iconSize: 36,
              ),
            ),
            centerTitle: true,
            title: const Text(
              'Giỏ hàng',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
              ),
            ),
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                children: cartsList != null
                    ? cartsList!
                        .map((cart) => CardOrderProduct(
                              cart: cart,
                              onUpdate: _getCartsByUser, // Pass the callback
                            ))
                        .toList()
                    : [const Text('Không có sản phẩm trong giỏ hàng')],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng: $totalQuantity sản phẩm',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND')
                      .format(totalPrice),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                );
              },
              child: Container(
                width: 180,
                height: 50,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF725E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Đặt hàng',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400,
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
