import 'package:coffeeshop/page/login/view/components/quicksand.dart';
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
        title: const TextQuicksand(
          'THÔNG TIN ĐƠN HÀNG',
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFEF2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 36,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.location_pin),
              SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
              TextQuicksand(
                "Thông tin nhận hàng",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ],
          ),
          const SizedBox(
              height:
                  8), // Khoảng cách giữa dòng "Thông tin nhận hàng" và thông tin chi tiết
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextQuicksand(
                "Nguyễn Văn A",
                fontSize: 15,
              ),
              TextQuicksand(
                "0987654321",
                fontSize: 15,
              ),
              TextQuicksand(
                "231/b, baba, TP. Hồ Chí Minh",
                fontSize: 15,
              ),
            ],
          ),
          const SizedBox(
              height: 10), // Khoảng cách giữa thông tin chi tiết và hình ảnh
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 130,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "https://product.hstatic.net/1000075078/product/1719200008_vai_b0c6ec50931045998b8d7cfbdd40b631.jpg",
                              width: 130,
                              height: 130,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: SizedBox(
                                height: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextQuicksand(
                                          "Oolong Tứ Quý Sen",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextQuicksand(
                                                "Vừa, 100% đường, 100% đá",
                                                fontSize: 14),
                                            TextQuicksand("x1", fontSize: 14),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextQuicksand(
                                        "59.000đ",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "https://product.hstatic.net/1000075078/product/1719200008_vai_b0c6ec50931045998b8d7cfbdd40b631.jpg",
                              width: 130,
                              height: 130,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: SizedBox(
                                height: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextQuicksand(
                                          "Oolong Tứ Quý Sen",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextQuicksand(
                                                "Vừa, 100% đường, 100% đá",
                                                fontSize: 14),
                                            TextQuicksand("x1", fontSize: 14),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextQuicksand(
                                        "59.000đ",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
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
          ),

          const Divider(thickness: 1),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextQuicksand("Tổng tiền hàng", fontSize: 18),
              TextQuicksand(
                "59.000đ",
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextQuicksand("Phí vận chuyển", fontSize: 18),
              TextQuicksand(
                "0đ",
                fontSize: 20,
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextQuicksand(
                "Thành tiền",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
              TextQuicksand(
                "59.000đ",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(
              height: 7), // Khoảng cách giữa thông tin chi tiết và hình ảnh
          const Row(
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
          const SizedBox(
              height:
                  3), // Khoảng cách giữa dòng "Thông tin nhận hàng" và thông tin chi tiết
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextQuicksand(
                "Thanh toán khi nhận hàng",
                fontSize: 18,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextQuicksand("Thời gian hoàn thành", fontSize: 16),
              Text(
                "05-06-2024",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                    0xFFFF725E), // Đổi từ backgroundColor thành primary
                padding: const EdgeInsets.symmetric(
                    vertical: 08, horizontal: 16), // Thêm padding ngang
                minimumSize: const Size(130, 20), // Đặt kích thước tối thiểu
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Đặt border radius là 5
                ),
              ),
              child: const TextQuicksand(
                'ĐÁNH GIÁ',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
