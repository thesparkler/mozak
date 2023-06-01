import 'dart:io';

class Constants {
  static String domain = "http://192.168.29.220:8080/mozakio";
  // static String domain = "http://192.168.1.34:8080/mozakio";
  static String allYouths = "/allYouths";
  static String allWFEvents = "/allWFEvents";
  static String allCenters = "/allCenters";
  static String allGroups = "";
  static String allTeams = "";

  static String createCenter = "/createCenter";
  static String createWFEvent = "/createWFEvent";

  static String youthByEventId = "/youthByEventId";
  static String attendanceByEventId = "/attendanceByEventId";
  static String attendanceByYouthId = "/attendanceByYouthId";
  static String markAttendance = "/markAttendance?youth_id=2&weekly_forum_event_id=2";
}
