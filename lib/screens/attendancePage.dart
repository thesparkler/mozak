import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mozak/model/attendanceTable.dart';
import 'package:mozak/model/weekly_forum_event.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/utils/youthData.dart';

import '../constants/AppColors.dart';
import '../model/youth.dart';
import '../utils/app_tools.dart';

class AttendancePage extends StatefulWidget {
  final WeeklyForumEvent event;
  AttendancePage(this.event);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<AttendanceTable> attendanceTableList;
  late Youth selectedYouth;
  late List<Youth> youthList;

  int selectedID = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showOptions = false;
  TextEditingController fieldTextEditingController = TextEditingController();
  FocusNode fieldFocusNode = new FocusNode();
  GlobalKey key = new GlobalKey();
  late List<Youth> eventMarkedAttendance;
  var youths = <String, dynamic>{
    "CR": {
      "01": [],
    },
    "GK": {
      "01": [],
      "02": [],
      "03": [],
      "04": [],
      "05": [],
      "06": [],
    }
  };

  // Future<void> getData() async {
  //   await getYouthList();
  //   // await getMarkedList();
  // }

  @override
  void initState() {
    // getData().whenComplete(() async {
    //   print("Done");
    // });
    // print(youths);
    super.initState();
  }


  void getYouthList() async {
    youthList = await ApiService().getAllYouths();

  }

  Stream<List<Youth>> _bids(int id) => (() {
        late final StreamController<List<Youth>> _attendanceStream;
        _attendanceStream = StreamController<List<Youth>>(
          onListen: () async {
            _attendanceStream.add(await ApiService().getMarkedYouths(id));
            _attendanceStream.close();
          },
        );
        return _attendanceStream.stream;
      })();

