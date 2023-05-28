import 'package:flutter/material.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/model/weekly_forum_event.dart';

import '../constants/AppColors.dart';
import '../utils/app_tools.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<WeeklyForumEvent> wfeList;

  int index = 0;
  bool showCreateCenterCard = false;
  TextEditingController locationController = new TextEditingController();

  void openCreateAttendancePage() {
    showCreateCenterCard = true;

    setState(() {});
  }

  void closeCreateAttendancePage() {
    print("hii");
    setState(() {
      showCreateCenterCard = false;
    });
  }

  void addCenter(String location) {
    ApiService().setCenter(location);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<List<WeeklyForumEvent>>> getWfeList() {
    var obj = ApiService().getCenters();
    return obj.then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    index = 0;
    final appBar = AppBar(
      title: Text(
        'Attendance Details',
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

    return Scaffold(
      appBar: appBar,
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: Column(
          children: [
            // Container(
            //   height: bodyHeight / 18,
            //   width: bodyWidth / 2,
            //   decoration: BoxDecoration(
            //       color: hexToColor(AppColors.paleOrange),
            //       backgroundBlendMode: BlendMode.lighten,
            //       border: Border.all(
            //         color: hexToColor(AppColors.paleOrange),
            //       ),
            //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
            //   child: TextButton(
            //       onPressed: openCreateAttendancePage,
            //       child: Text(
            //         "Add a new center",
            //         style: kGoogleStyleTexts.copyWith(
            //           fontWeight: FontWeight.w700,
            //           fontSize: 16,
            //           color: hexToColor(AppColors.whiteTextColor),
            //         ),
            //         textAlign: TextAlign.center,
            //       )),
            // ),
            // showCreateCenterCard
            //     ? Card(
            //         elevation: 50,
            //         shadowColor: Colors.black,
            //         color: hexToColor(AppColors.paleOrange),
            //         child: Form(
            //             child: Column(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(5.0),
            //                     border: Border.all(
            //                       color: hexToColor(
            //                           AppColors.textFieldOutlineBorderColor),
            //                       width: 1.0,
            //                     ),
            //                   ),
            //                   width: MediaQuery.of(context).size.width,
            //                   child: Padding(
            //                       padding: const EdgeInsets.only(left: 10.0),
            //                       child: TextField(
            //                         controller: locationController,
            //                         style: kGoogleStyleTexts.copyWith(
            //                             fontWeight: FontWeight.w400,
            //                             color: hexToColor(
            //                                 AppColors.whiteTextColor),
            //                             fontSize: 15.0),
            //                       ))),
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 TextButton(
            //                     onPressed: () async {
            //                       closeCreateAttendancePage();
            //                     },
            //                     child: Text("Cancel",
            //                         style: kGoogleStyleTexts.copyWith(
            //                           fontWeight: FontWeight.w700,
            //                           fontSize: 20,
            //                           color:
            //                               hexToColor(AppColors.whiteTextColor),
            //                         ))),
            //                 TextButton(
            //                     onPressed: () async {
            //                       addCenter(locationController.text.toString());
            //                       closeCreateAttendancePage();
            //                     },
            //                     child: Text("Save",
            //                         style: kGoogleStyleTexts.copyWith(
            //                           fontWeight: FontWeight.w700,
            //                           fontSize: 20,
            //                           color:
            //                               hexToColor(AppColors.whiteTextColor),
            //                         ))),
            //               ],
            //             )
            //           ],
            //         )))
            //     : SizedBox(
            //         height: 5,
            //       ),
            FutureBuilder<List<center.Center>>(
                future: getCenterList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<center.Center>> snapshot) {
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
                      // return Column(
                      //   children: centerList
                      //       .map((e) => getCenterRow(e.location))
                      //       .toList(),
                      // );
                      return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection:
                              axisDirectionToAxis(AxisDirection.down),
                          shrinkWrap: true,
                          itemCount: centerList.length,
                          itemBuilder: (context, index) {
                            return Table();
                          });
                    }
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
              child: Text(index.toString(),
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.whiteTextColor),
                  ))),
          Container(child: Text(" $name"))
        ],
      ),
    );
  }
}
