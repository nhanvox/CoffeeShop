import 'dart:convert';

import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/order/orderinfopage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../config/config.dart';
import '../../config/login_status.dart';
import 'package:http/http.dart' as http;

class OrderHistoryWidget extends StatefulWidget {
  const OrderHistoryWidget({super.key});

  @override
  State<OrderHistoryWidget> createState() => OrderHistoryWidgetState();
}

class OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  List<dynamic>? orders;

  @override
  void initState() {
    super.initState();
    _getOrdersByUser();
  }

  void _getOrdersByUser() async {
    String? userID = LoginStatus.instance.userID;
    if (userID == null) {
      print('User is not logged in');
      return;
    }
    Uri url = Uri.parse(getOdersByUser + userID);

    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Response JSON: $jsonResponse'); // Log the entire response

        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('orders')) {
          setState(() {
            orders = jsonResponse['orders'];
          });
        } else {
          setState(() {
            orders = [];
          });
          print('No orders found for this user.');
        }
      } else {
        print('Failed to load orders with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        title: const TextQuicksand(
          'LỊCH SỬ ĐƠN HÀNG',
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
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: orders == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orders?.length ?? 0,
                itemBuilder: (context, index) {
                  var order = orders![index];
                  var firstItemOrder = order['itemorders'].isNotEmpty
                      ? order['itemorders'][0]
                      : null;

                  var image = firstItemOrder != null
                      ? firstItemOrder['productid']['image']
                      : '';
                  var name = firstItemOrder != null
                      ? firstItemOrder['productid']['name']
                      : '';
                  var size =
                      firstItemOrder != null ? firstItemOrder['size'] : '';
                  var sugar =
                      firstItemOrder != null ? firstItemOrder['sugar'] : '';
                  var ice = firstItemOrder != null ? firstItemOrder['ice'] : '';
                  var quantity =
                      firstItemOrder != null ? firstItemOrder['quantity'] : 0;
                  num price = firstItemOrder['productid']['price'];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderInfoWidget(
                                  order: order,
                                  // Pass the callback
                                )),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                image,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/placeholder.png',
                                      fit: BoxFit.fill);
                                },
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextQuicksand(
                                      name,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextQuicksand(
                                          "$size,",
                                          fontSize: 16,
                                        ),
                                        TextQuicksand(
                                          "$sugar Đường,",
                                          fontSize: 16,
                                        ),
                                        TextQuicksand(
                                          "$ice Đá,",
                                          fontSize: 16,
                                        ),
                                        TextQuicksand(
                                          "x$quantity",
                                          fontSize: 18,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Builder(
                                        builder: (context) {
                                          if (firstItemOrder["size"] == 'Nhỏ') {
                                            price -= 10000;
                                          } else if (firstItemOrder["size"] ==
                                              'Lớn') {
                                            price += 10000;
                                          }

                                          return TextQuicksand(
                                            formatCurrency.format(price),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1, color: Colors.grey),
                          const Center(
                            child: TextQuicksand(
                              "Xem thêm",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          const Divider(thickness: 1, color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextQuicksand("${order['quantitysum']} sản phẩm",
                                  fontSize: 17),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Thành tiền: ",
                                      style: GoogleFonts.getFont('Quicksand',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: formatCurrency
                                          .format(order['totalsum']),
                                      style: GoogleFonts.getFont('Quicksand',
                                          fontSize: 20,
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
                              TextQuicksand(order['status'],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import '../../config/config.dart';
// import 'package:http/http.dart' as http;

// import '../../config/login_status.dart';

// class OrderHistoryWidget extends StatefulWidget {
//   final String initialStatus;
//   const OrderHistoryWidget({super.key, required this.initialStatus});

//   @override
//   State<OrderHistoryWidget> createState() => OrderHistoryWidgetState();
// }

// class OrderHistoryWidgetState extends State<OrderHistoryWidget> {
//   String selectedStatus = 'Chờ Xác Nhận';
//   List<dynamic>? orders;

//   @override
//   void initState() {
//     super.initState();
//     _handleCategorySelected(widget.initialStatus);
//   }

//   void _handleCategorySelected(String status) {
//     setState(() {
//       selectedStatus = status;
//     });
//     _getOrdersByStatus(status);
//   }

//   void _getOrdersByUser() async {
//     String? userID = LoginStatus.instance.userID;
//     if (userID == null) {
//       print('User is not logged in');
//       return;
//     }
//     Uri url = Uri.parse(getOdersByUser + userID);

//     try {
//       var response =
//           await http.get(url, headers: {"Content-Type": "application/json"});

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         print('Response JSON: $jsonResponse'); // Log the entire response

//         if (jsonResponse['success'] == true &&
//             jsonResponse.containsKey('orders')) {
//           setState(() {
//             orders = jsonResponse['orders'];
//           });
//         } else {
//           setState(() {
//             orders = [];
//           });
//           print('No orders found for this user.');
//         }
//       } else {
//         print('Failed to load orders with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('An error occurred while fetching orders: $e');
//     }
//   }

//   void _getOrdersByStatus(String status) async {
//     Uri url = Uri.parse(getOrdersByStatus + status);

//     try {
//       var response =
//           await http.get(url, headers: {"Content-Type": "application/json"});

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         print('API Response: $jsonResponse'); // Debug print
//         if (jsonResponse['success'] == true &&
//             jsonResponse.containsKey('orders')) {
//           setState(() {
//             orders = jsonResponse['orders'];
//           });
//         } else {
//           setState(() {
//             orders = [];
//           });
//           print('No orders found for this status.');
//         }
//       } else {
//         print('Failed to load orders with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('An error occurred while fetching orders: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final formatCurrency =
//         NumberFormat.simpleCurrency(locale: 'vi_VN', name: 'VND');
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFEF2),
//       appBar: AppBar(
//         title: const Text('LỊCH SỬ ĐƠN HÀNG',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
//         centerTitle: true,
//         backgroundColor: const Color(0xFFFFFEF2),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           iconSize: 36,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(right: 30),
//             width: 40,
//             height: 40,
//             decoration: const ShapeDecoration(
//               color: Color(0xFFFF725E),
//               shape: OvalBorder(),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.shopping_bag, color: Colors.white),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Danh mục trạng thái',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600)),
//               ],
//             ),
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 const SizedBox(width: 30),
//                 _statusButton('Chờ Xác Nhận'),
//                 const SizedBox(width: 10),
//                 _statusButton('Đã Xác Nhận'),
//                 const SizedBox(width: 10),
//                 _statusButton('Hoàn Thành'),
//                 const SizedBox(width: 10),
//                 _statusButton('Đã Hủy'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               alignment: Alignment.center,
//               child: orders == null
//                   ? const Center(child: CircularProgressIndicator())
//                   : ListView.builder(
//                       itemCount: orders?.length ?? 0,
//                       itemBuilder: (context, index) {
//                         var order = orders![index];
//                         var itemOrders = order['itemorders'];
//                         if (itemOrders == null || itemOrders.isEmpty) {
//                           return const SizedBox.shrink();
//                         }
//                         var firstItemOrder = itemOrders[0];
//                         var productid = firstItemOrder['productid'];
//                         var image = productid?['image'] ?? '';
//                         var name = productid?['name'] ?? '';
//                         var size = firstItemOrder['size'] ?? '';
//                         var sugar = firstItemOrder['sugar'] ?? '';
//                         var ice = firstItemOrder['ice'] ?? '';
//                         var quantity = firstItemOrder['quantity'] ?? 0;
//                         num price = productid?['price'] ?? 0;

//                         return GestureDetector(
//                           onTap: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //       builder: (context) =>
//                             //           OrderInfoWidget(orders: orders!)),
//                             // );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(15),
//                             margin: const EdgeInsets.symmetric(vertical: 5),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.grey[300]!),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Color(0x3F000000),
//                                   blurRadius: 4,
//                                   offset: Offset(0, 4),
//                                   spreadRadius: 0,
//                                 )
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Image.network(
//                                       image,
//                                       fit: BoxFit.fill,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return Image.asset(
//                                             'assets/images/placeholder.png',
//                                             fit: BoxFit.fill);
//                                       },
//                                       width: 100,
//                                       height: 100,
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(name,
//                                               style: const TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.w600)),
//                                           const SizedBox(height: 5),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                   "$size, $sugar Đường, $ice Đá,",
//                                                   style: const TextStyle(
//                                                       fontSize: 16)),
//                                               Text("x$quantity",
//                                                   style: const TextStyle(
//                                                       fontSize: 18)),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 5),
//                                           Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Builder(
//                                               builder: (context) {
//                                                 if (firstItemOrder["size"] ==
//                                                     'Nhỏ') {
//                                                   price -= 10000;
//                                                 } else if (firstItemOrder[
//                                                         "size"] ==
//                                                     'Lớn') {
//                                                   price += 10000;
//                                                 }

//                                                 return Text(
//                                                     formatCurrency
//                                                         .format(price),
//                                                     style: const TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors.black));
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Divider(thickness: 1),
//                                 const Center(
//                                   child: Text("Xem thêm",
//                                       style: TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.grey)),
//                                 ),
//                                 const Divider(thickness: 1),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("${order['quantitysum']} sản phẩm",
//                                         style: const TextStyle(fontSize: 16)),
//                                     RichText(
//                                       text: TextSpan(
//                                         children: [
//                                           const TextSpan(
//                                               text: "Thành tiền: ",
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.black)),
//                                           TextSpan(
//                                               text: formatCurrency
//                                                   .format(order['totalsum']),
//                                               style: const TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.red)),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Divider(thickness: 1),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(order['status'],
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.green)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   TextButton _statusButton(String status) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//         backgroundColor: selectedStatus == status
//             ? const Color(0xFF2A4261)
//             : const Color(0xFFE3E3E3),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       ),
//       onPressed: () => _handleCategorySelected(status),
//       child: Text(
//         status,
//         textAlign: TextAlign.center,
//         style: GoogleFonts.quicksand(
//           color: selectedStatus == status ? Colors.white : Colors.black,
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }