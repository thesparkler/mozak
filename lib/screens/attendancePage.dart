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
  late Youth selectedYouth;
  int selectedID = 0;
  int index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var showOptions = false;

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
      body: Column(
        children: [
          ScrollConfiguration(
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
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent, width: 5.0),
                      ),

                    ),
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
                            setState(() {
                              showOptions = true;
                              selectedYouth = option;
                            });
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
          if(showOptions) Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  print("done");

                  setState(() {
                    showOptions = false;
                  });
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 70.0,
                ),
              ),
              GestureDetector(
                onTap: (){
                  print(selectedYouth);
                },
                child: Icon(
                  Icons.thumb_up_sharp,
                  color: Colors.yellowAccent,
                  size: 70.0,
                ),
              ),
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
