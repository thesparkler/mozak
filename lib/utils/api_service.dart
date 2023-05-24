import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/weekly_forum_event.dart';
import '../model/center.dart' as center;
import 'constants.dart';

class ApiService{
  ApiService._sharedInstance();
  static final ApiService _shared = ApiService._sharedInstance();
  factory ApiService() => _shared;

  Future<List<WeeklyForumEvent>> getWFEvents() async {
    Uri allWeeklyForumEventsUrl = Uri.parse('${Constants.domain}${Constants.allWFEvents}');
    http.Response response =await http.get(allWeeklyForumEventsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<WeeklyForumEvent> list = [];
      var jsonObject = jsonDecode(response.body);
      for(var json in jsonObject){
        list.add(WeeklyForumEvent.fromJson(json));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // In following code Center class is creating conflict with a class of same name in Flutter lib.
  Future<List<center.Center>> getCenters() async {
    Uri allWeeklyForumEventsUrl = Uri.parse('${Constants.domain}${Constants.allCenters}');
    http.Response response =await http.get(allWeeklyForumEventsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<center.Center> list = [];
      var jsonObject = jsonDecode(response.body);
      for(var json in jsonObject){
        list.add(center.Center.fromJson(json));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}