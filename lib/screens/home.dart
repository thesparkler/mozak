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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: hexToColor(AppColors.appThemeColor),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Mozak',
        style: kGoogleStyleTexts.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: hexToColor(AppColors.whiteTextColor),
        ),
        textAlign: TextAlign.center,
      ),
      iconTheme: IconThemeData(
        color: hexToColor(AppColors.whiteTextColor),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: hexToColor(AppColors.appThemeColor),
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
      'Centers',
      'Groups',
      'Attendance',
      'Teams'
    ];

    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: true,
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Column(
        children: [
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
    );
  }
}
