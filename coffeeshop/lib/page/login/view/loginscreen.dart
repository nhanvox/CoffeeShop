import 'dart:convert';

import 'package:coffeeshop/page/login/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';
import '../../../config/login_status.dart';
import '../../../mainpage.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // bool _isNotValidate = false;
  late SharedPreferences prefs;
  bool? isChecked = true;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        String token = jsonResponse['token'];
        prefs.setString('token', token);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        String? userID = decodedToken['_id'];

        LoginStatus.instance.loggedIn = true;
        LoginStatus.instance.userID = userID;

        print('userID: $userID');
        print(
            'LoginStatus.instance.loggedIn: ${LoginStatus.instance.loggedIn}');
        print('LoginStatus.instance.userID: ${LoginStatus.instance.userID}');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        print('Something went wrong');
      }
    }
  }

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
                                  'Montserrat',
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Chào mừng quay trở lại!',
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  color: const Color(0xFFFF725E),
                                  fontSize: 20,
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
                              horizontal: 30, vertical: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: emailController,
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
                              const SizedBox(height: 30),
                              const Text(
                                'Mật khẩu',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: passwordController,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Quicksand',
                                    height: 1.5,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: const Icon(Icons.visibility),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.translate(
                                    offset: const Offset(-12, 0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Lưu tài khoản',
                                          style: TextStyle(
                                            color: Color(0xFFB5B5B5),
                                            fontSize: 15,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Quên mật khẩu',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 72, 70, 70),
                                        fontSize: 15,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    loginUser();
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
                                    'ĐĂNG NHẬP',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Quicksand',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 30),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/icon/facebook.png'))),
                                    ),
                                    Container(
                                      width: 65,
                                      height: 65,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/icon/google.png'))),
                                    ),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/icon/zalo.png'))),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Chưa có tài khoản, ',
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
                                                    const Signup()),
                                          );
                                        },
                                        child: const Text(
                                          'đăng ký tại đây',
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
