import 'dart:convert';

import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/login/view/fogotpasswork.dart';
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
  late SharedPreferences prefs;
  bool? isChecked = true;
  bool _obscureText =
      true; // Biến trạng thái để theo dõi trạng thái của obscureText
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool('isChecked') ?? true;
    });
  }

  bool isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  void loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Vui lòng nhập đầy đủ thông tin.";
      });
    } else if (!isValidEmail(emailController.text)) {
      setState(() {
        _errorMessage =
            "Email không đúng định dạng. Vui lòng nhập email hợp lệ.";
      });
    } else {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String token = jsonResponse['token'];
        prefs.setString('token', token);

        // Lưu trạng thái isChecked
        prefs.setBool('isChecked', isChecked!);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        String? userID = decodedToken['_id'];

        LoginStatus.instance.loggedIn = true;
        LoginStatus.instance.userID = userID;

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        setState(() {
          _errorMessage = "Email hoặc mật khẩu của bạn không đúng.";
        });
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/icon/khongngot1.png'),
                            width: 120,
                            height: 120,
                          ),
                          SizedBox(width: 25),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NGỌT CÀ PHÊ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontFamily: 'SVN-Whimsy',
                                ),
                              ),
                              // Text(
                              //   'Chào mừng quay trở lại!',
                              //   style: TextStyle(
                              //     fontFamily: 'SVN-Appleberry',
                              //     color: Color(0xFFFF725E),
                              //     fontSize: 26,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              TextQuicksand(
                                'Chào mừng quay trở lại!',
                                color: Color(0xFFFF725E),
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
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
                              const TextQuicksand(
                                'Email',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: emailController,
                                style: GoogleFonts.getFont('Quicksand',
                                    fontSize: 20,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.email,
                                      color: Color(0xFFFF725E)),
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
                              const TextQuicksand(
                                'Mật khẩu',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: passwordController,
                                obscureText:
                                    _obscureText, // Sử dụng biến trạng thái
                                style: GoogleFonts.getFont('Quicksand',
                                    fontSize: 20,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Color(0xFFFF725E)),
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: GoogleFonts.getFont(
                                    'Quicksand',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black, // Màu viền đen
                                      width: 1.0,
                                    ),
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
                                        const TextQuicksand(
                                          'Lưu tài khoản',
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ForgotPasswordDialog();
                                        },
                                      );
                                    },
                                    child: const TextQuicksand(
                                      'Quên mật khẩu',
                                      color: Color.fromARGB(255, 72, 70, 70),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              if (_errorMessage != null) ...[
                                const SizedBox(height: 10),
                                TextQuicksand(
                                  _errorMessage!,
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ],
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    loginUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 32.0),
                                    backgroundColor: const Color(0xFF2A4261),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: const TextQuicksand('ĐĂNG NHẬP',
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
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
                                      child: TextQuicksand(
                                        'Hoặc',
                                        color: Color(0xFF9C9A9A),
                                        fontSize: 16,
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
                                    const TextQuicksand(
                                      'Chưa có tài khoản, ',
                                      color: Color(0xFF9C9A9A),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
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
                                        child: const TextQuicksand(
                                          'đăng ký tại đây',
                                          color: Color(0xFF0B0B0B),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
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
