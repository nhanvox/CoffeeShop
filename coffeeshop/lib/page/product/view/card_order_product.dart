import 'dart:convert';
import 'package:coffeeshop/config/config.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../update_cart.dart';

class CardOrderProduct extends StatefulWidget {
  final Map cart;
  final Function onUpdate; // Callback function to notify CartPage
  const CardOrderProduct({
    super.key,
    required this.cart,
    required this.onUpdate,
  });

  @override
  State<CardOrderProduct> createState() => _CardOrderProductState();
}

class _CardOrderProductState extends State<CardOrderProduct> {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');

  Future<void> _updateCart(
      String cartId, Map<String, dynamic> updateData) async {
    Uri url = Uri.parse(updateCart + cartId);
    try {
      var response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          setState(() {
            widget.cart.addAll(updateData);
          });
          widget.onUpdate(); // Notify CartPage to refresh
          print('Product updated successfully.');
        } else {
          print('Failed to update product.');
        }
      } else {
        print(
            'Failed to update product with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while updating product: $e');
    }
  }

  Future<void> _deleteCart(String cartId) async {
    Uri url = Uri.parse(deleteCart + cartId);
    try {
      var response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          widget.onUpdate(); // Notify CartPage to refresh
          print('Product deleted successfully.');
        } else {
          print('Failed to delete product.');
        }
      } else {
        print(
            'Failed to delete product with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while deleting product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.cart['productid']['image'],
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/placeholder.png',
                              fit: BoxFit.fill);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.cart['productid']['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.getFont(
                                'Quicksand',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              iconSize: 20,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'details',
                                  child:
                                      const TextQuicksand('Chi tiết đơn hàng'),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateCartPage(cart: widget.cart,),
                                      ),
                                    );
                                    if (result != null) {
                                      _updateCart(widget.cart['_id'], result);
                                    }
                                  },
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: const TextQuicksand('Xóa sản phẩm'),
                                  onTap: () {
                                    _deleteCart(widget.cart['_id']);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextQuicksand(
                          'Số lượng: ${widget.cart['quantity']}',
                          textAlign: TextAlign.left,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        TextQuicksand(
                          'Size: ${widget.cart['size']}',
                          textAlign: TextAlign.left,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        TextQuicksand(
                          'Đường: ${widget.cart['sugar']}',
                          textAlign: TextAlign.left,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextQuicksand(
                              'Đá: ${widget.cart['ice']}',
                              textAlign: TextAlign.left,
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                formatCurrency.format(widget.cart['total']),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }
}
