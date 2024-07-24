import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffeeshop/mainpage.dart';
import 'package:coffeeshop/page/login/view/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../config/authservice.dart';
import '../../config/login_status.dart';

class SplashDelay extends StatefulWidget {
  const SplashDelay({super.key});

  @override
  _SplashDelayState createState() => _SplashDelayState();
}

class _SplashDelayState extends State<SplashDelay> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await AuthService.checkAndSetLoginStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logo.png',
      duration: 2000,
      splashIconSize: 200.0,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: const Color(0xFFFFFEF2),
      nextScreen: LoginStatus.instance.loggedIn
          ? const MainPage()
          : const Loginscreen(),
    );
  }
}



// import 'dart:convert';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:coffeeshop/mainpage.dart';
// import 'package:coffeeshop/page/login/view/loginscreen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import '../../config/config.dart';
// import '../../config/login_status.dart';
// import 'package:http/http.dart' as http;

// class SplashDelay extends StatefulWidget {
//   const SplashDelay({super.key});

//   @override
//   _SplashDelayState createState() => _SplashDelayState();
// }

// class _SplashDelayState extends State<SplashDelay> {
//   bool _hasLogin = false;
//   Map<String, dynamic>? _user;

//   @override
//   void initState() {
//     super.initState();
//     checkUserLoggedIn();
//   }

//   void checkUserLoggedIn() async {
//     String? userId = LoginStatus.instance.userID;
//     if (userId != null) {
//       Uri getProfileUrl = Uri.parse(getUserInfoById + userId);
//       var response = await http.get(getProfileUrl);

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['success'] == true) {
//           var user = jsonResponse['userInfo'];
//           setState(() {
//             _hasLogin = user != null;
//             _user = user;
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_hasLogin) {
//       return AnimatedSplashScreen(
//         splash: 'assets/logo.png',
//         duration: 2000,
//         splashIconSize: 200.0, // Adjust this value to your desired size
//         splashTransition: SplashTransition.sizeTransition,
//         pageTransitionType: PageTransitionType.leftToRight,
//         backgroundColor: const Color(0xFFFFFEF2),
//         nextScreen: const Loginscreen(),
//       );
//     } else {
//       return AnimatedSplashScreen(
//         splash: 'assets/logo.png',
//         duration: 2000,
//         splashIconSize: 200.0, // Adjust this value to your desired size
//         splashTransition: SplashTransition.sizeTransition,
//         pageTransitionType: PageTransitionType.leftToRight,
//         backgroundColor: const Color(0xFFFFFEF2),
//         nextScreen: const MainPage(),
//       );
//     }
//   }
// }
