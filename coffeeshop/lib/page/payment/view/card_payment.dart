import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardPayment extends StatefulWidget {
  int getPayment;

  CardPayment({
    super.key,
    required this.getPayment,
  });

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  bool isCheckedZalo = false;
  bool isCheckedMomo = false;
  bool isCheckedVisa = false;
  bool isCheckedAtm = false;
  bool isCheckedCash = true;

  void uncheckAll() {
    isCheckedZalo = false;
    isCheckedMomo = false;
    isCheckedVisa = false;
    isCheckedAtm = false;
    isCheckedCash = false;
  }

  void getCheck() {
    
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 270,
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextQuicksand(
                  'Phương thức thanh toán',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(25), // Adjusted border radius
                    child: Image.asset(
                      'assets/images/payment/momo.png',
                      fit: BoxFit.cover, // Adjusted fit
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: TextQuicksand(
                    'Ví Momo',
                    textAlign: TextAlign.left,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isCheckedMomo
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: const Color(0xffff725e),
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedMomo = !isCheckedMomo;
                        widget.getPayment = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(25), // Adjusted border radius
                    child: Image.asset(
                      'assets/images/payment/atm.jfif',
                      fit: BoxFit.cover, // Adjusted fit
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: TextQuicksand(
                    'Thẻ ATM và tài khoản ngân hàng',
                    textAlign: TextAlign.left,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isCheckedAtm
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: const Color(0xffff725e),
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedAtm = !isCheckedAtm;
                        widget.getPayment = 2;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(25), // Adjusted border radius
                    child: Image.asset(
                      'assets/images/payment/money.jfif',
                      fit: BoxFit.cover, // Adjusted fit
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: TextQuicksand(
                    'Thanh toán khi nhận hàng',
                    textAlign: TextAlign.left,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isCheckedCash
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: const Color(0xffff725e),
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedCash = !isCheckedCash;
                        widget.getPayment = 3;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
