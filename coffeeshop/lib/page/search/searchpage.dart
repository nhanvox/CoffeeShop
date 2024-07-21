import 'dart:convert';

import 'package:coffeeshop/page/search/view/item_keyword.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../menu/view/card_menu.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllProducts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _getAllProducts() async {
    try {
      var response = await http.get(
        Uri.parse(getAllProducts),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          setState(() {
            products = jsonResponse['products'];
            filteredProducts = products;
          });
        } else {
          print('API response was not successful.');
        }
      } else {
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching products: $e');
    }
  }

  void _onSearchChanged() {
    if (searchController.text.isEmpty) {
      setState(() {
        filteredProducts = products;
      });
    } else {
      _filterProducts(searchController.text);
    }
  }

  void _filterProducts(String query) {
    List<dynamic> tempList = [];
    for (dynamic product in products) {
      if (product['name'].toLowerCase().contains(query.toLowerCase())) {
        tempList.add(product);
      }
    }
    setState(() {
      filteredProducts = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverAppBar(
              backgroundColor: const Color(0xFFFFFEF2),
              actions: [
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 30),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF725E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.tune,
                      size: 29,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200, // Màu nền của TextFormField
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Tìm kiếm sản phẩm',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Bo tròn góc
                    borderSide: BorderSide.none, // Loại bỏ đường viền
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Từ khoá gợi ý',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        ItemKeyword(itemname: 'Frosty'),
                        ItemKeyword(itemname: 'Trà'),
                        ItemKeyword(itemname: 'Cà phê'),
                        ItemKeyword(itemname: 'Bạc xỉu'),
                        ItemKeyword(itemname: 'Cà phê phin'),
                        ItemKeyword(itemname: 'Cappuccino'),
                        ItemKeyword(itemname: 'Espresso'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: filteredProducts.isNotEmpty
                      ? filteredProducts
                          .map((product) => CardMenu(product: product))
                          .toList()
                      : [const Text('No products')],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
