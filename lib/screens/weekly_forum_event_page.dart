import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mozak/screens/attendancePage.dart';
import 'package:mozak/model/weekly_forum_event.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/model/center.dart' as center;
import 'package:mozak/utils/youthData.dart';
import '../constants/AppAssets.dart';
import '../constants/AppColors.dart';
import '../constants/AppStrings.dart';
import '../utils/NoGlowBehaviour.dart';
import '../utils/app_tools.dart';

class WeeklyForumEventsPage extends StatefulWidget {
  WeeklyForumEventsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyForumEventsPage> createState() => _WeeklyForumEventsPageState();
}

class _WeeklyForumEventsPageState extends State<WeeklyForumEventsPage> {
  late List<WeeklyForumEvent> wfeList;
  int index = 0;
  bool showCreateWFECard = false;
  DateTime dateSelected = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var userName = '';
  var dateController = TextEditingController(text: "");
  var selected;
  var date;

  void onDateChanged(DateTime date) {
    dateSelected = DateFormat('yyyy-MM-dd').parse(date.toString());
  }

  void openCreateWFEPage() {
    showCreateWFECard = true;
    setState(() {});
  }

  void openCloseWFEPage() {
    showCreateWFECard = false;
    setState(() {});
  }

  void addWFEvent(center.CenterData center, DateTime date) {
    ApiService().setWFEvent(center, DateFormat('yyyy-MM-dd').format(date));
  }

  @override
  void initState() {
    super.initState();
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

    TextEditingController centerController = TextEditingController();
    final List<DropdownMenuEntry<center.CenterData>> centerEntries =
        <DropdownMenuEntry<center.CenterData>>[];
    center.CenterData? selectedCenter;

    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: SingleChildScrollView(
          child: Column(
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
                  onPressed: () async {
                    openCreateWFEPage();
                  },
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
              //AlertDialog(),
              FutureBuilder(
                  future: YouthData.instance.getCenterList(),
                  builder: (context,
                      AsyncSnapshot<List<center.CenterData>> snapshot) {
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
                        List<center.CenterData>? centerList = snapshot.data;
                        for (var center in centerList!) {
                          // print(center);
                          centerEntries.add(DropdownMenuEntry(
                              value: center, label: center.location));
                        }

                        return showCreateWFECard
                            ? Form(
                                onWillPop: () async {
                                  print("Hii");
                                  return true;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                            color: hexToColor(AppColors
                                                .textFieldOutlineBorderColor),
                                            width: 1.0,
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: DropdownMenu(
                                            width: bodyWidth * .5,
                                            dropdownMenuEntries: centerEntries,
                                            controller: centerController,
                                            onSelected:
                                                (center.CenterData? center) {
                                              selectedCenter = center;
                                            },
                                            menuStyle: MenuStyle(),
                                          ),
                                        ),
                                      ),
                                      CalendarDatePicker(
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime(3000),
                                          onDateChanged: onDateChanged),
                                      _dobTapHereIcon(),
                                      Container(
                                        child:
                                            dateController.text.toString() == ''
                                                ? Container()
                                                : _dateOfBirthField(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                openCloseWFEPage();
                                              },
                                              child: Text("Cancel",
                                                  style: kGoogleStyleTexts
                                                      .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: hexToColor(AppColors
                                                        .whiteTextColor),
                                                  ))),
                                          TextButton(
                                              onPressed: () async {
                                                addWFEvent(selectedCenter!,
                                                    dateSelected);
                                                openCloseWFEPage();
                                              },
                                              child: Text("Save",
                                                  style: kGoogleStyleTexts
                                                      .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: hexToColor(AppColors
                                                        .whiteTextColor),
                                                  ))),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                            : Container();
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 35),
                      child: Center(
                        child: LinearProgressIndicator(
                          color: hexToColor(AppColors.appThemeColor),
                          backgroundColor: hexToColor(AppColors.whiteTextColor),
                        ),
                      ),
                    );
                  }),
              Padding(
                padding:
                    const EdgeInsets.only(top: 25.0, left: 25.0, bottom: 10),
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
                future: YouthData.instance.getWFEventList(),
                builder:
                    (context, AsyncSnapshot<List<WeeklyForumEvent>> snapshot) {
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
                    child: LinearProgressIndicator(
                      color: hexToColor(AppColors.whiteTextColor),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: hexToColor(AppColors.orangeAccent),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: hexToColor(AppColors.appThemeColor),
          ),
          child: child ?? const Text(""),
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (selected != null) {
      var formatter = DateFormat('yyyy-MM-dd');

      setState(() {
        date = dateController.text = formatter.format(selected);
      });
    }
  }

  Widget _dateOfBirthField() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 40.0, right: 18.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.eventDate,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              height: 2 * 25.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: hexToColor(AppColors.grey),
                  width: 0.8,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  enabled: false,
                  controller: dateController,
                  decoration: const InputDecoration(
                      hintText: 'YYYY-MM-DD',
                      hintStyle:
                          TextStyle(color: Color(0xFF757575), fontSize: 15.0)),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dobTapHereIcon() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 30.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            color: hexToColor(AppColors.paleOrange),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.birthDateCalendar,
                      height: 50,
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        AppStrings.tapHereText,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 10.0,
                            height: 1.3),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getWFERow(WeeklyForumEvent event) {
    index++;
    return InkWell(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AttendancePage(
                event))) //(event.center, DateTime.parse(event.date))
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 8),
        child: Container(
          child: Row(
            children: [
              Text(
                index.toString() + " ",
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: hexToColor(AppColors.whiteTextColor),
                ),
              ),
              Text(
                event.center.location + " ",
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: hexToColor(AppColors.whiteTextColor),
                ),
              ),
              Text(
                event.date.toString(),
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: hexToColor(AppColors.whiteTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
