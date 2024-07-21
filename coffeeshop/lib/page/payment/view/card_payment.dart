import 'package:flutter/material.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({super.key});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  bool isCheckedZalo = false;
  bool isCheckedMomo = false;
  bool isCheckedVisa = false;
  bool isCheckedAtm = false;
  bool isCheckedCash = false;

  void uncheckAll() {
    isCheckedZalo = false;
    isCheckedMomo = false;
    isCheckedVisa = false;
    isCheckedAtm = false;
    isCheckedCash = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phương thức thanh toán',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
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
                      'assets/images/payment/zalopay.jfif',
                      fit: BoxFit.cover, // Adjusted fit
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    'Ví ZaloPay',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isCheckedZalo
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedZalo = !isCheckedZalo;
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
                      'assets/images/payment/momo.png',
                      fit: BoxFit.cover, // Adjusted fit
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    'Ví Momo',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                    ),
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
                      color: Colors.black,
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedMomo = !isCheckedMomo;
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
                      'assets/images/payment/visa_mastercard.jfif',
                      fit: BoxFit.cover, // Adjusted fit
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    'Thẻ thanh toán quốc tế (Visa, Master)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isCheckedVisa
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedVisa = !isCheckedVisa;
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
                  child: Text(
                    'Thẻ ATM và tài khoản ngân hàng',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                    ),
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
                      color: Colors.black,
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedAtm = !isCheckedAtm;
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
                  child: Text(
                    'Thanh toán khi nhận hàng',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                    ),
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
                      color: Colors.black,
                      size: 30,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        uncheckAll();
                        isCheckedCash = !isCheckedCash;
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
