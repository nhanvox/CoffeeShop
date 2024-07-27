import 'dart:convert';

import 'package:coffeeshop/mainpage.dart';
import 'package:coffeeshop/page/login/view/components/montserrat.dart';
import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/config.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final bool _isNotValidate = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late SharedPreferences prefs;
  bool? isChecked = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  bool isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  void registerUser() async {
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');
    print('Confirm Password: ${confirmPasswordController.text}');

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Vui lòng nhập đầy đủ thông tin.";
      });
      print('Error: Vui lòng nhập đầy đủ thông tin.');
    } else if (!isValidEmail(emailController.text)) {
      setState(() {
        _errorMessage =
            "Email không đúng định dạng. Vui lòng nhập email hợp lệ.";
      });
      print('Error: Email không đúng định dạng.');
    } else if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Mật khẩu và xác nhận mật khẩu không khớp.";
      });
      print('Error: Mật khẩu và xác nhận mật khẩu không khớp.');
    } else {
      // Tạo đối tượng JSON chứa email và password từ textfield
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      // Đoạn này gửi một yêu cầu HTTP POST tới URL registration với nội dung là regBody
      // được mã hóa thành JSON và tiêu đề Content-Type là application/json.
      try {
        var response = await http.post(Uri.parse(registration),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        if (response.statusCode == 200) {
          print("Ngon");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        } else {
          // ignore: avoid_print
          print("Server error: ${response.statusCode}");
          setState(() {
            _errorMessage = "Email đã được sử dụng.";
          });
          print('Error: Email đã được sử dụng.');
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error: $e');
      }
    }
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool('isChecked') ?? true;
    });
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
                      const _BuildLogo(),
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
                              topLeft: Radius.circular(55),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: _BuildCurrentState(),
                              ),
                              const SizedBox(height: 20),
                              // Email field
                              const TextQuicksand(
                                'Email',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              TextField(
                                controller: emailController,
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  fontSize: 20,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xFFFF725E),
                                  ),
                                  errorStyle: GoogleFonts.getFont('Quicksand',
                                      color: Colors.red),
                                  errorText: _isNotValidate
                                      ? "Email không hợp lệ!"
                                      : null,
                                  hintText: 'Nhập email',
                                  hintStyle: GoogleFonts.getFont(
                                    'Quicksand',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Password field
                              const TextQuicksand(
                                'Mật khẩu',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: passwordController,
                                obscureText:
                                    _obscurePassword, // Sử dụng biến trạng thái
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  fontSize: 18,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFFFF725E),
                                  ),
                                  errorStyle: GoogleFonts.getFont('Quicksand',
                                      color: Colors.red),
                                  errorText: _isNotValidate
                                      ? "Mật khẩu không hợp lệ!"
                                      : null,
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: GoogleFonts.getFont(
                                    'Quicksand',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),
                              // Confirm Password field
                              const TextQuicksand(
                                'Nhập lại mật khẩu',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: confirmPasswordController,
                                obscureText:
                                    _obscureConfirmPassword, // Sử dụng biến trạng thái
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  fontSize: 20,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFFFF725E),
                                  ),
                                  errorStyle: GoogleFonts.getFont('Quicksand',
                                      color: Colors.red),
                                  errorText: _isNotValidate
                                      ? "Mật khẩu không trùng khớp"
                                      : null,
                                  hintText: 'Nhập lại mật khẩu',
                                  hintStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5),
                              if (_errorMessage != null) ...[
                                const SizedBox(height: 10),
                                TextQuicksand(
                                  _errorMessage!,
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ],
                              const SizedBox(
                                height: 30,
                              ),
                              // Next button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    registerUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 32.0),
                                    backgroundColor: const Color(0xFF2A4261),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: const TextQuicksand(
                                    'TIẾP THEO',
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // Or divider
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
                                        color: Colors.grey,
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
                              const SizedBox(height: 0),
                              // Login link
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const TextQuicksand(
                                      'Đã có tài khoản, ',
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
                                                    const Loginscreen()),
                                          );
                                        },
                                        child: const TextQuicksand(
                                          'đăng nhập tại đây',
                                          color: Color(0xFF0B0B0B),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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

class _BuildCurrentState extends StatelessWidget {
  const _BuildCurrentState();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Step 1: Nhập email
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/icon/oneFill.png'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const TextQuicksand(
              'Nhập email',
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        // Step 2: Xác nhận
        Container(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/icon/twoNoFill.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const TextQuicksand(
                'Xác nhận',
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        // Step 3: Hoàn thành
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/icon/threeNoFill.png'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const TextQuicksand(
              'Hoàn thành',
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}

// Logo widget
class _BuildLogo extends StatelessWidget {
  const _BuildLogo();

  @override
  Widget build(BuildContext context) {
    return const Row(
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
            TextQuicksand(
              'Chào mừng quay trở lại!',
              color: Color(0xFFFF725E),
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}
