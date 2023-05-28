import 'package:flutter/material.dart';
import 'package:mozak/model/weekly_forum_event.dart';
import 'package:mozak/utils/api_service.dart';

import '../model/youth.dart';

class EventAttendance extends StatefulWidget {
  late WeeklyForumEvent event;
  EventAttendance(this.event);

  @override
  State<EventAttendance> createState() => _EventAttendanceState();
}

class _EventAttendanceState extends State<EventAttendance> {
  final TextEditingController searchController = TextEditingController();
  late List<Youth> youthList;

  void getYouthList() async {
    youthList = await ApiService().getAllYouths();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> _kOptions = <String>[
      'aardvark',
      'bobcat',
      'chameleon',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
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
          FutureBuilder<List<Youth>>(
              future: ApiService().getAllYouths(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Youth>> snapshot) {
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
                        displayStringForOption: (youth) => youth.toString(),
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<Youth>.empty();
                          }
                          return youthList.where((Youth option) {
                            return option
                                .toString()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        });
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }
}
