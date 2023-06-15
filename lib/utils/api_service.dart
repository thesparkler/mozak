import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mozak/model/attendanceTable.dart';

import '../model/weekly_forum_event.dart';
import '../model/center.dart' as center;
import '../model/youth.dart';
import 'constants.dart';

class ApiService {
  ApiService._sharedInstance();
  static final ApiService _shared = ApiService._sharedInstance();
  factory ApiService() => _shared;

  Future<List<WeeklyForumEvent>> getWFEvents() async {
    Uri allWeeklyForumEventsUrl =
        Uri.parse('${Constants.domain}${Constants.allWFEvents}');
    http.Response response = await http.get(allWeeklyForumEventsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<WeeklyForumEvent> list = [];
      var jsonObject = jsonDecode(response.body);
      for (var json in jsonObject) {
        list.add(WeeklyForumEvent.fromJson(json));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<AttendanceTable>> getAttendanceTable() async {
    Uri allWeeklyForumEventsUrl =
        Uri.parse('${Constants.domain}${Constants.allWFEvents}');
    http.Response response = await http.get(allWeeklyForumEventsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<AttendanceTable> list = [];
      var jsonObject = jsonDecode(response.body);
      for (var json in jsonObject) {
        list.add(AttendanceTable.fromJson(json));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Youth>> getMarkedYouths(int eventID) async {
    Uri allWeeklyForumEventsUrl =
        Uri.parse('${Constants.domain}${Constants.youthByEventId}/$eventID');
    print(allWeeklyForumEventsUrl.toString());
    http.Response response = await http.get(allWeeklyForumEventsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Youth> list = [];
      var jsonObject = jsonDecode(response.body);
      for (var json in jsonObject) {
        list.add(Youth.fromJson(json));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // In following code Center class is creating conflict with a class of same name in Flutter lib.
  Future<List<center.CenterData>> getCenters() async {
    Uri allWeeklyForumEventsUrl =
        Uri.parse('${Constants.domain}${Constants.allCenters}');
    http.Response response = await http.get(allWeeklyForumEventsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<center.CenterData> list = [];
      var jsonObject = jsonDecode(response.body);
      for (var json in jsonObject) {
        list.add(center.CenterData.fromJson(json));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Youth> setYouth(
    Youth youth,
  ) async {
    Uri createWFEUrl =
        Uri.parse('${Constants.domain}${Constants.registerYouth}');

    http.Response response = await http.post(createWFEUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(youth.toJson())
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Youth _youth;
      var jsonObject = jsonDecode(response.body);
      _youth = Youth.fromJson(jsonObject);

      return _youth;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to data');
    }
  }

  Future<List<Youth>> getAllYouths() async {
    Uri allWeeklyForumEventsUrl =
        Uri.parse('${Constants.domain}${Constants.allYouths}');
    http.Response response = await http.get(allWeeklyForumEventsUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Youth> list = [];
      var jsonObject = jsonDecode(response.body);
      for (var json in jsonObject) {
        list.add(Youth.fromJson(json));
      }
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load youth data');
    }
  }

  Future<http.Response> setCenter(String location) async {
    Uri createCenterUrl =
        Uri.parse('${Constants.domain}${Constants.createCenter}');
    http.Response response = await http.post(
      createCenterUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'location': location,
      }),
    );
    return response;
  }

  Future<http.Response> setWFEvent(
      center.CenterData center, String date) async {
    Uri createWFEUrl = Uri.parse(
        '${Constants.domain}${Constants.createWFEvent}?centerId=${center.id}');
    http.Response response = await http.post(
      createWFEUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'date': date.toString(),
      }),
    );
    return response;
  }

  Future<http.Response> markAttendance(int eventID, int selectedYouthId) async {
    Uri createWFEUrl =
        Uri.parse('${Constants.domain}${Constants.markAttendance}'
            'youth_id=$selectedYouthId'
            '&weekly_forum_event_id=$eventID');
    http.Response response = await http.post(
      createWFEUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );
    return response;
  }

  Future<Youth> setRollNo(Youth youth, bool isTemp) async {
    Uri setRollNo =
    Uri.parse('${Constants.domain}${Constants.setRollNo}'
      'id=${youth.id}&isTemp=${isTemp}');
    http.Response response = await http.post(
      setRollNo,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Youth _youth;
      var jsonObject = jsonDecode(response.body);
      _youth = Youth.fromJson(jsonObject);

      return _youth;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to data');
    }
  }
}
