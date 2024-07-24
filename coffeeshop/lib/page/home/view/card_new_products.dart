import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../product/view/productdetailpage.dart';

class CardNewProducts extends StatelessWidget {
  final Map product;
  const CardNewProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductDetailPage(
              product: product,
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
                product['image'],
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
                      product['name'],
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
                      formatCurrency.format(product['price']),
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
                            onPressed: () {}),
                      ),
                    ),
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
