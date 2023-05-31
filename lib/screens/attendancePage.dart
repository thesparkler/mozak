import 'package:flutter/material.dart';
import 'package:mozak/model/attendanceTable.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/api_service.dart';

import '../constants/AppColors.dart';
import '../model/youth.dart';
import '../utils/app_tools.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage();

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<AttendanceTable> attendanceTableList;
  int selectedID = 0;
  int index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getYouthList().whenComplete(() => print("hii"));
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
      key: _scaffoldKey,
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
      body: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: Autocomplete<Youth>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return youthList
                .where((Youth youth) =>
                    "${youth.rollno + " " + youth.youthFullName}"
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                .toList();
          },
          displayStringForOption: (Youth option) =>
              option.youthFullName + " " + option.rollno,
          fieldViewBuilder: (BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: fieldFocusNode,
                controller: fieldTextEditingController,
                style: TextStyle(
                    color: hexToColor(AppColors.whiteTextColor),
                    fontWeight: FontWeight.bold),
              ),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<Youth> onSelected,
              Iterable<Youth> options) {
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 200,
                width: bodyWidth - 20,
                color: hexToColor(AppColors.appThemeColor),
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: options.length,
                  itemBuilder: (context, int index) {
                    Youth option = options.elementAt(index);
                    return TextButton(
                      onPressed: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option.rollno + " " + option.youthFullName,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          onSelected: (Youth selection) {
            print(
                'Selected: ${selection.rollno + " " + selection.youthFullName}');
            selectedID = selection.id!;
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
