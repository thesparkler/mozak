import 'package:flutter/material.dart';
import 'package:mozak/screens/event_attendance.dart';

import '../model/weekly_forum_event.dart';
import '../utils/api_service.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  int index = 0;
  late List<WeeklyForumEvent> wfeList;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WeeklyForumEvent>>(
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
        });
  }
  Future<List<WeeklyForumEvent>> getWFEventList() {
    var obj = ApiService().getWFEvents();
    return obj.then((value) => value);
  }

  Widget getWFERow(WeeklyForumEvent event) {
    index++;
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventAttendance(event)
            )
        );
      },
      child: Row(
        children: [
          Container(child: Text(index.toString())),
          Container(child: Text(event.center.location),
            margin: EdgeInsets.all(10),),
          Container(child: Text(event.date.toString()))
        ],
      ),
    );
  }
}
