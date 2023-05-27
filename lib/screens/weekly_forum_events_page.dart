import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mozak/model/weekly_forum_event.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/model/center.dart' as center;

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

  void onDateChanged(DateTime date) {
    dateSelected = date;
  }

  void openCreateWFEPage() {
    showCreatWFECard = true;
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
    return obj.then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController centerController = new TextEditingController();
    final List<DropdownMenuEntry<center.Center>> centerEntries =
        <DropdownMenuEntry<center.Center>>[];
    center.Center? selectedCenter;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
                onPressed: openCreateWFEPage,
                child: Text("Add a new Weekly Forum event")),
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

                      return Card(
                          elevation: 50,
                          shadowColor: Colors.black,
                          color: Colors.greenAccent[100],
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
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                  onDateChanged: onDateChanged),
                              TextButton(
                                  onPressed: () =>
                                      addWFEvent(selectedCenter!, dateSelected),
                                  child: Text("SAVE"))
                            ],
                          )));
                    }
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
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
                      return Column(
                        children: wfeList.map((e) => getWFERow(e)).toList(),
                      );
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

  Widget getWFERow(WeeklyForumEvent event) {
    index++;
    return Row(
      children: [
        Container(child: Text(index.toString())),
        Container(child: Text(event.center.location)),
        Container(child: Text(event.date.toString()))
      ],
    );
  }

  Future<List<center.Center>> getCenterList() {
    var obj = ApiService().getCenters();
    return obj.then((value) => value);
  }
}
