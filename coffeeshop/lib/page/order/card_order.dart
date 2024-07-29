import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardOrder extends StatefulWidget {
  final List itemorders;

  const CardOrder({
    super.key,
    required this.itemorders,
  });

  @override
  State<CardOrder> createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
    return Column(
      children: widget.itemorders.map((itemorder) {
        num orderprice = itemorder['productid']["price"];
        if (itemorder["size"] == 'Nhỏ') {
          orderprice -= 10000;
        } else if (itemorder["size"] == 'Lớn') {
          orderprice += 10000;
        }
        return Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    itemorder['productid']['image'],
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemorder['productid']['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemorder['size'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              itemorder['sugar'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              itemorder['ice'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'x${itemorder['quantity']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatCurrency
                                .format(orderprice * itemorder['quantity']),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
