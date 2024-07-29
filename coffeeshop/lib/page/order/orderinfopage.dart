import 'package:coffeeshop/page/order/card_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderInfoWidget extends StatefulWidget {
  final Map order;

  const OrderInfoWidget({
    super.key,
    required this.order,
  });

  @override
  State<OrderInfoWidget> createState() => OrderInfoWidgetState();
}

DateTime parseDate(String dateString) {
  return DateTime.parse(dateString).toLocal(); // Convert to local time
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd:MM:yyyy');
  return formatter.format(date);
}

class OrderInfoWidgetState extends State<OrderInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
    num allPrice = widget.order['totalsum'] - widget.order['deliverycharges'];
    DateTime orderDate = parseDate(widget.order['orderDate']);
    String formattedOrderDate = formatDate(orderDate);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        title: const Text(
          'Thông tin đơn hàng',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFEF2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 30),
            width: 40,
            height: 40,
            decoration: const ShapeDecoration(
              color: Color(0xFFFF725E),
              shape: OvalBorder(),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_pin),
                  SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
                  Text(
                    "Thông tin nhận hàng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height:
                      8), // Khoảng cách giữa dòng "Thông tin nhận hàng" và thông tin chi tiết
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.order['name']),
                  Text(widget.order['phoneNumber']),
                  Text(widget.order['address']),
                ],
              ),
              const SizedBox(
                  height:
                      10), // Khoảng cách giữa thông tin chi tiết và hình ảnh

              // CardOrder(order: widget.order)
              CardOrder(itemorders: widget.order['itemorders']),
              const Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tổng tiền hàng", style: TextStyle(fontSize: 14)),
                  Text(
                    formatCurrency.format(allPrice),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Phí vận chuyển",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(
                    formatCurrency.format(widget.order['deliverycharges']),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Thành tiền",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(
                    formatCurrency.format(widget.order['totalsum']),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
                  Text(
                    "Phương thức thanh toán",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.order['paymentMethod']),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Thời gian hoàn thành",
                      style: TextStyle(fontSize: 14)),
                  Text(
                    formattedOrderDate,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF725E),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      minimumSize: const Size(110, 41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Đánh giá',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
