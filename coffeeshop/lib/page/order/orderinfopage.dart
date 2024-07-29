import 'package:coffeeshop/page/login/view/components/quicksand.dart';
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
        title: const TextQuicksand(
          'THÔNG TIN ĐƠN HÀNG',
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFEF2),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 34,
          ),
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
                  TextQuicksand(
                    "Thông tin nhận hàng",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ],
              ),
              const SizedBox(
                  height:
                      8), // Khoảng cách giữa dòng "Thông tin nhận hàng" và thông tin chi tiết
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextQuicksand(
                    widget.order['name'],
                    fontSize: 16,
                  ),
                  TextQuicksand(
                    widget.order['phoneNumber'],
                    fontSize: 16,
                  ),
                  TextQuicksand(
                    widget.order['address'],
                    fontSize: 16,
                  ),
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
                  const TextQuicksand("Tổng tiền hàng", fontSize: 18),
                  TextQuicksand(
                    formatCurrency.format(allPrice),
                    fontSize: 18,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextQuicksand("Phí vận chuyển",
                      fontSize: 18, fontWeight: FontWeight.w600),
                  Text(
                    formatCurrency.format(widget.order['deliverycharges']),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextQuicksand("Thành tiền",
                      fontSize: 18, fontWeight: FontWeight.w600),
                  TextQuicksand(
                    formatCurrency.format(widget.order['totalsum']),
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
                  TextQuicksand(
                    "Phương thức thanh toán",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextQuicksand(
                    widget.order['paymentMethod'],
                    fontSize: 18,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextQuicksand(
                    "Thời gian hoàn thành",
                    fontSize: 18,
                  ),
                  TextQuicksand(
                    formattedOrderDate,
                    fontSize: 18,
                    color: Colors.green,
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
                          vertical: 8, horizontal: 16),
                      minimumSize: const Size(110, 41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const TextQuicksand(
                      'Đánh giá',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
