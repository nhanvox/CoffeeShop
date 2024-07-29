import 'dart:convert';

import 'package:coffeeshop/mainpage.dart';
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
  bool _hasCart = false;
  List? cartsList;

  @override
  void initState() {
    super.initState();
    _getCartsByUser();
  }

  Future<void> _getCartsByUser() async {
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
            _hasCart = cartsList!.isNotEmpty;
          });
        } else {
          setState(() {
            cartsList = [];
            _hasCart = false;
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
    num allPrice = 0;

    if (cartsList != null) {
      for (var cart in cartsList!) {
        totalQuantity += cart['quantity'] as int;
        allPrice += cart['total'] as num;
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
                onPressed: () => Navigator.pop(context, true),
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
        height: 160,
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
                      .format(allPrice),
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
                if (_hasCart) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PaymentPage(
                          cartsList: cartsList!,
                          totalQuantity: totalQuantity,
                          allPrice: allPrice),
                    ),
                  );
                } else {
                  _showUpdateSuccessDialog(context);
                }
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

  void _showUpdateSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 300,
                height: 180,
                margin: const EdgeInsets.only(top: 38),
                padding: const EdgeInsets.only(right: 30, left: 30, top: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Vui lòng thêm sản phẩm vào giỏ hàng!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF725E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: const Text(
                          'Tiếp tục',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/check_mark.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
