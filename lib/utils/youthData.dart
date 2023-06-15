import 'dart:async';

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

  Stream<List<Youth>> youthStream() => (() {
        late final StreamController<List<Youth>> _youthStream;
        _youthStream = StreamController<List<Youth>>(
          onListen: () async {
            _youthStream.add(await getYouthList());
            _youthStream.close();
          },
        );
        return _youthStream.stream;
      })();

  Stream<List<Youth>> centerStream() => (() {
        late final StreamController<List<Youth>> _centerStream;
        _centerStream = StreamController<List<Youth>>(
          onListen: () async {
            _centerStream.add(await ApiService().getAllYouths());
            _centerStream.close();
          },
        );
        return _centerStream.stream;
      })();

  Stream<List<Youth>> wfeStream() => (() {
        late final StreamController<List<Youth>> _wfeStream;
        _wfeStream = StreamController<List<Youth>>(
          onListen: () async {
            _wfeStream.add(await ApiService().getAllYouths());
            _wfeStream.close();
          },
        );
        return _wfeStream.stream;
      })();

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
