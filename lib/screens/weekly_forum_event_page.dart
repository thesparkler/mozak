import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mozak/model/attendanceTable.dart';
import 'package:mozak/model/weekly_forum_event.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/model/center.dart' as center;

import '../constants/AppColors.dart';
import '../utils/app_tools.dart';
import 'attendancePage.dart';

class WeeklyForumEventsPage extends StatefulWidget {
  const WeeklyForumEventsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyForumEventsPage> createState() => _WeeklyForumEventsPageState();
}

class _WeeklyForumEventsPageState extends State<WeeklyForumEventsPage> {
  late List<WeeklyForumEvent> wfeList;
  int index = 0;
  bool showCreatWFECard = false;
  DateTime dateSelected = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  void onDateChanged(DateTime date) {
    dateSelected = DateFormat('yyyy-MM-dd').parse(date.toString());
  }

  void openCreateWFEPage() {
    showCreatWFECard = true;
    setState(() {});
  }

  void openCloseWFEPage() {
    showCreatWFECard = false;
    setState(() {});
  }

  void addWFEvent(center.Center center, DateTime date) {
    ApiService().setWFEvent(center, DateFormat('yyyy-MM-dd').format(date));
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<WeeklyForumEvent>> getWFEventList() {
    var obj = ApiService().getWFEvents();
    return obj;
  }

  Future<List<center.Center>> getCenterList() {
    var obj = ApiService().getCenters();
    return obj.then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    index = 0;
    final appBar = AppBar(
      title: Text(
        'Attendance',
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
    TextEditingController centerController = new TextEditingController();
    final List<DropdownMenuEntry<center.Center>> centerEntries =
        <DropdownMenuEntry<center.Center>>[];
    center.Center? selectedCenter;

    return Scaffold(
      appBar: appBar,
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Column(
        children: [
          Container(
            height: bodyHeight / 18,
            width: bodyWidth / 1.5,
            decoration: BoxDecoration(
                color: hexToColor(AppColors.paleOrange),
                backgroundBlendMode: BlendMode.lighten,
                border: Border.all(
                  color: hexToColor(AppColors.paleOrange),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: TextButton(
              onPressed: openCreateWFEPage,
              child: Text(
                "New Weekly Forum event",
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: hexToColor(AppColors.whiteTextColor),
                ),
              ),
            ),
          ),
          FutureBuilder(
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

                    // if we got our data
                  } else if (snapshot.hasData) {
                    // print(snapshot.data);
                    List<center.Center>? centerList = snapshot.data;
                    for (var center in centerList!) {
                      // print(center);
                      centerEntries.add(DropdownMenuEntry(
                          value: center, label: center.location));
                    }

                    return showCreatWFECard
                        ? Card(
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: hexToColor(AppColors.paleOrange),
                            child: Form(
                                child: Column(
                              children: [
                                DropdownMenu(
                                  dropdownMenuEntries: centerEntries,
                                  controller: centerController,
                                  onSelected: (center.Center? center) {
                                    selectedCenter = center;
                                  },
                                ),
                                CalendarDatePicker(
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(3000),
                                    onDateChanged: onDateChanged),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                          openCloseWFEPage();
                                        },
                                        child: Text("Cancel",
                                            style: kGoogleStyleTexts.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: hexToColor(
                                                  AppColors.whiteTextColor),
                                            ))),
                                    TextButton(
                                        onPressed: () async {
                                          addWFEvent(
                                              selectedCenter!, dateSelected);
                                          openCloseWFEPage();
                                        },
                                        child: Text("Save",
                                            style: kGoogleStyleTexts.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: hexToColor(
                                                  AppColors.whiteTextColor),
                                            ))),
                                  ],
                                )
                              ],
                            )))
                        : Container();
                  }
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 25.0, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Events",
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: hexToColor(AppColors.whiteTextColor),
                ),
              ),
            ),
          ),
          FutureBuilder<List<WeeklyForumEvent>>(
            future: getWFEventList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<WeeklyForumEvent>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  wfeList = snapshot.data!;
                  wfeList.sort((a, b) => b.date.compareTo(a.date));
                  return Column(
                    children: wfeList.map((e) => getWFERow(e)).toList(),
                  );
                }
              }

              return Center(
                child: CircularProgressIndicator(
                  color: hexToColor(AppColors.whiteTextColor),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getWFERow(WeeklyForumEvent event) {
    index++;
    //InkWell(
    //       onTap: () async {
    //         Navigator.of(context).pushNamed("AttendancePage");
    //       },),
    return InkWell(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                AttendancePage(event.center, DateTime.parse(event.date))))
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 8),
        child: Container(
          child: Row(
            children: [
              Container(
                child: Text(
                  index.toString() + " ",
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.whiteTextColor),
                  ),
                ),
              ),
              Container(
                child: Text(
                  event.center.location + " ",
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.whiteTextColor),
                  ),
                ),
              ),
              Container(
                child: Text(
                  event.date.toString(),
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.whiteTextColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
