import 'dart:convert';

import 'package:coffeeshop/mainpage.dart';
import 'package:coffeeshop/page/login/view/components/montserrat.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/config.dart';
import '../../../config/login_status.dart';

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
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      try {
        var response = await http.post(Uri.parse(registration),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        if (response.statusCode == 200) {
          print("Ngon");
          // Automatically log in the user
          loginUser(emailController.text, passwordController.text);
        } else {
          print("Server error: ${response.statusCode}");
          setState(() {
            _errorMessage = "Email đã được sử dụng.";
          });
          print('Error: Email đã được sử dụng.');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void loginUser(String email, String password) async {
    var reqBody = {"email": email, "password": password};

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
        _errorMessage = "Đăng nhập thất bại.";
      });
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
                                controller: emailController,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Quicksand',
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
                                  errorStyle:
                                      const TextStyle(color: Colors.red),
                                  errorText: _isNotValidate
                                      ? "Email không hợp lệ!"
                                      : null,
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
                              const SizedBox(height: 10),
                              // Password field
                              const Text(
                                'Mật khẩu',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: passwordController,
                                obscureText:
                                    _obscurePassword, // Sử dụng biến trạng thái
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Quicksand',
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
                                  errorStyle:
                                      const TextStyle(color: Colors.red),
                                  errorText: _isNotValidate
                                      ? "Mật khẩu không hợp lệ!"
                                      : null,
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
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
                              const Text(
                                'Nhập lại mật khẩu',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: confirmPasswordController,
                                obscureText:
                                    _obscureConfirmPassword, // Sử dụng biến trạng thái
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Quicksand',
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
                                  errorStyle:
                                      const TextStyle(color: Colors.red),
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
                                Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
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
                                        vertical: 16.0, horizontal: 32.0),
                                    backgroundColor: const Color(0xFF2A4261),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text(
                                    'TIẾP THEO',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                              // Login link
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
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
            const TextMonserats(
              'Nhập email',
              color: Colors.black,
              fontSize: 12,
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
              const TextMonserats(
                'Xác nhận',
                color: Colors.black,
                fontSize: 12,
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
            const TextMonserats(
              'Hoàn thành',
              color: Colors.black,
              fontSize: 12,
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
    return Row(
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
        ),
      ],
    );
  }
}
