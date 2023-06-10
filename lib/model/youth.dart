import 'package:flutter/cupertino.dart';

class Youth {
  int id;
  String? rollno;
  String team;
  String youthFullName;
  String? dob;
  String mobile1;
  String? mobile2;
  String? emailid;
  String? status;
  String tlCode;
  String? pincode;

  Youth(
    {
      this.id = 0,
      this.rollno,
      required this.team,
      required this.youthFullName,
      this.dob,
      required this.mobile1,
      this.mobile2,
      this.emailid,
      this.status,
      required this.tlCode,
      this.pincode});

  Youth.fromJson(Map<String, dynamic> json)
  :id=json['id'],
  youthFullName=json['youthFullName'],
  mobile1=json['mobile1'],
  team=json['team'],
  tlCode=json['tlCode']
  {
    id = json['id'];
    rollno = json['rollno'];
    team = json['team'];
    youthFullName = json['youthFullName'];
    dob = json['dob'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    emailid = json['emailid'];
    status = json['status'];
    tlCode = json['tlCode'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rollno'] = this.rollno;
    data['team'] = this.team;
    data['youthFullName'] = this.youthFullName;
    data['dob'] = this.dob;
    data['mobile1'] = this.mobile1;
    data['mobile2'] = this.mobile2;
    data['emailid'] = this.emailid;
    data['status'] = this.status;
    data['tlCode'] = this.tlCode;
    data['pincode'] = this.pincode;
    return data;
  }

  @override
  String toString() {
    return this.youthFullName;
  }
}