  void clearSearchField() {
    fieldTextEditingController.clear();
    setState(() {
      showOptions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(
        '${widget.event.center}  ${widget.event.date}',
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

    // final bodyHeight = mediaQuery.size.height -
    //     appBar.preferredSize.height -
    //     mediaQuery.padding.top -
    //     mediaQuery.padding.bottom;

    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 60,
                  child: TextField(
                    autofocus: true,
                    focusNode: fieldFocusNode,
                    controller: fieldTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Search with code or name",
                      hintStyle: kGoogleStyleTexts.copyWith(
                          color: hexToColor(AppColors.grey), fontSize: 18),
                      suffixIcon: IconButton(
                        onPressed: clearSearchField,
                        icon: Icon(
                          Icons.clear_rounded,
                          color: hexToColor(AppColors.whiteTextColor),
                        ),
                        padding: EdgeInsets.all(8),
                        visualDensity: VisualDensity(),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    style: TextStyle(
                        color: hexToColor(AppColors.whiteTextColor),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              RawAutocomplete<Youth>(
                key: key,
                textEditingController: fieldTextEditingController,
                focusNode: fieldFocusNode,
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty)
                    return const Iterable<Youth>.empty();
                  getYouthList();
                  return YouthData.instance.youthList
                      .where((Youth youth) =>
                          "${youth.rollno + " " + youth.youthFullName}"
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                      .toList();
                },
                displayStringForOption: (Youth option) =>
                    option.rollno + " " + option.youthFullName,
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<Youth> onSelected,
                    Iterable<Youth> options) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: bodyWidth,
                      ),
                      decoration: BoxDecoration(
                        color: hexToColor(AppColors.appThemeColor),
                      ),
                      //height: 350,
                      width: bodyWidth - 20,
                      child: Scrollbar(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(4.0),
                          itemCount: options.length,
                          itemBuilder: (context, int index) {
                            Youth option = options.elementAt(index);
                            // bool selected = selectedYouths.contains(youthList[index]);
                            return TextButton(
                              style: ButtonStyle(
                                  textStyle:
                                      MaterialStateProperty.all(TextStyle()),
                                  alignment: Alignment.topLeft,
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(left: 10, bottom: 5)),
                                  backgroundColor: MaterialStateProperty.all(
                                      hexToColor(AppColors.whiteTextColor)
                                          .withOpacity(.1)),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(bodyWidth - 32, 40))),
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
                                    color: hexToColor(AppColors.whiteTextColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                onSelected: (Youth youth) {
                  selectedID = youth.id;
                  selectedYouth = youth;
                },
              ),
              if (showOptions)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // GestureDetector(
                    //   onTap: clearSearchField,
                    //   child: Icon(
                    //     Icons.cancel,
                    //     color: Colors.redAccent,
                    //     size: 70.0,
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     print(selectedYouth);
                    //     clearSearchField();
                    //     await ApiService()
                    //         .markAttendance(selectedID, widget.event.id);
                    //   },
                    //   child: Icon(
                    //     Icons.thumb_up_sharp,
                    //     color: Colors.yellowAccent,
                    //     size: 70.0,
                    //   ),
                    // ),
                    TextButton(
                        onPressed: () async {
                          clearSearchField();
                        },
                        child: Text("Drop",
                            style: kGoogleStyleTexts.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: hexToColor(AppColors.whiteTextColor),
                            ))),
                    TextButton(
                        onPressed: () async {
                          print(selectedYouth);
                          await ApiService()
                              .markAttendance(widget.event.id, selectedID);
                          clearSearchField();
                        },
                        child: Text("Mark",
                            style: kGoogleStyleTexts.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: hexToColor(AppColors.whiteTextColor),
                            ))),
                  ],
                ),
              Text(
                "All Marked Youths",
                style: kGoogleStyleTexts.copyWith(
                  fontSize: 20,
                  color: hexToColor(AppColors.whiteTextColor),
                ),
              ),
              Column(
                children: [
                  StreamBuilder<List<Youth>>(
                    stream: _bids(widget.event.id),
                    builder: (context, snapshot) {
                      // if (snapshot.connectionState == ConnectionState.done &&
                      //     snapshot.hasData)
                      //   return Center();
                      // else if (snapshot.connectionState ==
                      //     ConnectionState.waiting)
                      //   LinearProgressIndicator(
                      //     color: hexToColor(AppColors.whiteTextColor),
                      //   );
                      // else
                      //   Text(snapshot.hasError.toString());
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LinearProgressIndicator(
                          color: hexToColor(AppColors.whiteTextColor),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          eventMarkedAttendance = snapshot.data!;
                          //eventMarkedAttendance.sort((a, b) => a.rollno.compareTo(b.rollno));
                          return Scrollbar(
                            child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: eventMarkedAttendance.length,
                              itemBuilder: (context, int index) {
                                Youth option = eventMarkedAttendance[index];
                                // bool selected = selectedYouths.contains(youthList[index]);
                                return TextButton(
                                  style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle()),
                                      alignment: Alignment.topLeft,
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.only(left: 10, bottom: 5)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              hexToColor(AppColors.paleOrange)),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(bodyWidth - 32, 40))),
                                  onPressed: () {
                                    // onSelected(option);
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      '${option.rollno}  ${option.youthFullName}',
                                      style: kGoogleStyleTexts.copyWith(
                                        fontSize: 18,
                                        color: hexToColor(
                                            AppColors.whiteTextColor),
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
/*
Scrollbar(
                                child: ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, int index) {
                                    eventMarkedAttendance = snapshot.data!;
                                    Youth option = eventMarkedAttendance[index];
                                    // bool selected = selectedYouths.contains(youthList[index]);
                                    return ExpansionTile(
                                      title: Text(
                                        "${youths.keys}",
                                      ),
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                              textStyle:
                                                  MaterialStateProperty.all(
                                                      TextStyle()),
                                              alignment: Alignment.topLeft,
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.only(
                                                          left: 10, bottom: 5)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      hexToColor(AppColors
                                                          .paleOrange)),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(
                                                          bodyWidth - 32, 40))),
                                          onPressed: () {
                                            // onSelected(option);
                                          },
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              option.rollno +
                                                  " " +
                                                  option.youthFullName,
                                              style: kGoogleStyleTexts.copyWith(
                                                fontSize: 18,
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
                                              ),
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
 */
