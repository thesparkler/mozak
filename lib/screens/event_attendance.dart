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

  void getYouthList() async{
    youthList =  await ApiService().getAllYouths();
  }

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
  // List<Youth> youthList;
  final TextEditingController controller;

  DataSearch(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return Column(
      children: <Widget>[
        FutureBuilder<List<Youth>>(
          future: ApiService().getAllYouths(),
          builder: (context, AsyncSnapshot<List<Youth>> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data?.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Results Found.",
                  ),
                ],
              );
            } else {
              var results = snapshot.data;
              return ListView.builder(
                itemCount: results?.length,
                itemBuilder: (context, index) {
                  var result = results![index];
                  return ListTile(
                    title: Text("pramod"),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<String> youthList = ["pramod","amol"];
    for(var youth in youthList)
    {
      String youthName = youth?? "";
      if(youthName.contains(query.toLowerCase()) )
      {
        matchQuery.add(youthName);
      }
    }

    return ListView.builder(itemBuilder: (context,index){
      var result = matchQuery[index];
      return ListTile(title: Text(result),);
    },itemCount: matchQuery.length,);
  }

}
