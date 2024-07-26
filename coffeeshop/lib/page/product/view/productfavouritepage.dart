import 'dart:convert';

import 'package:coffeeshop/config/login_status.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
// import 'package:coffeeshop/page/menu/view/card_menu.dart';
import 'package:coffeeshop/page/product/view/card_fav_product.dart';
import 'package:http/http.dart' as http;

import 'package:coffeeshop/config/config.dart';
import 'package:coffeeshop/page/product/cartpage.dart';
import 'package:flutter/material.dart';

class ProductFavouritePage extends StatefulWidget {
  const ProductFavouritePage({super.key});

  @override
  State<ProductFavouritePage> createState() => _ProductFavouritePageState();
}

class _ProductFavouritePageState extends State<ProductFavouritePage> {
  List? favproductsList;
  @override
  void initState() {
    super.initState();
    _getProductFavByUser();
  }

  Future<void> _getProductFavByUser() async {
    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      return;
    }

    Uri url = Uri.parse(getFavProductsByUser + userID);

    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('favproduct')) {
          print('API response was successful.');
          favproductsList = jsonResponse['favproduct'];
          // print(favproductsList);
        } else {
          favproductsList = [];
          print('API response was not successful.');
        }
      } else {
        throw 'Failed to load fav products: ${response.statusCode}';
      }
    } catch (e) {
      print('An error occurred while fetching fav products: $e');
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFFFFEF2),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                iconSize: 36,
              ),
            ),
            centerTitle: true,
            title: const TextQuicksand(
              'SẢN PHẨM YÊU THÍCH',
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 0,
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
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    }),
              ),
            ],
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: favproductsList != null
                    ? favproductsList!
                        .map((favproduct) =>
                            CardFavProduct(favproduct: favproduct))
                        .toList()
                    : [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Center(
                            child: Image.asset(
                              'assets/images/emptyfav.png',
                              height: 350,
                              fit: BoxFit
                                  .contain, // Adjusts the image to fit within the specified height
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
