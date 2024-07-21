import 'package:coffeeshop/page/order/orderinfopage.dart';
import 'package:flutter/material.dart';

class OrderHistoryWidget extends StatefulWidget {
  const OrderHistoryWidget({super.key});

  @override
  State<OrderHistoryWidget> createState() => OrderHistoryWidgetState();
}

class OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Oolong Tứ Quý Sen',
      'details': 'Vừa, 100% đường, 100% đá',
      'quantity': 1,
      'price': '59.000đ',
      'totalPrice': '59.000đ',
      'status': 'Giao hàng thành công',
      'imageUrl':
          'https://product.hstatic.net/1000075078/product/1719200008_vai_b0c6ec50931045998b8d7cfbdd40b631.jpg',
    },
    {
      'title': 'Hi Tea Đào',
      'details': 'Vừa, 100% đường, 100% đá',
      'quantity': 2,
      'price': '49.000đ',
      'totalPrice': '108.000đ',
      'status': 'Giao hàng thành công',
      'imageUrl':
          'https://product.hstatic.net/1000075078/product/1669737919_hi-tea-dao_16b24efb87b945d89cf4011a0a3babf1.jpg', // Update this to the second product's image if available
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        title: const Text(
          'Lịch sử đơn hàng',
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
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderInfoWidget()),
                );
              },
              child: itemListView(products[index]),
            );
          },
        ),
      ),
    );
  }

  Widget itemListView(Map<String, dynamic> product) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product['imageUrl'],
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['title'],
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['details'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "x${product['quantity']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        product['price'],
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
          const Divider(thickness: 1),
          const Center(
            child: Text("Xem thêm", style: TextStyle(fontSize: 14)),
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${product['quantity']} sản phẩm",
                  style: const TextStyle(fontSize: 14)),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Thành tiền: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: product['totalPrice'],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                product['status'],
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
