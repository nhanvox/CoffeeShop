import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../../config/login_status.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  String? email;
  Map<String, dynamic>? user;
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_loadUserInfo();
  }

  // void _loadUserInfo() async {
  //   if (LoginStatus.instance.loggedIn) {
  //     final userId = LoginStatus.instance.userID;

  //     if (userId != null) {
  //       final url = '$getUserInfoById$userId';
  //       final response = await http.get(
  //         Uri.parse(url),
  //         headers: {"Content-Type": "application/json"},
  //       );

  //       if (response.statusCode == 200) {
  //         final jsonResponse = jsonDecode(response.body);
  //         if (jsonResponse['status'] == true) {
  //           setState(() {
  //             user = jsonResponse['userInfo'];
  //             email = user?['email'];
  //           });
  //         } else {
  //           print('Failed to load user name');
  //         }
  //       } else {
  //         print(
  //             'Failed to load user info with status code: ${response.statusCode}');
  //       }
  //     }
  //   }
  // }

  Future<void> _changePass() async {
    String? userId = LoginStatus.instance.userID;

    if (userId == null) return;

    if (_newPassController.text != _confirmPassController.text) {
      _showErrorDialog(context, "Mật khẩu mới và mật khẩu xác nhận không khớp");
      return;
    }

    final data = {
      'currentPassword': _currentPassController.text,
      'newPassword': _newPassController.text,
      'confirmPassword':
          _confirmPassController.text, // Add confirmPassword here
    };

    try {
      Uri changepass = Uri.parse('$changePass$userId');
      var changepassResponse = await http.put(
        changepass,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print('Response status: ${changepassResponse.statusCode}');
      print('Response body: ${changepassResponse.body}');

      if (changepassResponse.statusCode == 200) {
        var jsonResponse = jsonDecode(changepassResponse.body);
        if (jsonResponse['status'] == true) {
          _showUpdateSuccessDialog(context);
        } else {
          _showErrorDialog(context, jsonResponse['message']);
        }
      } else if (changepassResponse.statusCode == 500) {
        _showErrorDialog(context, 'Server error: Please try again later.');
      } else {
        _showErrorDialog(context,
            'Failed to update profile with status code: ${changepassResponse.statusCode}');
      }
    } catch (e) {
      print('Error updating profile: $e');
      _showErrorDialog(context, 'Error updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFFFEDED),
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlexibleSpaceBar(
                    titlePadding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    centerTitle: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const TextQuicksand(
                            'Hủy',
                            textAlign: TextAlign.center,
                            color: Color(0xFFB0B0B0),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextQuicksand(
                          'ĐỔI MẬT KHẨU',
                          textAlign: TextAlign.center,
                          color: Color(0xFFFF725E),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        TextButton(
                          onPressed: () {
                            _changePass();
                          },
                          child: const TextQuicksand(
                            'Lưu',
                            textAlign: TextAlign.center,
                            color: Color(0xFF9290FF),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD5D5D5),
                    thickness: 1,
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    _buildTextField('Mật khẩu hiện tại', _currentPassController,
                        obscureText: true),
                    _buildTextField('Mật khẩu mới', _newPassController,
                        obscureText: true),
                    _buildTextField(
                        'Xác nhận mật khẩu mới', _confirmPassController,
                        obscureText: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.getFont(
          'Quicksand',
          color: Colors.black,
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.getFont(
            'Quicksand',
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD5D5D5)),
          ),
        ),
      ),
    );
  }

  void _showUpdateSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 300,
                height: 180,
                margin: const EdgeInsets.only(top: 38),
                padding: const EdgeInsets.only(right: 30, left: 30, top: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Cập nhật thành công!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF725E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: const Text(
                          'Tiếp tục',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/check_mark.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
