import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/screens/LoginScreen.dart';
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

    SystemChannels.textInput.invokeMethod('TextInput.hide');
    controller = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInBack);
    controller.forward();

    Timer(const Duration(seconds: 3),
        () => Navigator.of(context).push(_createRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(AppColors.appThemeColor),
      //backgroundColor: hexToColor("#4A250A"),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(AppAssets.gunatitPurushoLogo,
                width: MediaQuery.of(context).size.width),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 100.0),
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: Image.asset(
          //       AppAssets.hariprabodhamLogo,
          //       height: 200,
          //       width: 200,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
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
                      fontWeight: FontWeight.w800,
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
                        letterSpacing: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 5000),
            curve: Curves.easeInExpo,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppAssets.hariprabodhamLogo,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
              ),
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
            const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.linearToEaseOut;
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return FadeTransition(
            opacity: animation,
            child: child,
            alwaysIncludeSemantics: true,
          );
        });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
