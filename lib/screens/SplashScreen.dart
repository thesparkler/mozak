import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/screens/LoginScreen.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/utils/app_tools.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();

    Timer(const Duration(seconds: 5),
        () => Navigator.of(context).push(_createRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                AppAssets.hariprabodhamLogo,
                height: 250,
                width: 250,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: AppStrings.splashScreenTextOne,
                    style: TextStyle(
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 26.0,
                        fontFamily: 'FocusGrotesk',
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                        letterSpacing: 1.4),
                    children: <TextSpan>[
                      TextSpan(
                          text: AppStrings.splashScreenTextTwo,
                          style: TextStyle(
                              fontSize: 21,
                              color: hexToColor(AppColors.whiteTextColor),
                              fontFamily: 'FocusGrotesk',
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.3))
                    ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              AppAssets.yuvak,
              height: 297,
              width: 277,
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            // const LoginPage(),
            const UserForm(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
