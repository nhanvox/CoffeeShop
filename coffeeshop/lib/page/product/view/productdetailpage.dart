import 'package:coffeeshop/page/product/cartpage.dart';
import 'package:coffeeshop/page/product/view/sizeoption.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  final Map product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSize = 1;
  int quantity = 1;

  int productsugarselected = 2;
  int producticeselected = 2;
  bool productisfavorite = false;

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
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
            title: Text(
              widget.product['name'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
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
                      Navigator.push(
                        context,
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
          //Ảnh sản phẩm
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Stack(
                children: [
                  Container(
                    height: 318,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.product['image'],
                        ),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 25,
                    child: IconButton(
                      icon: Icon(
                        productisfavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: const Color(0xff2A4261),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                            spreadRadius: 0,
                          )
                        ],
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          productisfavorite = !productisfavorite;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product['description'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          )),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(
              'Chọn kích cỡ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizeOption(
                    label: 'Nhỏ',
                    icon: Icons.local_cafe,
                    iconSize: 24.0,
                    isSelected: selectedSize == 0,
                    onTap: () => setState(() {
                      selectedSize = 0;
                    }),
                  ),
                  SizeOption(
                    label: 'Vừa',
                    icon: Icons.local_cafe,
                    iconSize: 34.0,
                    isSelected: selectedSize == 1,
                    onTap: () => setState(() {
                      selectedSize = 1;
                    }),
                  ),
                  SizeOption(
                    label: 'Lớn',
                    icon: Icons.local_cafe,
                    iconSize: 44.0,
                    isSelected: selectedSize == 2,
                    onTap: () => setState(() {
                      selectedSize = 2;
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(
              'Đường',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('30%'),
                    value: 1,
                    groupValue: productsugarselected,
                    onChanged: (int? value) {
                      setState(() {
                        productsugarselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('50%'),
                    value: 2,
                    groupValue: productsugarselected,
                    onChanged: (int? value) {
                      setState(() {
                        productsugarselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('100%'),
                    value: 3,
                    groupValue: productsugarselected,
                    onChanged: (int? value) {
                      setState(() {
                        productsugarselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(
              'Đá',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('30%'),
                    value: 1,
                    groupValue: producticeselected,
                    onChanged: (int? value) {
                      setState(() {
                        producticeselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('50%'),
                    value: 2,
                    groupValue: producticeselected,
                    onChanged: (int? value) {
                      setState(() {
                        producticeselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('100%'),
                    value: 3,
                    groupValue: producticeselected,
                    onChanged: (int? value) {
                      setState(() {
                        producticeselected = value!;
                      });
                    },
                    activeColor: const Color(0xFFFF725E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                    child: Container(
                      decoration: const ShapeDecoration(
                          color: Color.fromARGB(255, 89, 119, 159),
                          shape: CircleBorder()),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(quantity.toString(),
                      style: const TextStyle(fontSize: 34)),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: Container(
                      decoration: const ShapeDecoration(
                          color: Color.fromARGB(255, 89, 119, 159),
                          shape: CircleBorder()),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 60,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF725E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    formatCurrency.format(widget.product['price']),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
