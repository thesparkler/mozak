import 'package:flutter/material.dart';
import 'package:mozak/model/attendanceTable.dart';
import 'package:mozak/model/weekly_forum_event.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/api_service.dart';

import '../constants/AppColors.dart';
import '../model/youth.dart';
import '../utils/app_tools.dart';

class AttendancePage extends StatefulWidget {
  WeeklyForumEvent event;
  AttendancePage(this.event);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<AttendanceTable> attendanceTableList;
  late Youth selectedYouth;
  int selectedID = 0;
  int index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showOptions = false;
  TextEditingController fieldTextEditingController = new TextEditingController();
  FocusNode fieldFocusNode = new FocusNode();
  GlobalKey key = new GlobalKey();

  @override
  void initState() {
    getYouthList();
    // getAttendanceData();
    super.initState();
  }

  late List<Youth> youthList;
  // late List<Youth> selectedYouths;

  void getYouthList() async {
    youthList = await ApiService().getAllYouths();
  }

  // void getAttendanceData() async {
  //   attendanceTableList = await ApiService().getAttendanceTable();
  //   for (int i = 0; i < attendanceTableList.length; i++)
  //     selectedYouths.add(attendanceTableList[i].youth!);
  //   print(selectedYouths.toString());
  //   print(youthList.toString());
  // }

  void clearSearchField () {
      fieldTextEditingController.clear();
      setState(() {
        showOptions = false;
      });
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
      body: Column(
        children: [
          TextField(
            autofocus: true,
            focusNode: fieldFocusNode,
            controller: fieldTextEditingController,
                  decoration: InputDecoration(
                    hintText: "Search with code or name",
                    hintStyle: kGoogleStyleTexts.copyWith(
                        color: hexToColor(AppColors.grey), fontSize: 18),
                    suffixIcon: IconButton(
                      onPressed: clearSearchField,
                      icon: Icon(Icons.clear_rounded),
                      padding: EdgeInsets.all(8),
                      visualDensity: VisualDensity(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 5.0),
                    ),
                  ),

                  style: TextStyle(
                      color: hexToColor(AppColors.whiteTextColor),
                      fontWeight: FontWeight.bold),
                ),

          RawAutocomplete<Youth>(
            key: key,
            textEditingController: fieldTextEditingController,
            focusNode: fieldFocusNode,
            optionsBuilder: (TextEditingValue textEditingValue) {
              return youthList
                  .where((Youth youth) =>
                      "${youth.rollno + " " + youth.youthFullName}"
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()))
                  .toList();
            },
            displayStringForOption: (Youth option) =>
                option.rollno + " " + option.youthFullName,
            // fieldViewBuilder: (BuildContext context,
            //     fieldTextEditingController,
            //     fieldFocusNode,
            //     VoidCallback onFieldSubmitted) {
            //   return Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: TextField(
            //       decoration: InputDecoration(
            //         hintText: "Search With Code or Name",
            //         hintStyle: kGoogleStyleTexts.copyWith(
            //             color: hexToColor(AppColors.grey), fontSize: 18),
            //         suffixIcon: IconButton(
            //           onPressed: () => fieldTextEditingController.clear(),
            //           icon: Icon(Icons.clear_rounded),
            //           padding: EdgeInsets.all(8),
            //           visualDensity: VisualDensity(),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.white, width: 5.0),
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide:
            //               BorderSide(color: Colors.blueAccent, width: 5.0),
            //         ),
            //       ),
            //       // focusNode: fieldFocusNode,
            //       controller: fieldTextEditingController,
            //       style: TextStyle(
            //           color: hexToColor(AppColors.whiteTextColor),
            //           fontWeight: FontWeight.bold),
            //     ),
            //   );
            // },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<Youth> onSelected,
                Iterable<Youth> options) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: hexToColor(AppColors.appThemeColor),
                    border: Border.fromBorderSide(BorderSide()),
                  ),
                  height: 350,
                  width: bodyWidth - 20,
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: options.length,
                      itemBuilder: (context, int index) {
                        Youth option = options.elementAt(index);
                        // bool selected = selectedYouths.contains(youthList[index]);
                        return TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber),
                          ),
                          onPressed: () {
                            setState(() {
                              showOptions = true;
                              selectedYouth = option;
                            });
                            onSelected(option);
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                                option.rollno + " " + option.youthFullName,
                                style: kGoogleStyleTexts.copyWith(
                                    fontSize: 20,
                                    color: hexToColor(
                                        AppColors.whiteTextColor))),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            onSelected: (Youth youth) {
              selectedYouth = youth;
            },
          ),
          if(showOptions) Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: clearSearchField,
                child: Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 70.0,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  print(selectedYouth);
                  clearSearchField();
                  await ApiService().markAttendance(selectedYouth, widget.event);
                },
                child: Icon(
                  Icons.thumb_up_sharp,
                  color: Colors.yellowAccent,
                  size: 70.0,
                ),
              )
            ],
          )
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
