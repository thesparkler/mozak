import 'package:flutter/material.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/utils/youthData.dart';

import '../constants/AppAssets.dart';
import '../constants/AppColors.dart';
import '../model/center.dart';
import '../utils/app_tools.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({Key? key}) : super(key: key);

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  late List<CenterData> centerList;

  int index = 0;
  bool showCreateCenterCard = false;
  TextEditingController locationController = new TextEditingController();

  void openCreateCenterPage() {
    showCreateCenterCard = true;

    setState(() {});
  }

  void closeCreateCenterPage() {
    setState(() {
      showCreateCenterCard = false;
    });
  }

  void addCenter(String location) {
    ApiService().setCenter(location);
  }

  @override
  void initState() {
    getCenterList();
    super.initState();
  }

  Future<List<CenterData>> getCenterList() {
    var obj = YouthData.instance.getCenterList();
    return obj.then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    index = 0;
    final appBar = AppBar(
      title: Text(
        'Centres',
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

    final bodyHeight = mediaQuery.size.height;

    final bodyWidth = mediaQuery.size.width;
    List<String> optionsName = [
      'Badlapur',
      'Bhandup',
      'Dombivli',
      'Ghatkopar',
      'Mulund',
      'Vashi',
      "Vihkroli",
      "Rani"
    ];
    List<String> optionsSName = ['BL', 'B', 'D', 'G', "M", 'VA', 'V', 'R'];

    return Scaffold(
      appBar: appBar,
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Padding(
        padding: EdgeInsets.only(
          left: 22.0 / 324 * bodyWidth,
          right: 22.0 / 324 * bodyWidth,
          top: 22.0 / 324 * bodyWidth,
        ),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: optionsSName.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 132 / 100,
              crossAxisCount: 2,
              mainAxisSpacing: 16 / 324 * bodyWidth,
              crossAxisSpacing: 16 / 324 * bodyWidth),
          itemBuilder: (context, index) {
            return InkWell(
              onDoubleTap: () => {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  context: context,
                  backgroundColor: hexToColor(AppColors.appThemeColor),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 22 / 324 * bodyWidth,
                            right: 22 / 324 * bodyWidth,
                            top: 35 / 720 * bodyHeight),
                        height: bodyHeight * 308 / 720,
                        width: MediaQuery.of(context).size.width,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppAssets.locationLogo,
                                      height: 21 / 720 * bodyHeight,
                                    ),
                                    SizedBox(
                                      width: 5 / 324 * bodyWidth,
                                    ),
                                    Container(
                                      height: 29 / 720 * bodyHeight,
                                      child: Text(
                                        "Bhandup",
                                        softWrap: true,
                                        style: kGoogleStyleTexts.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20 / 324 * bodyWidth,
                                          color: hexToColor(
                                              AppColors.whiteTextColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16 / 720 * bodyHeight,
                                ),
                                Container(
                                  // width: 276 / 324 * bodyWidth,
                                  child: Card(
                                    color: hexToColor(AppColors.whiteTextColor)
                                        .withOpacity(0.11),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 22 / 324 * bodyWidth,
                                        vertical: 15 / 720 * bodyHeight,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "IDUBS Hiindi High School & Junior College",
                                            softWrap: true,
                                            style: kGoogleStyleTexts.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12 / 324 * bodyWidth,
                                              color: hexToColor(
                                                  AppColors.whiteTextColor),
                                            ),
                                          ),
                                          Text(
                                            "Bhundup Staion Road, near Geeta Hall,"
                                            "Dina Bama Estate, Bhandup West, Mumbai, Maharashtra, 400078",
                                            softWrap: true,
                                            style: kGoogleStyleTexts.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12 / 324 * bodyWidth,
                                              color: hexToColor(
                                                  AppColors.whiteTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              },
              child: Card(
                color: hexToColor(AppColors.whiteTextColor).withOpacity(0.11),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20 / 324 * bodyWidth),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: bodyHeight * 73 / 720,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: bodyHeight * 40 / 720,
                          width: bodyHeight * 40 / 720,
                          child: Card(
                            color: hexToColor(AppColors.paleOrange),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20 / 720 * bodyHeight),
                              ),
                            ),
                            child: Container(
                              height: bodyHeight * 29 / 720,
                              alignment: Alignment.center,
                              child: Text(
                                '${optionsSName[index]}',
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18 / 720 * bodyHeight,
                                  color: hexToColor(AppColors.centerLogoText),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 4 / 720 * bodyHeight,
                        // ),
                        Container(
                          height: bodyHeight * 29 / 720,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '${optionsName[index]}',
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 14 / 720 * bodyHeight,
                                color: hexToColor(AppColors.whiteTextColor),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    index = 0;
    super.dispose();
  }

  Widget getCenterRow(String name) {
    index++;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(index.toString(),
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: hexToColor(AppColors.whiteTextColor),
                )),
          ),
          Container(
            child: Text(" $name",
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: hexToColor(AppColors.whiteTextColor),
                )),
          )
        ],
      ),
    );
  }
}
/*imp code for displaying center cards
Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder<List<CenterData>>(
                    future: getCenterList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CenterData>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          centerList = snapshot.data!;
                          centerList
                              .sort((a, b) => a.location.compareTo(b.location));
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: centerList
                                .map((e) => getCenterRow(e.location))
                                .toList(),
                          );
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 35),
                        child: Center(
                          child: LinearProgressIndicator(
                            color: hexToColor(AppColors.appThemeColor),
                            backgroundColor:
                                hexToColor(AppColors.whiteTextColor),
                          ),
                        ),
                      );
                    }),
              ),
 */

/*
ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        appBar: appBar,
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: Padding(
          padding: EdgeInsets.only(
            left: 22.0 / 324 * bodyWidth,
            right: 22.0 / 324 * bodyWidth,
            top: 22.0 / 324 * bodyWidth,
          ),
          child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: optionsSName.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 132 / 100,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16 / 324 * bodyWidth,
                  crossAxisSpacing: 16 / 324 * bodyWidth),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      backgroundColor: hexToColor(AppColors.appThemeColor),
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.zero,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 22 / 324 * bodyWidth,
                                right: 22 / 324 * bodyWidth,
                                top: 35 / 720 * bodyHeight),
                            height: bodyHeight * 308 / 720,
                            width: MediaQuery.of(context).size.width,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.locationLogo,
                                          height: 21 / 720 * bodyHeight,
                                        ),
                                        SizedBox(
                                          width: 5 / 324 * bodyWidth,
                                        ),
                                        Container(
                                          height: 29 / 720 * bodyHeight,
                                          child: Text(
                                            "Bhandup",
                                            softWrap: true,
                                            style: kGoogleStyleTexts.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20 / 324 * bodyWidth,
                                              color: hexToColor(
                                                  AppColors.whiteTextColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16 / 720 * bodyHeight,
                                    ),
                                    Container(
                                      // width: 276 / 324 * bodyWidth,
                                      child: Card(
                                        color:
                                            hexToColor(AppColors.whiteTextColor)
                                                .withOpacity(0.11),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 22 / 324 * bodyWidth,
                                            vertical: 15 / 720 * bodyHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "IDUBS Hiindi High School & Junior College",
                                                softWrap: true,
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      12 / 324 * bodyWidth,
                                                  color: hexToColor(
                                                      AppColors.whiteTextColor),
                                                ),
                                              ),
                                              Text(
                                                "Bhundup Staion Road, near Geeta Hall,"
                                                "Dina Bama Estate, Bhandup West, Mumbai, Maharashtra, 400078",
                                                softWrap: true,
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      12 / 324 * bodyWidth,
                                                  color: hexToColor(
                                                      AppColors.whiteTextColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  },
                  child: Card(
                    color:
                        hexToColor(AppColors.whiteTextColor).withOpacity(0.11),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: bodyHeight * 73 / 720,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: bodyHeight * 40 / 720,
                              width: bodyHeight * 40 / 720,
                              child: Card(
                                color: hexToColor(AppColors.paleOrange),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20 / 720 * bodyHeight),
                                  ),
                                ),
                                child: Container(
                                  height: bodyHeight * 29 / 720,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${optionsSName[index]}',
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18 / 720 * bodyHeight,
                                      color:
                                          hexToColor(AppColors.centerLogoText),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 4 / 720 * bodyHeight,
                            // ),
                            Container(
                              height: bodyHeight * 29 / 720,
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  '${optionsName[index]}',
                                  style: kGoogleStyleTexts.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14 / 720 * bodyHeight,
                                    color: hexToColor(AppColors.whiteTextColor),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //
        //       // Container(
        //       //   height: 40,
        //       //   width: MediaQuery.of(context).size.width / 2,
        //       //   decoration: BoxDecoration(
        //       //       color: hexToColor(AppColors.paleOrange),
        //       //       backgroundBlendMode: BlendMode.lighten,
        //       //       border: Border.all(
        //       //         color: hexToColor(AppColors.paleOrange),
        //       //       ),
        //       //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
        //       //   child: TextButton(
        //       //     onPressed: openCreateCenterPage,
        //       //     child: Text(
        //       //       "Add a new center",
        //       //       style: kGoogleStyleTexts.copyWith(
        //       //         fontWeight: FontWeight.w700,
        //       //         fontSize: 16,
        //       //         color: hexToColor(AppColors.whiteTextColor),
        //       //       ),
        //       //       textAlign: TextAlign.center,
        //       //     ),
        //       //   ),
        //       // ),
        //       // showCreateCenterCard
        //       //     ? Padding(
        //       //         padding: const EdgeInsets.all(25.0),
        //       //         child: Card(
        //       //             elevation: 0,
        //       //             shadowColor: Colors.black,
        //       //             color: hexToColor(AppColors.paleOrange),
        //       //             child: Form(
        //       //                 child: Column(
        //       //               children: [
        //       //                 Padding(
        //       //                   padding: const EdgeInsets.all(8.0),
        //       //                   child: Container(
        //       //                       decoration: BoxDecoration(
        //       //                         borderRadius: BorderRadius.circular(5.0),
        //       //                         border: Border.all(
        //       //                           color: hexToColor(AppColors
        //       //                               .textFieldOutlineBorderColor),
        //       //                           width: 1.0,
        //       //                         ),
        //       //                       ),
        //       //                       width: MediaQuery.of(context).size.width,
        //       //                       child: Padding(
        //       //                           padding:
        //       //                               const EdgeInsets.only(left: 10.0),
        //       //                           child: TextField(
        //       //                             controller: locationController,
        //       //                             style: kGoogleStyleTexts.copyWith(
        //       //                                 fontWeight: FontWeight.w400,
        //       //                                 color: hexToColor(
        //       //                                     AppColors.whiteTextColor),
        //       //                                 fontSize: 15.0),
        //       //                           ))),
        //       //                 ),
        //       //                 Row(
        //       //                   mainAxisAlignment:
        //       //                       MainAxisAlignment.spaceEvenly,
        //       //                   children: [
        //       //                     TextButton(
        //       //                         onPressed: () async {
        //       //                           closeCreateCenterPage();
        //       //                         },
        //       //                         child: Text("Cancel",
        //       //                             style: kGoogleStyleTexts.copyWith(
        //       //                               fontWeight: FontWeight.w700,
        //       //                               fontSize: 20,
        //       //                               color: hexToColor(
        //       //                                   AppColors.whiteTextColor),
        //       //                             ))),
        //       //                     TextButton(
        //       //                       onPressed: () async {
        //       //                         addCenter(
        //       //                             locationController.text.toString());
        //       //                         closeCreateCenterPage();
        //       //                       },
        //       //                       child: Text(
        //       //                         "Save",
        //       //                         style: kGoogleStyleTexts.copyWith(
        //       //                           fontWeight: FontWeight.w700,
        //       //                           fontSize: 20,
        //       //                           color: hexToColor(
        //       //                               AppColors.whiteTextColor),
        //       //                         ),
        //       //                       ),
        //       //                     ),
        //       //                   ],
        //       //                 )
        //       //               ],
        //       //             ))),
        //       //       )
        //       //     : SizedBox(
        //       //         height: 5,
        //       //       ),
        //       // Padding(
        //       //   padding: const EdgeInsets.only(top: 25.0, bottom: 10, left: 25),
        //       //   child: Align(
        //       //     alignment: Alignment.centerLeft,
        //       //     child: Text("All Centers",
        //       //         style: kGoogleStyleTexts.copyWith(
        //       //           fontWeight: FontWeight.w700,
        //       //           fontSize: 20,
        //       //           color: hexToColor(AppColors.whiteTextColor),
        //       //         )),
        //       //   ),
        //       // ),
        //       // Align(
        //       //   alignment: Alignment.centerLeft,
        //       //   child: FutureBuilder<List<CenterData>>(
        //       //       future: getCenterList(),
        //       //       builder: (BuildContext context,
        //       //           AsyncSnapshot<List<CenterData>> snapshot) {
        //       //         if (snapshot.connectionState == ConnectionState.done) {
        //       //           if (snapshot.hasError) {
        //       //             return Center(
        //       //               child: Text(
        //       //                 '${snapshot.error} occurred',
        //       //                 style: TextStyle(fontSize: 18),
        //       //               ),
        //       //             );
        //       //           } else if (snapshot.hasData) {
        //       //             centerList = snapshot.data!;
        //       //             centerList
        //       //                 .sort((a, b) => a.location.compareTo(b.location));
        //       //             return Column(
        //       //               crossAxisAlignment: CrossAxisAlignment.start,
        //       //               mainAxisAlignment: MainAxisAlignment.start,
        //       //               children: centerList
        //       //                   .map((e) => getCenterRow(e.location))
        //       //                   .toList(),
        //       //             );
        //       //           }
        //       //         }
        //       //
        //       //         return Padding(
        //       //           padding: const EdgeInsets.symmetric(
        //       //               vertical: 8.0, horizontal: 35),
        //       //           child: Center(
        //       //             child: LinearProgressIndicator(
        //       //               color: hexToColor(AppColors.appThemeColor),
        //       //               backgroundColor:
        //       //                   hexToColor(AppColors.whiteTextColor),
        //       //             ),
        //       //           ),
        //       //         );
        //       //       }),
        //       // ),
        //     ],
        //   ),
        // ),
      ),
    );
 */
