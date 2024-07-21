import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffeeshop/page/login/view/components/montserrat.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Complete extends StatefulWidget {
  const Complete({super.key});

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 200.0, // Adjust this value to your desired size
                ),
              ],
            ),
            duration: 2000,
            splashIconSize: 200.0, // Adjust this value to your desired size
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.leftToRight,
            backgroundColor: const Color(0xFFFFFEF2),
            nextScreen: const Loginscreen(),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 308.0),
            child: Center(
              child: Positioned(
                child: TextMonserats(
                  'ĐĂNG KÝ THÀNH CÔNG',
                  color: Colors.black,
                  fontSize: 24.0, // Adjust this value to your desired size
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
