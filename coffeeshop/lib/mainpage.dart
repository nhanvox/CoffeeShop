import 'dart:convert';
import 'dart:io';
import 'package:coffeeshop/page/home/view/drawer_tile.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: const Color(0xFFFFFEF2),
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF2A4261),
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
                                        : FileImage(File(image!))
                                            as ImageProvider) ??
                                    const AssetImage(
                                            'assets/images/avatar_default.png')
                                        as ImageProvider
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
                                ? name ?? 'Người dùng'
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
                isActive: currentPage == 4,
                press: () {
                  setState(() {
                    // currentPage = 4;
                  });
                  Navigator.pop(context);
                },
                title: 'Hỗ trợ',
                icon: Icons.support_agent,
              ),
              DrawerTile(
                isActive: currentPage == 5,
                press: () {
                  setState(() {
                    // currentPage = 5;
                  });
                  Navigator.pop(context);
                },
                title: 'Chính sách bảo mật',
                icon: Icons.security,
              ),
              DrawerTile(
                isActive: currentPage == 6,
                press: () {
                  setState(() {
                    // currentPage = 6;
                  });
                  Navigator.pop(context);
                },
                title: 'Về chúng tôi',
                icon: Icons.info,
              ),
              DrawerTile(
                isActive: false,
                press: () {
                  // Handle logout
                },
                title: 'Đăng xuất',
                icon: Icons.logout,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 24,
                offset: Offset(0, 5),
                spreadRadius: 0,
              )
            ],
            borderRadius: BorderRadius.only(
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
              onTap: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              currentIndex: currentPage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xFF2A4261),
                    size: 33,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Color(0xFF2A4261),
                    size: 33,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.window_outlined,
                    color: Color(0xFF2A4261),
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.window_rounded,
                    color: Color(0xFF2A4261),
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF2A4261),
                    size: 33,
                  ),
                  activeIcon: Icon(
                    Icons.notifications,
                    color: Color(0xFF2A4261),
                    size: 33,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xFF2A4261),
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.account_circle,
                    color: Color(0xFF2A4261),
                    size: 30,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
        body: _loadBody(currentPage),
      ),
    );
  }
}
