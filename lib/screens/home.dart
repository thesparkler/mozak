import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/AppColors.dart';
import '../model/attendanceTable.dart';
import '../model/youth.dart';
import '../utils/NoGlowBehaviour.dart';
import '../utils/api_service.dart';
import '../utils/app_tools.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late List<AttendanceTable> attendanceTableList;
  int selectedID = 0;
  int index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: hexToColor(AppColors.appThemeColor),
    ));
    super.initState();
  }

  List<String> options = [
    'Youths',
    'Centers',
    'Groups',
    'Attendance',
  ];

  void goto(String path) {
    Navigator.of(context).pushNamed('$path');
  }

  //TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          'Dashboard',
          style: kGoogleStyleTexts.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            fontFamily: "inter",
            color: hexToColor(AppColors.whiteTextColor),
          ),
          textAlign: TextAlign.left,
        ),
      ),
      // iconTheme: IconThemeData(
      //   color: hexToColor(AppColors.whiteTextColor),
      // ),
      automaticallyImplyLeading: false,
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

    List<AttendanceTable> attendanceTableList;

    return Stack(
      children: [
        ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: appBar,
            backgroundColor: hexToColor(AppColors.appThemeColor),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 375,
                  ),
                  Container(
                    height: bodyHeight - 350,
                    width: bodyWidth,
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                        itemCount: options.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.1304347826086,
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              goto(options[index]);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              surfaceTintColor:
                                  hexToColor(AppColors.appThemeColor),
                              color: hexToColor(AppColors.homeGridColor),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${options[index]}',
                                        style: kGoogleStyleTexts.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: hexToColor(
                                              AppColors.whiteTextColor),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
