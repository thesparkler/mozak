class Youth {
  int? id;
  String? rollNo;
  String? team;
  String? youthFullName;
  String? dob;
  String? mobile1;
  String? mobile2;
  String? emailID;
  String? status;
  String? tlCode;
  String? pincode;

  Youth(
      {this.id,
      this.rollNo,
      this.team,
      this.youthFullName,
      this.dob,
      this.mobile1,
      this.mobile2,
      this.emailID,
      this.status,
      this.tlCode,
      this.pincode});

  Youth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rollNo = json['rollno'];
    team = json['team'];
    youthFullName = json['youthFullName'];
    dob = json['dob'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    emailID = json['emailid'];
    status = json['status'];
    tlCode = json['tlCode'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rollno'] = this.rollNo;
    data['team'] = this.team;
    data['youthFullName'] = this.youthFullName;
    data['dob'] = this.dob;
    data['mobile1'] = this.mobile1;
    data['mobile2'] = this.mobile2;
    data['emailid'] = this.emailID;
    data['status'] = this.status;
    data['tlCode'] = this.tlCode;
    data['pincode'] = this.pincode;
    return data;
  }
}
