import 'package:flutter/material.dart';
import 'package:mozak/model/attendanceTable.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/model/weekly_forum_event.dart';

import '../constants/AppColors.dart';
import '../model/youth.dart';
import '../utils/app_tools.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage(WeeklyForumEvent event);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<AttendanceTable> attendanceTableList;

  int index = 0;
  //bool showCreateCenterCard = false;
  //TextEditingController locationController = new TextEditingController();

  // void openCreateAttendancePage() {
  //   //showCreateCenterCard = true;
  //
  //   setState(() {});
  // }
  //
  // void closeCreateAttendancePage() {
  //   print("hii");
  //   setState(() {
  //     showCreateCenterCard = false;
  //   });
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  late List<Youth> youthList;

  Future<List<Youth>> getYouthList() async {
    youthList = await ApiService().getAllYouths();
    return youthList;
  }

  Future<List<AttendanceTable>> getAttendanceData() {
    var obj = ApiService().getAttendanceTable();
    return obj;
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
      // body: ScrollConfiguration(
      //   behavior: NoGlowBehaviour(),
      //   child: Column(
      //     children: [
      //       FutureBuilder<List<AttendanceTable>>(
      //           future: getAttendanceData(),
      //           builder: (BuildContext context,
      //               AsyncSnapshot<List<AttendanceTable>> snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done) {
      //               if (snapshot.hasError) {
      //                 return Center(
      //                   child: Text(
      //                     '${snapshot.error} occurred',
      //                     style: TextStyle(fontSize: 18),
      //                   ),
      //                 );
      //               } else if (snapshot.hasData) {
      //                 attendanceTableList = snapshot.data!;
      //                 // return Column(
      //                 //   children: centerList
      //                 //       .map((e) => getCenterRow(e.location))
      //                 //       .toList(),
      //                 // );
      //                 // return ListView.builder(
      //                 //     physics: const ClampingScrollPhysics(),
      //                 //     scrollDirection:
      //                 //         axisDirectionToAxis(AxisDirection.down),
      //                 //     shrinkWrap: true,
      //                 //     itemCount: attendanceTableList.length,
      //                 //     itemBuilder: (context, index) {
      //                 //       return Table();
      //                 //     });
      //
      //               }
      //             }
      //
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }),
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          FutureBuilder<List<Youth>>(
              future: ApiService().getAllYouths(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Youth>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    // youthList = snapshot.data!;
                    return Autocomplete<Youth>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return youthList
                            .where((Youth youth) =>
                                "${youth.rollno + " " + youth.youthFullName}"
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (Youth option) =>
                          option.youthFullName + " " + option.rollno,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          key: _formKey,
                          focusNode: fieldFocusNode,
                          controller: fieldTextEditingController,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<Youth> onSelected,
                          Iterable<Youth> options) {
                        return Align(
                          alignment: Alignment.center,
                          child: Material(
                            child: Container(
                              width: bodyWidth - 303,
                              color: hexToColor(AppColors.appThemeColor),
                              child: ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Youth option = options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(
                                          option.rollno +
                                              " " +
                                              option.youthFullName,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      onSelected: (Youth selection) {
                        print(
                            'Selected: ${selection.rollno + " " + selection.youthFullName}');
                      },
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
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
