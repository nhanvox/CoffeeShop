import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/payment/view/list_voucher.dart';
import 'package:flutter/material.dart';

class CardVoucher extends StatefulWidget {
  const CardVoucher({super.key});
  @override
  State<CardVoucher> createState() => _CardVoucherState();
}

class _CardVoucherState extends State<CardVoucher> {
  void _openIconButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const ListVoucher(),
    );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextQuicksand(
                  'Khuyến mãi',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                TextButton(
                  onPressed: _openIconButtonPressed,
                  child: const TextQuicksand(
                    'Xem thêm',
                    color: Colors.deepOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFEFED),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/payment/voucher.jfif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextQuicksand(
                          'NEWKM15K',
                          textAlign: TextAlign.left,
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        TextQuicksand(
                          'Giảm 15,000đ cho đơn đầu tiên',
                          maxLine: 1, // Chỉ hiển thị một dòng
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        TextQuicksand(
                          '01/07/2024 23:59',
                          textAlign: TextAlign.left,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0xffff725e),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const TextQuicksand(
                      'Chọn',
                      textAlign: TextAlign.left,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
