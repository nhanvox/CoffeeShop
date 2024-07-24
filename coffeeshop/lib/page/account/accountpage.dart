import 'dart:convert';
import 'package:coffeeshop/config/config.dart';
import 'package:coffeeshop/config/login_status.dart';
import 'package:coffeeshop/page/account/updateaccountpage.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../config/authservice.dart';
import '../order/orderhistorypage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? userName;
  String? name;
  String? image;
  Map<String, dynamic>? profile;
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _getProfile();
    _loadUserInfo();
  }

  void _logout(BuildContext context) async {
    await AuthService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
    );
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
              name = profile?['name'];
              image = profile?['image'];
            });
          } else {
            print('Failed to load user');
          }
        }
      }
    }
  }

  void _loadUserInfo() async {
    if (LoginStatus.instance.loggedIn) {
      final userId = LoginStatus.instance.userID;

      if (userId != null) {
        final url = '$getUserInfoById$userId';
        final response = await http.get(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status'] == true) {
            setState(() {
              user = jsonResponse['userInfo'];
              userName = user?['email'];
            });
          } else {
            print('Failed to load user name');
          }
        } else {
          print(
              'Failed to load user info with status code: ${response.statusCode}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background_account.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 40,
                  right: 40,
                  child: Container(
                    width: 360,
                    height: 110,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFF2D8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          // Display profile image
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: user != null && image != ''
                                    ? NetworkImage(image!)
                                    : const AssetImage(
                                            'assets/images/avatar_default.png')
                                        as ImageProvider,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display user name
                                TextQuicksand(
                                  name ?? 'Tên người dùng',
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                TextQuicksand(
                                  LoginStatus.instance.loggedIn
                                      ? userName ?? 'Người dùng'
                                      : 'Đăng nhập/ Đăng ký',
                                  color: const Color(0x991B1B1B),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Account section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextQuicksand(
                    'Tài khoản',
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  Container(
                    height: 228,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFF2D8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Update Info
                        ListTile(
                          title: Text(
                            'Cập nhật thông tin',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.account_circle_rounded,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const UpdateAccountPage(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        // Payment Methods
                        ListTile(
                          title: Text(
                            'Phương thức thanh toán',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.credit_card,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                        ),
                        _buildDivider(),
                        // Order History
                        ListTile(
                          title: Text(
                            'Lịch sử đặt hàng',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.history_outlined,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const OrderHistoryWidget(),
                              ),
                            );
                          },
                        ),
                        _buildDivider(),
                        // Offers
                        ListTile(
                          title: Text(
                            'Ưu đãi',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.stars_rounded,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Other section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Other',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    height: 185,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFF2D8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Notifications
                        ListTile(
                          title: Text(
                            'Thông báo',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.notifications,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                        ),
                        _buildDivider(),
                        // About
                        ListTile(
                          title: Text(
                            'Giới thiệu',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.error,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                        ),
                        _buildDivider(),
                        // Logout
                        ListTile(
                          title: Text(
                            LoginStatus.instance.loggedIn
                                ? 'Đăng xuất'
                                : 'Đăng nhập',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.logout,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                          onTap: () => _logout(context),
                        ),
                        _buildDivider(),
                      ],
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

  TextStyle _textStyle() {
    return GoogleFonts.getFont(
      'Quicksand',
      color: Colors.black,
      fontSize: 19,
      fontWeight: FontWeight.w700,
      height: 0.07,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      color: Color(0xFFD5D5D5),
      thickness: 1,
    );
  }
}
