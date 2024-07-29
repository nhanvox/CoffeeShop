import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CardOrderProduct extends StatefulWidget {
  final Map cart;
  const CardOrderProduct({
    super.key,
    required this.cart,
  });

  @override
  State<CardOrderProduct> createState() => _CardOrderProductState();
}

class _CardOrderProductState extends State<CardOrderProduct> {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.cart['productid']['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/placeholder.png',
                                fit: BoxFit.fill);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.cart['productid']['name']} (${widget.cart['size']})',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.getFont(
                              'Quicksand',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Đường: ${widget.cart['sugar']},',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Đá: ${widget.cart['ice']}',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatCurrency.format(widget.cart['total']),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Số lượng: ${widget.cart['quantity']}',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
