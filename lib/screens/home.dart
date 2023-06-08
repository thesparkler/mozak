import 'package:flutter/material.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants/AppColors.dart';
import '../model/attendanceTable.dart';
import '../utils/NoGlowBehaviour.dart';
import '../utils/app_tools.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // late List<AttendanceTable> attendanceTableList;
  int selectedID = 0;
  int index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: hexToColor(AppColors.appThemeColor),
    // ));
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
    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    List<AttendanceTable> attendanceTableList;
    var image = [
      Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          AppAssets.seva,
          height: 50,
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          AppAssets.smruti,
          height: 50,
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          AppAssets.suhradbhav,
          height: 50,
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          AppAssets.swadharma,
          height: 50,
        ),
      ),
    ];

    return Stack(
      children: [

        Align(
          alignment: Alignment.topRight,
          child: Stack(
            children: [
              Container(
                height: 500,
                width: 500,
                //child: Image.asset("assets/images/Frame_6.png"),
                decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    hexToColor(AppColors.paleOrange).withOpacity(0.75),
                    hexToColor(AppColors.appThemeColor).withOpacity(0),
                  ], center: Alignment(0.9, -1), radius: 0.6, focalRadius: 3),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 150, right: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CarouselSlider(
                      items: image,
                      options: CarouselOptions(
                        height: 50,
                        aspectRatio: 1.5,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
        ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: Scaffold(
            key: _scaffoldKey,
            // appBar: appBar,
            backgroundColor: hexToColor(AppColors.appThemeColor),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22.0, top: 50),
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
                      ),
                      SizedBox(
                        height: mediaQuery.size.height / 2.15, //380
                        child: CarouselSlider(
                          items: [
                            SizedBox(
                              width: 360,
                              child: Card(
                                color: hexToColor(AppColors.paleOrange)
                                    .withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Image.asset(
                                  AppAssets.seva,
                                  height: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: Card(
                                color: hexToColor(AppColors.paleOrange)
                                    .withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Image.asset(
                                  AppAssets.smruti,
                                  height: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              child: Card(
                                color: hexToColor(AppColors.paleOrange)
                                    .withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Image.asset(
                                  AppAssets.suhradbhav,
                                  height: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 360,
                              child: Card(
                                color: hexToColor(AppColors.paleOrange)
                                    .withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Image.asset(
                                  AppAssets.swadharma,
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                          options: CarouselOptions(
                            height: 160,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        height: 360,
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      goto(options[0]);
                                    },
                                    child: SizedBox(
                                      height: 132.692307,
                                      width: 150,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        surfaceTintColor:
                                            hexToColor(AppColors.appThemeColor),
                                        color:
                                            hexToColor(AppColors.homeGridColor),
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 70,
                                                  height: 70,
                                                  child: Container(
                                                    child: Image.asset(
                                                      AppAssets
                                                          .youthsLogoDashboard,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '${options[0]}',
                                                  style: kGoogleStyleTexts
                                                      .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    color: hexToColor(AppColors
                                                        .whiteTextColor),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      goto(options[1]);
                                    },
                                    child: SizedBox(
                                      height: 132.692307,
                                      width: 150,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        surfaceTintColor:
                                            hexToColor(AppColors.appThemeColor),
                                        color:
                                            hexToColor(AppColors.homeGridColor),
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 70,
                                                  height: 70,
                                                  child: Container(
                                                    child: Image.asset(
                                                      AppAssets
                                                          .centersLogoDashboard,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '${options[1]}',
                                                  style: kGoogleStyleTexts
                                                      .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    color: hexToColor(AppColors
                                                        .whiteTextColor),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  goto(options[3]);
                                },
                                child: SizedBox(
                                  height: 132.692307,
                                  width: 320,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    surfaceTintColor:
                                        hexToColor(AppColors.appThemeColor),
                                    color: hexToColor(AppColors.homeGridColor),
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, left: 20),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 70,
                                                    height: 70,
                                                    child: Container(
                                                      child: Image.asset(
                                                        AppAssets
                                                            .weeklyForumEventLogoDashboard,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${options[3]}',
                                                    style: kGoogleStyleTexts
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                      color: hexToColor(
                                                          AppColors
                                                              .whiteTextColor),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ), //Main Dashboard
                  Align(
                    alignment: Alignment.topRight,
                    child: Stack(
                      children: [
                        Container(
                          height: 500,
                          width: 500,
                          //child: Image.asset("assets/images/Frame_6.png"),
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                                colors: [
                                  hexToColor(AppColors.paleOrange)
                                      .withOpacity(0.8),
                                  hexToColor(AppColors.appThemeColor)
                                      .withOpacity(0),
                                ],
                                center: Alignment(0.9, -1),
                                radius: 0.54,
                                focalRadius: 3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 40.0, left: 150, right: 20),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: CarouselSlider(
                                items: image,
                                options: CarouselOptions(
                                  height: 50,
                                  aspectRatio: 1.5,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 10),
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 2),
                                  autoPlayCurve: Curves.easeIn,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.3,
                                  scrollDirection: Axis.vertical,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ), //BackgroundAnimation
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
