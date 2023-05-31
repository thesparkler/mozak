import 'package:flutter/material.dart';

import '../constants/AppColors.dart';
import '../model/attendanceTable.dart';
import '../model/youth.dart';
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
    List<Youth> youthList;
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

    List<AttendanceTable> attendanceTableList;

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Column(
        children: [
          // Container(
          //   height: bodyHeight,
          //   width: bodyWidth,
          //   padding: const EdgeInsets.all(20.0),
          //   child: GridView.builder(
          //       itemCount: options.length,
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           childAspectRatio: 1.2,
          //           crossAxisCount: 2,
          //           mainAxisSpacing: 20,
          //           crossAxisSpacing: 20),
          //       itemBuilder: (context, index) {
          //         return Card(
          //           color: hexToColor(AppColors.paleOrange),
          //           elevation: 0,
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: TextButton(
          //               onPressed: () async {
          //                 goto(options[index]);
          //               },
          //               child: Text(
          //                 '${options[index]}',
          //                 style: kGoogleStyleTexts.copyWith(
          //                   fontWeight: FontWeight.w700,
          //                   fontSize: 18,
          //                   color: hexToColor(AppColors.whiteTextColor),
          //                 ),
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //           ),
          //         );
          //       }),
          // ),
          Form(
            child: FutureBuilder<List<Youth>>(
                future: ApiService().getAllYouths(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Youth>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      youthList = snapshot.data!;
                      return Autocomplete<Youth>(
                        optionsBuilder: (TextEditingValue controller) {
                          // if (controller.text == '') {
                          //   return const Iterable<Youth>.empty();
                          // }
                          return youthList
                              .where((Youth youth) => youth
                                  .toString()
                                  .contains(controller.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (Youth option) =>
                            option.rollno + " " + option.youthFullName,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextField(
                            focusNode: fieldFocusNode,
                            controller: fieldTextEditingController,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<Youth> onSelected,
                            Iterable<Youth> options) {
                          return Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 300,
                              width: bodyWidth - 30,
                              color: hexToColor(AppColors.appThemeColor),
                              child: ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (context, int index) {
                                  Youth option = options.elementAt(index);
                                  return TextButton(
                                    onPressed: () async {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(
                                          option.rollno +
                                              " " +
                                              option.youthFullName,
                                          style:
                                              TextStyle(color: Colors.white)),
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
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          // TextField(
          //   controller: controller,
          // )
        ],
      ),
    );
  }
}
