import 'dart:convert';
import 'package:coffeeshop/page/about/about_page.dart';
import 'dart:io';
import 'package:coffeeshop/page/home/view/drawer_tile.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/support/support_page.dart';
import 'package:coffeeshop/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'config/authservice.dart';
import 'config/config.dart';
import 'config/login_status.dart';
import 'page/account/accountpage.dart';
import 'page/home/homepage.dart';
import 'page/login/view/loginscreen.dart';
import 'page/menu/menupage.dart';
import 'page/notification/notifypage.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  String selectedCategoryId = 'all';
  String? userName;
  Map<String, dynamic>? user;
  String? name;
  String? image;
  Map<String, dynamic>? profile;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
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
              image = profile!['image'];
            });
            print('Profile loaded successfully');
          } else {
            print('Failed to load user: ${jsonResponse['message']}');
          }
        } else {
          print(
              'Failed to load profile with status code: ${response.statusCode}');
        }
      } else {
        print('User ID is null');
      }
    } else {
      print('User is not logged in');
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
              userName = user!['email'];
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

  void _logout(BuildContext context) async {
    await AuthService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
    );
  }

  void _changeCategory(String categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
    });
  }

  _loadBody(int index) {
    switch (index) {
      case 0:
        return HomePage(
          changePage: (newIndex) {
            setState(() {
              currentPage = newIndex;
            });
          },
          changeCategory: _changeCategory,
        );
      case 1:
        return MenuPage(initialCategoryId: selectedCategoryId);
      case 2:
        return const NotifyPage();
      case 3:
        return const AccountPage();

      default:
        return HomePage(
            changePage: (newIndex) {
              setState(() {
                currentPage = newIndex;
              });
            },
            changeCategory: _changeCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final colornav =
        isDarkMode ? const Color(0xffffff3d7) : const Color(0xfffffffff);
    final colornavmenu =
        isDarkMode ? const Color(0xff2A4261) : const Color(0xFFFFFEF2);
    final colornavmenu1 =
        isDarkMode ? const Color(0xff17273B) : const Color(0xff2A4261);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: colornavmenu,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colornavmenu1,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print(user);
                      print(LoginStatus.instance.userID);
                      if (LoginStatus.instance.loggedIn) {
                        setState(() {
                          currentPage = 3;
                        });
                        Navigator.pop(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loginscreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: profile != null && image != ''
                              ? (image!.startsWith('http')
                                  ? NetworkImage(image!)
                                  : FileImage(File(image!)) as ImageProvider)
                              : const AssetImage(
                                      'assets/images/avatar_default.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextQuicksand(
                          'Xin chào!',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 2,
                        ),
                        Text(
                          LoginStatus.instance.loggedIn
                              ? ((profile != null && name != '')
                                  ? name ?? 'Người dùng'
                                  : 'Người dùng')
                              : 'Đăng nhập/ Đăng ký',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.getFont(
                            'Quicksand',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            DrawerTile(
              isActive: currentPage == 0,
              press: () {
                setState(() {
                  currentPage = 0;
                });
              },
              title: 'Trang chủ',
              icon: Icons.home,
            ),
            DrawerTile(
              isActive: currentPage == 1,
              press: () {
                setState(() {
                  currentPage = 1;
                });
              },
              title: 'Danh mục sản phẩm',
              icon: Icons.window_outlined,
            ),
            DrawerTile(
              isActive: currentPage == 2,
              press: () {
                setState(() {
                  currentPage = 2;
                });
              },
              title: 'Thông báo',
              icon: Icons.notifications,
            ),
            DrawerTile(
              isActive: currentPage == 4,
              press: () {
                setState(() {
                  // currentPage = 1;
                });
                Navigator.pop(context);
              },
              title: 'Đơn hàng',
              icon: Icons.shopping_cart,
            ),
            DrawerTile(
              isActive: currentPage == 4,
              press: () {
                setState(() {
                  // currentPage = 2;
                });
                Navigator.pop(context);
              },
              title: 'Lịch sử đơn hàng',
              icon: Icons.history,
            ),
            DrawerTile(
              isActive: currentPage == 4,
              press: () {
                setState(() {
                  // currentPage = 3;
                });
                Navigator.pop(context);
              },
              title: 'Yêu thích',
              icon: Icons.favorite,
            ),
            DrawerTile(
              isActive: false,
              press: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SupportPage(),
                  ),
                );
              },
              title: 'Hỗ trợ',
              icon: Icons.support_agent,
            ),
            DrawerTile(
              isActive: false,
              press: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
              title: 'Về chúng tôi',
              icon: Icons.info,
            ),
            DrawerTile(
              isActive: false,
              press: () {
                _logout(context);
              },
              title: 'Đăng xuất',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
      onDrawerChanged: (isOpen) {
        if (isOpen) {
          _getProfile();
        }
      },
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colornav,
              blurRadius: 24,
              offset: const Offset(0, 5),
              spreadRadius: 0,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xFF2A4261),
            unselectedItemColor: const Color(0xFF2A4261),
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
            currentIndex: currentPage,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home_outlined,
                  size: 33,
                ),
                activeIcon: const Icon(
                  Icons.home,
                  size: 33,
                ),
                label: '',
                backgroundColor: colornav, // Đặt màu nền cho mục này
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.window_outlined,
                  size: 30,
                ),
                activeIcon: const Icon(
                  Icons.window_rounded,
                  size: 30,
                ),
                label: '',
                backgroundColor: colornav, //t màu nền cho mục này
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 33,
                ),
                activeIcon: const Icon(
                  Icons.notifications,
                  size: 33,
                ),
                label: '',
                backgroundColor: colornav, // Đặt màu nền cho mục này
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
                activeIcon: const Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                label: '',
                backgroundColor: colornav, // Đặt màu nền cho mục này
              ),
            ],
          ),
        ),
      ),
      body: _loadBody(currentPage),
    );
  }
}
