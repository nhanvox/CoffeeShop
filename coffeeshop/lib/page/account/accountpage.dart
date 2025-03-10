import 'dart:convert';
import 'dart:io';
import 'package:coffeeshop/config/config.dart';
import 'package:coffeeshop/config/login_status.dart';
import 'package:coffeeshop/page/account/updateaccountpage.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:coffeeshop/page/product/view/productfavouritepage.dart';
import 'package:coffeeshop/page/tutorial/tutorial.dart';
import 'package:coffeeshop/page/voucher/voucher_page.dart';
import 'package:coffeeshop/theme.dart';
import 'package:coffeeshop/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String selectedStatus = 'Chờ Xác Nhận';
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
              name = profile!['name'];
              image = profile!['image'];
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
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final colorbg =
        isDarkMode ? const Color(0xff2A4261) : const Color(0xFFFFFEF2);
    final colorbg2 =
        isDarkMode ? const Color(0xff17273B) : const Color(0xFFFFFEF2);
    return Container(
      decoration: BoxDecoration(color: colorbg),
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 210,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background_account.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 15,
                        offset: Offset(0, 40),
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
                      color: colorbg2,
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
                                image: profile != null && image != ''
                                    ? (image!.startsWith('http')
                                        ? NetworkImage(image!)
                                        : FileImage(File(image!))
                                            as ImageProvider)
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
                                  (profile != null && name != '')
                                      ? name ?? 'Tên người dùng'
                                      : 'Người dùng',
                                  color: textColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                TextQuicksand(
                                  LoginStatus.instance.loggedIn
                                      ? userName ?? 'Người dùng'
                                      : 'Đăng nhập/ Đăng ký',
                                  color: textColor,
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
                  TextQuicksand(
                    'Tài khoản',
                    textAlign: TextAlign.center,
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  Container(
                    height: 228,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: ShapeDecoration(
                      color: colorbg2,
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
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const UpdateAccountPage(),
                              ),
                            );
                            if (result == true) {
                              _getProfile();
                              _loadUserInfo();
                            }
                          },
                        ),
                        _buildDivider(),
                        // Payment Methods
                        ListTile(
                          title: Text(
                            'Sản phẩm yêu thích',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.favorite,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const ProductFavouritePage()));
                          },
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
                              // CupertinoPageRoute(
                              //   builder: (context) => OrderHistoryWidget(
                              //       initialStatus: selectedStatus),
                              // ),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const VoucherPage(),
                              ),
                            );
                          },
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
                  TextQuicksand(
                    'Other',
                    textAlign: TextAlign.center,
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  Container(
                    height: 170,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: ShapeDecoration(
                      color: colorbg2,
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
                            'Hướng dẫn sử dụng',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.menu_book,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const TutorialPage()));
                          },
                        ),
                        _buildDivider(),
                        // About
                        ListTile(
                          title: Text(
                            'Chế độ màu tối',
                            style: _textStyle(),
                          ),
                          leading: CupertinoSwitch(
                            value: context.watch<ThemeSettingCubit>().state ==
                                AppTheme.blackTheme,
                            onChanged: (value) {
                              context.read<ThemeSettingCubit>().toggleTheme();
                            },
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
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    return GoogleFonts.getFont(
      'Quicksand',
      color: textColor,
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
