import 'package:flutter/material.dart';

class OrderInfoWidget extends StatefulWidget {
  const OrderInfoWidget({super.key});

  @override
  State<OrderInfoWidget> createState() => OrderInfoWidgetState();
}

class OrderInfoWidgetState extends State<OrderInfoWidget> {
  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          itemCount: 1, // Số lượng mục bạn muốn hiển thị
          itemBuilder: (context, index) {
            return GestureDetector(
              child: itemListView('Item $index'),
            ); // Truyền cứng dữ liệu vào itemListView
          },
        ),
      ),
    );
  }

  Widget itemListView(String data) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!), // Thêm viền màu xám nhạt
        borderRadius: BorderRadius.circular(10), // Bo tròn các góc
      ),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nguyễn Văn A"),
              Text("0987654321"),
              Text("231/b, baba, TP. Hồ Chí Minh"),
            ],
          ),
          const SizedBox(
              height: 10), // Khoảng cách giữa thông tin chi tiết và hình ảnh
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://product.hstatic.net/1000075078/product/1719200008_vai_b0c6ec50931045998b8d7cfbdd40b631.jpg",
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Oolong Tứ Quý Sen",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Vừa, 100% đường, 100% đá",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "x1",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "59.000đ",
                        style: TextStyle(
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tổng tiền hàng", style: TextStyle(fontSize: 14)),
              Text(
                "59.000đ",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Phí vận chuyển", style: TextStyle(fontSize: 14)),
              Text(
                "0đ",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Thành tiền",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(
                "59.000đ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 7), // Khoảng cách giữa thông tin chi tiết và hình ảnh
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
          const SizedBox(
              height:
                  3), // Khoảng cách giữa dòng "Thông tin nhận hàng" và thông tin chi tiết
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Thanh toán khi nhận hàng"),
            ],
          ),
          const SizedBox(height: 7),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Thời gian hoàn thành", style: TextStyle(fontSize: 14)),
              Text(
                "05-06-2024",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Căn lề phải
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFFFF725E), // Đổi từ backgroundColor thành primary
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16), // Thêm padding ngang
                  minimumSize: const Size(110, 41), // Đặt kích thước tối thiểu
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Đặt border radius là 5
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
      ),
    );
  }
}
