import 'package:coffeeshop/page/account/updateaccountpage.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../order/orderhistorypage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFEF2)),
      child: CustomScrollView(
        slivers: [
          //Header
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/background_account.png'),
                        fit: BoxFit.fill),
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
                      )
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
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                              shape:
                                  BoxShape.circle, // Đặt hình dạng là hình tròn
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/avatar_default.png'),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nhân Võ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'nhanvo.654@gmail.com',
                                  style: TextStyle(
                                    color: Color(0x991B1B1B),
                                    fontSize: 17,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          //Mục tài khoản
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tài khoản',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                    ),
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
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        //Cập nhật thông tin
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
                                    builder: (context) =>
                                        const UpdateAccountPage()));
                          },
                        ),
                        _buildDivider(),
                        //Phương thức thanh toán
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
                        //Lịch sử đặt hàng
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
                                        const OrderHistoryWidget()));
                          },
                        ),
                        _buildDivider(),
                        //Ưu đãi
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
          //Mục Other
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
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        //Thông Báo
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
                        //Giới thiệu
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
                        //Lịch sử đặt hàng
                        ListTile(
                          title: Text(
                            'Đăng xuất',
                            style: _textStyle(),
                          ),
                          leading: const Icon(
                            Icons.logout,
                            size: 30,
                            color: Color(0xFFFF725E),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Loginscreen()));
                          },
                        ),
                        _buildDivider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 19,
      fontFamily: 'Quicksand',
      fontWeight: FontWeight.w500,
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
