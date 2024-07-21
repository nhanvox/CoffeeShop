import 'package:coffeeshop/page/login/view/complete.dart';
import 'package:coffeeshop/page/login/view/components/montserrat.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Confirm extends StatefulWidget {
  const Confirm({super.key});

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 70),
                  decoration: const BoxDecoration(color: Color(0xFF2A4261)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/icon/khongngot1.png'),
                            width: 120,
                            height: 120,
                          ),
                          const SizedBox(width: 25),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NGỌT CÀ PHÊ',
                                style: GoogleFonts.getFont(
                                  'Montserrat Alternates',
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'Chào mừng quay trở lại!',
                                style: TextStyle(
                                  color: Color(0xFFFF725E),
                                  fontSize: 20,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 280,
                        ),
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFFFEF2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(55),
                                topLeft: Radius.circular(55)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/icon/oneFill.png'))),
                                        ),
                                        const SizedBox(height: 10),
                                        const TextMonserats(
                                          'Nhập email',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        'assets/icon/twoFill.png'))),
                                          ),
                                          const SizedBox(height: 10),
                                          const TextMonserats(
                                            'Xác nhận',
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/icon/threeNoFill.png'))),
                                        ),
                                        const SizedBox(height: 10),
                                        const TextMonserats(
                                          'Hoàn thành',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Quicksand',
                                    height: 1.5,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: 'Nhập email',
                                  hintStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 55),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Complete()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 32.0),
                                    backgroundColor: const Color(0xFF2A4261),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'HOÀN THÀNH',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Quicksand',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 50),
                                width: double.infinity,
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Hoặc',
                                        style: TextStyle(
                                          color: Color(0xFF9C9A9A),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 0),
                              //
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Đã có tài khoản, ',
                                      style: TextStyle(
                                        color: Color(0xFF9C9A9A),
                                        fontSize: 15,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(-12, 0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Loginscreen()),
                                          );
                                        },
                                        child: const Text(
                                          'đăng nhập tại đây',
                                          style: TextStyle(
                                            color: Color(0xFF0B0B0B),
                                            fontSize: 15,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
