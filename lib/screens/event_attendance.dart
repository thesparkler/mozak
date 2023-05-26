import 'package:flutter/material.dart';
import 'package:mozak/model/weekly_forum_event.dart';

class EventAttendance extends StatefulWidget {
  late WeeklyForumEvent event;
  EventAttendance(this.event);

  @override
  State<EventAttendance> createState() => _EventAttendanceState();
}

class _EventAttendanceState extends State<EventAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
        Row(
          children: [
            Container(
                child: Text(widget.event.date),
              margin: EdgeInsets.all(10),
            ),
            
            Text(widget.event.center.location)
          ],
        ),
      ),

      body: Column(
        children: [
          TextField(),
          ListView(
            scrollDirection: Axis.vertical,
          )
        ],
      ),
    );
  }

  
}
