import 'package:flutter/Material.dart';
import 'package:mozak/model/center.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/weekly_forum_event.dart';
import '../model/youth.dart';
import 'api_service.dart';

class YouthData {
  //String token = "";
  var youthList = <Youth>[];
  var centerList = <CenterData>[];
  var wfeList = <WeeklyForumEvent>[];

  /// private constructor
  YouthData._sharedInstance();

  /// the one and only instance of this singleton
  static final instance = YouthData._sharedInstance();

  factory YouthData() => instance;

  // getToken(BuildContext context) async {
  //   if (token == "") {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     token = prefs.getString('token')!;
  //   }
  // }
  Future<List<Youth>> getYouthList() async {
    if (youthList.isEmpty) {
      youthList = await ApiService().getAllYouths();
    }
    return youthList;
  }

  Future<List<WeeklyForumEvent>> getWFEventList() async {
    if (wfeList.isEmpty) {
      wfeList = await ApiService().getWFEvents();
    }
    return wfeList;
  }

  Future<List<CenterData>> getCenterList() async {
    if (centerList.isEmpty) centerList = await ApiService().getCenters();
    return centerList;
  }
}
