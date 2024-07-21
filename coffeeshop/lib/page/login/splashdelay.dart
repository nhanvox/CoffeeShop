import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffeeshop/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

class SplashDelay extends StatelessWidget {
  const SplashDelay({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo.png',
      duration: 2000,
      splashIconSize: 200.0, // Adjust this value to your desired size
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      // backgroundColor: Color.fromRGBO(255, 254, 242, 100),
      backgroundColor: const Color(0xFFFFFEF2),
      // backgroundColor: Color(0xFFFEF2),
      nextScreen: const MainPage(),
    );
  }
}
