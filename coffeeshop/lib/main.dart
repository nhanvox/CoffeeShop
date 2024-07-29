import 'package:coffeeshop/page/login/splashdelay.dart';
import 'package:coffeeshop/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/authservice.dart';
// Ensure this imports your AppTheme with lightTheme and blackTheme

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã khởi tạo
  await AuthService
      .checkAndSetLoginStatus(); // Kiểm tra và thiết lập trạng thái đăng nhập

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeSettingCubit(),
      child: BlocBuilder<ThemeSettingCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            themeMode: ThemeMode.system,
            home: const SplashDelay(),
          );
        },
      ),
    );
  }
}
