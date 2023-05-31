import 'center.dart';
import 'youth.dart';
import 'weekly_forum_event.dart';

class AttendanceTable {
  int? id;
  Youth? youth;
  WeeklyForumEvent? wfEvent;

  AttendanceTable({this.id, this.youth, this.wfEvent});

  AttendanceTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    youth = new Youth.fromJson(json['youth']);
    wfEvent = new WeeklyForumEvent.fromJson(json['wfEvent']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.youth != null) {
      data['youth'] = this.youth!.toJson();
    }
    if (this.wfEvent != null) {
      data['wfEvent'] = this.wfEvent!.toJson();
    }
    return data;
  }
}
