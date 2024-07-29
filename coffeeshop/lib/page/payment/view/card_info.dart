import 'dart:convert';

import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/payment/view/change_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';
import '../../../config/login_status.dart';

class CardInfo extends StatefulWidget {
  const CardInfo({
    super.key,
  });

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  String? name;
  String? phoneNumber;
  String? address;
  Map<String, dynamic>? profile;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() async {
    if (LoginStatus.instance.loggedIn) {
      final userId = LoginStatus.instance.userID;
      if (userId != null) {
        final url = '$getProfileByUser$userId';
        final response = await http.get(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['success'] == true) {
            setState(() {
              profile = jsonResponse['profile'];
              name = profile!['name'];

              phoneNumber = profile!['phoneNumber'];
              address = profile!['address'];
            });
          } else {
            print('Failed to load user');
          }
        }
      }
    }
  }

  void _openIconButtonPressed() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          expand: true,
          builder: (context, scrollController) {
            return const ChangeInfo();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextQuicksand(
                  'Thông tin nhận hàng',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Container(width: 40),
                TextButton(
                  //onPressed: () {},
                  onPressed: _openIconButtonPressed,
                  child: const TextQuicksand(
                    'Thay đổi',
                    color: Colors.deepOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextQuicksand(
                  name ?? 'Tên người dùng',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                TextQuicksand(
                  phoneNumber ?? 'Số điện thoại',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextQuicksand(
                  address ?? 'Địa chỉ',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: 'Thêm hướng dẫn giao hàng',
                hintStyle: GoogleFonts.getFont('Quicksand', color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
