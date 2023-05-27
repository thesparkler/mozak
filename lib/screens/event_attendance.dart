import 'package:flutter/material.dart';
import 'package:mozak/model/weekly_forum_event.dart';

import '../model/youth.dart';

class EventAttendance extends StatefulWidget {
  late WeeklyForumEvent event;
  EventAttendance(this.event);

  @override
  State<EventAttendance> createState() => _EventAttendanceState();
}

class _EventAttendanceState extends State<EventAttendance> {
  final TextEditingController searchController = TextEditingController();

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
          TextField(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(searchController),
                );
              }
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }


}

class DataSearch extends SearchDelegate<String>{
  final TextEditingController controller;
  DataSearch(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

}
