import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/AppColors.dart';
import '../utils/app_tools.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: hexToColor(AppColors.appThemeColor),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: hexToColor(AppColors.appThemeColor),

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: hexToColor(AppColors.paleOrange),
    );

    final bodyHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    void goto(String path) {
      Navigator.of(context).pushNamed('$path');
    }

    List<String> options = [
      'Youths',
      'Weekly Forum Events',
      'Centers',
      'Groups',
      'Attendance',
      'Teams'
    ];

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Mozak',
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: hexToColor(AppColors.whiteTextColor),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: bodyHeight,
              width: bodyWidth,
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                  itemCount: options.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return Card(
                      color: hexToColor(AppColors.paleOrange),
                      elevation: 5,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: () => goto(options[index]),
                          child: Text(
                            '${options[index]}',
                            style: kGoogleStyleTexts.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: hexToColor(AppColors.whiteTextColor),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
