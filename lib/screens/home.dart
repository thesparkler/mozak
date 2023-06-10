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
    'Weekly Forum Event',
  ];

  void goto(String path) {
    Navigator.of(context).pushNamed('$path');
  }

  //TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bodyHeight = mediaQuery.size.height;
    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    List<AttendanceTable> attendanceTableList;
    var image = [
      Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          AppAssets.seva,
          height: 40,
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          AppAssets.smruti,
          height: 45,
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          AppAssets.suhradbhav,
          height: 60,
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          AppAssets.swadharma,
          height: 40,
        ),
      ),
    ];

    return Stack(
      children: [
        ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: Scaffold(
            key: _scaffoldKey,
            // appBar: appBar,
            backgroundColor: hexToColor(AppColors.appThemeColor),
            body: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        height: constraints.maxHeight * 0.1,
                        width: bodyWidth,
                        padding: EdgeInsets.only(left: 25),
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
                    Container(
                      alignment: Alignment.center,
                      height: constraints.maxHeight * 0.3,
                      width: bodyWidth,
                      child: CarouselSlider(
                        items: [
                          SizedBox(
                            width: constraints.maxWidth * 0.8,
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
                            width: constraints.maxWidth * 0.8,
                            child: Card(
                              color: hexToColor(AppColors.paleOrange)
                                  .withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Image.asset(
                                AppAssets.basEktuRajiTha,
                                height: 50,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.8,
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
                            width: constraints.maxWidth * 0.8,
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
                          height: constraints.maxHeight * 0.2,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 1,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 46 / 720 * 800),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: bodyHeight * 254 / 720,
                        width: bodyWidth * 282 / 320,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    goto(options[0]);
                                  },
                                  child: Container(
                                    height: bodyHeight * (115 / 720),
                                    width: bodyWidth * 130 / 320,
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20 / 324 * 360))),
                                      surfaceTintColor:
                                          hexToColor(AppColors.appThemeColor),
                                      color:
                                          hexToColor(AppColors.homeGridColor),
                                      elevation: 0,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 40,
                                                child: Container(
                                                  child: Image.asset(
                                                    AppAssets
                                                        .youthsLogoDashboard,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${options[0]}',
                                                style:
                                                    kGoogleStyleTexts.copyWith(
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
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    goto(options[1]);
                                  },
                                  child: Container(
                                    height: bodyHeight * (115 / 720),
                                    width: bodyWidth * 130 / 320,
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20 / 324 * 360))),
                                      surfaceTintColor:
                                          hexToColor(AppColors.appThemeColor),
                                      color:
                                          hexToColor(AppColors.homeGridColor),
                                      elevation: 0,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 40,
                                                child: Container(
                                                  child: Image.asset(
                                                    AppAssets
                                                        .centersLogoDashboard,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${options[1]}',
                                                style:
                                                    kGoogleStyleTexts.copyWith(
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
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                goto(options[3]);
                              },
                              child: SizedBox(
                                height: bodyHeight * (115 / 720),
                                width: bodyWidth * 282 / 320,
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20 / 324 * 360))),
                                  surfaceTintColor:
                                      hexToColor(AppColors.appThemeColor),
                                  color: hexToColor(AppColors.homeGridColor),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                child: Image.asset(
                                                  AppAssets
                                                      .weeklyForumEventLogoDashboard,
                                                  height: 40,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${options[3]}',
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Stack(
            children: [
              Container(
                height: 500 * 0.54,
                width: 500 * 0.54,
                //child: Image.asset("assets/images/Frame_6.png"),
                decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    hexToColor(AppColors.paleOrange).withOpacity(0.8),
                    hexToColor(AppColors.appThemeColor).withOpacity(0),
                  ], center: Alignment(0.9, -1), radius: 0.8, focalRadius: 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 150, right: 20),
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
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(seconds: 2),
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
        ), //SevaSmrutiSuhradbhavSwadharma
      ],
    );
  }
}
