import 'package:coffeeshop/page/login/splashdelay.dart';
import 'package:flutter/material.dart';

import 'config/authservice.dart';

void main() async {
  //Test git
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã khởi tạo
  await AuthService
      .checkAndSetLoginStatus(); // Kiểm tra và thiết lập trạng thái đăng nhập

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashDelay(),
  ));
}
