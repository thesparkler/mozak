import 'center.dart';

class WeeklyForumEvent {
  late int id;
  late String date;
  late Center center;

  WeeklyForumEvent(
      {required this.id, required this.date, required this.center});

  WeeklyForumEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    center = new Center.fromJson(json['center']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['center'] = this.center.toJson();

    return data;
  }

  @override
  toString(){
    return this.date + " " + this.center.toString();
  }
}
