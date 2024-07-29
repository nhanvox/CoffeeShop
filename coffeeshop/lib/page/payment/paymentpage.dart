import 'dart:convert';

import 'package:coffeeshop/config/config.dart';
import 'package:coffeeshop/config/login_status.dart';
import 'package:coffeeshop/mainpage.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'view/card_order_product.dart';
import 'view/card_info.dart';
import 'view/card_payment.dart';
import 'view/card_voucher.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  final List cartsList;
  final int totalQuantity;
  final num allPrice;
  const PaymentPage(
      {super.key,
      required this.cartsList,
      required this.totalQuantity,
      required this.allPrice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? profile;
  bool isLoading = false;
  List? ordersList;
  int selectedPaymentMethod = 3;
  String? name;
  String? phoneNumber;
  String? address;
  num deliverycharges = 10000;
  num totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  String getPaymentText(int payment) {
    switch (payment) {
      case 1:
        return 'Ví Momo';
      case 2:
        return 'Tài khoản ngân hàng';
      case 3:
        return 'Tiền mặt';
      default:
        return 'Unknown';
    }
  }

  void _getProfile() async {
    if (LoginStatus.instance.loggedIn) {
      final userId = LoginStatus.instance.userID;
      if (userId != null) {
        final url = '$getProfileByUser$userId';
        final response = await http.get(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['success'] == true) {
            setState(() {
              profile = jsonResponse['profile'];
              name = profile!['name'];
              phoneNumber = profile!['phoneNumber'];
              address = profile!['address'];
            });
          } else {
            print('Failed to load user');
          }
        }
      }
    }
  }

  void placeOrder() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      setState(() {
        isLoading = false;
      });
      return;
    }

    Uri url = Uri.parse(addOrder); // Thay thế bằng URL API thực tế của bạn

    List itemOrders = widget.cartsList.map((cart) {
      return {
        "productid": cart["productid"],
        "size": cart["size"],
        "sugar": cart["sugar"],
        "ice": cart["ice"],
        "quantity": cart["quantity"],
      };
    }).toList();

    var orderData = {
      "userid": userID,
      "itemorders": itemOrders,
      "quantitysum": widget.totalQuantity,
      "totalsum": totalPrice,
      "phoneNumber": phoneNumber,
      "name": name,
      "address": address,
      "deliverycharges": deliverycharges,
      "paymentMethod": getPaymentText(selectedPaymentMethod),
    };

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Order placed successfully: $jsonResponse');
        url = Uri.parse(deleteCartsByUser + userID);
        // Xóa giỏ hàng của người dùng sau khi đặt hàng thành công
        var deleteResponse = await http
            .delete(url, headers: {'Content-Type': 'application/json'});
        if (deleteResponse.statusCode == 200) {
          print('Carts deleted successfully');
        } else {
          print(
              'Failed to delete carts with status code: ${deleteResponse.statusCode}');
        }
        setState(() {
          isLoading = false;
        });
        _showUpdateSuccessDialog(context);
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to place order with status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('An error occurred while placing order: $e');
    }
  }

  void handleInfoChanged(
      String newPhoneNumber, String newName, String newAddress) {
    setState(() {
      phoneNumber = newPhoneNumber;
      name = newName;
      address = newAddress;
    });
  }

  void handlePaymentMethodSelected(int method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    totalPrice = widget.allPrice + deliverycharges;
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
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                iconSize: 36,
              ),
            ),
            centerTitle: true,
            title: const TextQuicksand(
              'XÁC NHẬN ĐƠN HÀNG',
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            floating: true,
            pinned: true,
          ),
          const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CardInfo())),
          SliverToBoxAdapter(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.white,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextQuicksand(
                              'Chi tiết đơn hàng',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                );
                              },
                              child: const TextQuicksand(
                                'Thêm',
                                color: Colors.deepOrange,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                            spacing: 20.0,
                            runSpacing: 20.0,
                            children: widget.cartsList
                                .map((cart) => CardOrderProduct(cart: cart))
                                .toList())
                      ],
                    ))),
          ),
          const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CardVoucher())),
          SliverToBoxAdapter(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CardPayment(
                    selectedPaymentMethod: selectedPaymentMethod,
                    onPaymentMethodSelected: handlePaymentMethodSelected,
                  ))),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              height: 190,
              decoration: ShapeDecoration(
                color: Colors.white,
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextQuicksand(
                        'Tổng cộng (${widget.totalQuantity} sản phẩm)',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextQuicksand(
                        'Thành tiền',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      Text(
                        formatCurrency.format(widget.allPrice),
                        style: GoogleFonts.getFont(
                          'Quicksand',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextQuicksand(
                        'Phí giao hàng',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      TextQuicksand(
                        formatCurrency.format(deliverycharges),
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextQuicksand(
                        'Số tiền thanh toán',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      TextQuicksand(
                        formatCurrency.format(totalPrice),
                        color: const Color(0xffff725e),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng: ${widget.totalQuantity} sản phẩm',
                  style: GoogleFonts.getFont(
                    'Quicksand',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formatCurrency.format(totalPrice),
                  style: GoogleFonts.getFont(
                    'Quicksand',
                    color: const Color(0xFFFF8675),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                placeOrder();
                // _showUpdateSuccessDialog(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF725E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const TextQuicksand(
                          'ĐẶT HÀNG',
                          textAlign: TextAlign.center,
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
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
                width: 400,
                height: 200,
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
                    const TextQuicksand(
                      'Đặt hàng thành công!',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF725E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: const TextQuicksand(
                          'XONG',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
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
                  ))
            ],
          ),
        );
      },
    );
  }
}
