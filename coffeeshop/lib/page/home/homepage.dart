import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/product/cartpage.dart';

import '../../config/config.dart';
import 'view/card_best_seller.dart';
import 'view/card_new_products.dart';
import 'view/card_news.dart';
import 'view/item_product_portfolio.dart';
import 'view/searchview.dart';

class HomePage extends StatefulWidget {
  final Function(int) changePage;
  final Function(String) changeCategory;
  const HomePage(
      {super.key, required this.changePage, required this.changeCategory});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? categorieslist;
  List? bestSellersList;
  List? newsList;

  @override
  void initState() {
    super.initState();

    _getAllCategories();
    _getProductBestSellers();
    _getProductNew();
  }

  void _getAllCategories() async {
    try {
      var response = await http.get(
        Uri.parse(getAllCategories), // Đảm bảo rằng URL này là chính xác.
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('categories')) {
          categorieslist = jsonResponse['categories'] as List;
        } else {
          categorieslist =
              []; // Đặt mặc định là một danh sách trống nếu không tìm thấy dữ liệu
          print(
              'Data key is missing or is not a list.'); // Chỉ giữ lại lệnh print này cho trường hợp cần thiết
        }
      } else {
        print(
            'Failed to load categories with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void _getProductBestSellers() async {
    try {
      var response = await http.get(
        Uri.parse(getAllProductsBestSeller),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print('123${response.statusCode.toString()}');
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          bestSellersList = jsonResponse['products'] as List;
        } else {
          bestSellersList = [];
          print('API response was not successful.');
        }
      } else {
        throw 'Failed to load best sellers: ${response.statusCode}';
      }
    } catch (e) {
      print('An error occurred while fetching best sellers: $e');
    } finally {
      setState(() {});
    }
  }

  void _getProductNew() async {
    try {
      var response = await http.get(
        Uri.parse(getAllProductsNew),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          newsList = jsonResponse['products'] as List;
        } else {
          newsList = [];
          print('API response was not successful.');
        }
      } else {
        throw 'Failed to load best sellers: ${response.statusCode}';
      }
    } catch (e) {
      print('An error occurred while fetching best sellers: $e');
    } finally {
      setState(() {});
    }
  }

  void _navigateToMenuPage(String categoryId) {
    widget.changeCategory(categoryId); // Cập nhật danh mục đã chọn
    widget.changePage(1); // Chuyển đến trang MenuPage
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFFFFEF2),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));
                    }),
              ),
            ],
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
            title: Text(
              'Xin chào bạn! ',
              style: GoogleFonts.getFont(
                'Quicksand',
                color: const Color(0xFFADB5BD),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          // Tìm kiếm sản phẩm
          const SliverToBoxAdapter(child: SearchView()),
          // Danh mục sản phẩm
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Danh mục sản phẩm',
                        style: GoogleFonts.getFont(
                          'Quicksand',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.changePage(1);
                        },
                        child: const TextQuicksand(
                          'Xem tất cả',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 0.10,
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      if (categorieslist != null && categorieslist!.isNotEmpty)
                        ...categorieslist!.map(
                          (category) => ItemsPP(
                            category: category,
                            onCategorySelected: _navigateToMenuPage,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Sản phẩm best seller
          SliverToBoxAdapter(
            child: Container(
              width: 370,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFFF725E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextQuicksand(
                          'Best seller',
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                            letterSpacing: 0.56,
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (bestSellersList != null &&
                            bestSellersList!.isNotEmpty)
                          ...bestSellersList!.map((productsbestseller) =>
                              CardBestSeller(product: productsbestseller)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Sản phẩm mới
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextQuicksand(
                        'Sản phẩm mới',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      TextQuicksand(
                        'Xem tất cả',
                        textAlign: TextAlign.right,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      if (newsList != null && newsList!.isNotEmpty)
                        ...newsList!.map((productsnew) =>
                            CardNewProducts(product: productsnew)),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Tin tức - Sự kiện
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextQuicksand(
                        'Tin tức - sự kiện',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      TextQuicksand(
                        'Xem tất cả',
                        textAlign: TextAlign.right,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 100,
                            margin: const EdgeInsets.only(left: 14, bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/news/news_1.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 14),
                            child: TextQuicksand(
                              'Các loại trà nổi tiếng nhất',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 100,
                            margin: const EdgeInsets.only(left: 20, bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/news/news_2.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: TextQuicksand(
                              'Hộp thư góp ý dịch vụ',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20) 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
