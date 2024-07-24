import 'dart:convert';

import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/payment/paymentpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            title: const TextQuicksand(
              'GIỎ HÀNG',
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: cartsList != null
                  ? Column(
                      children: cartsList!
                          .map((cart) => CardOrderProduct(
                                cart: cart,
                                onUpdate: _getCartsByUser, // Pass the callback
                              ))
                          .toList(),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(
                        child: Image.asset(
                          'assets/images/cartisempty.png',
                          height: 350,
                          fit: BoxFit
                              .contain, // Adjusts the image to fit within the specified height
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 180,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextQuicksand(
                  'Tổng: $totalQuantity sản phẩm',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Text(
                  NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND')
                      .format(totalPrice),
                  style: GoogleFonts.getFont(
                    'Quicksand',
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
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
                width: double.infinity,
                height: 60,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF725E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Center(
                  child: TextQuicksand(
                    'ĐẶT HÀNG',
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
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
