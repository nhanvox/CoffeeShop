import 'dart:convert';

import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/product/cartpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../home/view/searchview.dart';
import 'view/card_menu.dart';

class MenuPage extends StatefulWidget {
  final String initialCategoryId;
  const MenuPage({super.key, required this.initialCategoryId});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategoryId = 'all';
  List? categorieslist;
  List? productsList;
  @override
  void initState() {
    super.initState();
    _handleCategorySelected(widget.initialCategoryId);
    _getAllCategories();
    _getProductsByCategory('all');
  }

  void _getAllCategories() async {
    try {
      var response = await http.get(
        Uri.parse(getAllCategories),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('categories')) {
          var dynamicCategories =
              List<Map<String, dynamic>>.from(jsonResponse['categories']);
          var stringCategories = convertDynamicToStringList(dynamicCategories);

          categorieslist = [
                {'name': 'Tất cả', '_id': 'all'}
              ] +
              stringCategories;
        } else {
          categorieslist = [
            {'name': 'Tất cả', '_id': 'all'}
          ];
          print('Data key is missing or is not a list.');
        }
      } else {
        print(
            'Failed to load categories with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      setState(() {});
    }
  }

  void _getProductsByCategory(String categoryId) async {
    Uri url;
    if (categoryId == 'all') {
      url = Uri.parse(getAllProducts);
    } else {
      url = Uri.parse(getProductsByCategory + categoryId);
    }

    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('products')) {
          productsList = jsonResponse['products'];
        } else {
          productsList = []; // Không tìm thấy sản phẩm
          print('No products found for this category or request.');
        }
      } else {
        print(
            'Failed to load products with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching products: $e');
    } finally {
      setState(() {});
    }
  }

  void _handleCategorySelected(String categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
    });
    _getProductsByCategory(categoryId);
  }

  List<Map<String, String>> convertDynamicToStringList(
      List<dynamic> dynamicList) {
    return dynamicList.map((dynamic item) {
      var mapItem = item as Map<String, dynamic>;
      return mapItem.map((key, value) => MapEntry(key, value.toString()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFFFFEF2),
            surfaceTintColor: const Color(0xFFFFFEF2),
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
                  },
                ),
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
            centerTitle: true,
            title: Text(
              'MENU',
              style: GoogleFonts.getFont(
                'Quicksand',
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            floating: true,
            pinned: true,
          ),
          const SliverToBoxAdapter(child: SearchView()),
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFFFFEF2),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextQuicksand(
                          'Danh mục sản phẩm',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        if (categorieslist != null &&
                            categorieslist!.isNotEmpty)
                          ...categorieslist!.map(
                            (category) => ItemsMN(
                              category: category,
                              isSelected: category['_id'] == selectedCategoryId,
                              onPressed: () =>
                                  _handleCategorySelected(category['_id']),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: productsList != null
                    ? productsList!
                        .map((product) => CardMenu(product: product))
                        .toList()
                    : [const Text('No products')],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemsMN extends StatelessWidget {
  final Map category;
  final bool isSelected;
  final VoidCallback onPressed;
  const ItemsMN({
    super.key,
    required this.category,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          backgroundColor:
              isSelected ? const Color(0xFF2A4261) : const Color(0xFFE3E3E3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          category['name'],
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Quicksand',
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    );
  }
}
