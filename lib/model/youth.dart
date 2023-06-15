
class Youth {
  int? id;
  String? rollno;
  String? youthFullName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? pincode;
  String? streetAddress;
  String? city;
  String? state;
  String? bloodGroup;
  String? careerType;
  String? collegeName;
  String? courseName;
  String? companyName;
  String? designation;
  String? refGrp;
  String? team;
  String? dob;
  String? mobile1;
  String? mobile2;
  String? emailid;
  String? status;
  String? tlCode;
  String? inTeamRef;
  bool isTL = false;
  bool isKK = false;

  Youth(
      {this.id,
      this.rollno,
      this.youthFullName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.pincode,
      this.streetAddress,
      this.city,
      this.state,
      this.bloodGroup,
      this.careerType,
      this.collegeName,
      this.courseName,
      this.companyName,
      this.designation,
      this.refGrp,
      this.team,
      this.dob,
      this.mobile1,
      this.mobile2,
      this.emailid,
      this.status,
      this.tlCode,
      this.inTeamRef,
      required this.isTL,
      required this.isKK});

  Youth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rollno = json['rollno'];
    youthFullName = json['youthFullName'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    gender = json['gender'];
    pincode = json['pincode'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    bloodGroup = json['blood_group'];
    careerType = json['career_type'];
    collegeName = json['college_name'];
    courseName = json['course_name'];
    companyName = json['company_name'];
    designation = json['designation'];
    refGrp = json['refGrp'];
    team = json['team'];
    dob = json['dob'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    emailid = json['emailid'];
    status = json['status'];
    tlCode = json['tlCode'];
    inTeamRef = json['inTeamRef'];
    isTL = json['isTL'];
    isKK = json['isKK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rollno'] = this.rollno;
    data['youthFullName'] = this.youthFullName;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['pincode'] = this.pincode;
    data['street_address'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['blood_group'] = this.bloodGroup;
    data['career_type'] = this.careerType;
    data['college_name'] = this.collegeName;
    data['course_name'] = this.courseName;
    data['company_name'] = this.companyName;
    data['designation'] = this.designation;
    data['refGrp'] = this.refGrp;
    data['team'] = this.team;
    data['dob'] = this.dob;
    data['mobile1'] = this.mobile1;
    data['mobile2'] = this.mobile2;
    data['emailid'] = this.emailid;
    data['status'] = this.status;
    data['tlCode'] = this.tlCode;
    data['inTeamRef'] = this.inTeamRef;
    data['isTL'] = this.isTL;
    data['isKK'] = this.isKK;
    return data;
  }

  String getFullName(){
    return '${this.firstName} ${this.middleName} ${this.lastName}';
  }

}
