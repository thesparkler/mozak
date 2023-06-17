import 'package:mozak/model/youth.dart';

import '../constants/AppStrings.dart';

class UserFormModel {
  String referenceName = "GK0801 Sagar Ashok Sarvaiya";
  String referenceGrp = "Gurukrupa";
  String recognition = "New";
  bool isTemp = true;
  var youth = Youth(
    gender: "Male",
    firstName: "",
    middleName: "",
    lastName: "",
    dob: "",
    emailid: "",
    mobile1: "",
    streetAddress: "",
    city: "",
    pincode: "400080",
    state: "Maharashtra",
    bloodGroup: "Not Given",
    careerType: "Student",
    collegeName: "",
    courseName: "",
    companyName: "",
    designation: "",
    refGrp: "Gurukrupa",
    tlCode: "GK0801",
    team: "GK08",
    inTeamRef: "",
    isTL: false,
    isKK: false,
  );
  var data = {
    'gender': "",
    'first_name': "Shubham",
    'middle_name': "Kishor",
    'last_name': "Dathia",
    'date_of_birth': "",
    'email': "shubhamdathia7257@gmail.com",
    'contact_no': "7303545657",
    'street_address': "Achanak mitra mandal Dumping Rd",
    'city': "Mulund",
    'state': "Maharashtra",
    'blood_group': "Not given",
    'career_type': "Student",
    'college_name': "K. J. Somaiya College of Engineering",
    'course_name': "B.Tech",
    'company_name': "",
    'designation': "",
    'refGrp': "Gurukrupa",
    'reference_name': "GK0801 Sagar Ashok Sarvaiya",
    'inTeamRef': ''
  };

  getCollegeName() {
    return youth.collegeName;
  }

  setCollegeName(String collegeName) {
    youth.collegeName = collegeName;
  }

  getRecognition() {
    return recognition;
  }

  setRecognition(String rec) {
    recognition = rec;
    isTemp = (recognition == "New");
    print(isTemp);
  }

  getCourseName() {
    return youth.courseName;
  }

  setCourseName(String courseName) {
    youth.courseName = courseName;
  }

  getCompanyName() {
    return youth.companyName;
  }

  setCompanyName(String companyName) {
    youth.companyName = companyName;
  }

  getDesignation() {
    return youth.designation;
  }

  setDesignation(String designation) {
    youth.designation = designation;
  }

  getReferenceName() {
    return referenceName;
  }

  setReferenceName(String refName) {
    referenceName = refName;
  }

  setGender(String gender) {
    youth.gender = gender;
  }

  getGender() {
    return youth.gender;
  }

  getFirstName() {
    return youth.firstName;
  }

  setFirstName(String fName) {
    youth.firstName = fName;
  }

  getMiddleName() {
    return youth.middleName;
  }

  setMiddleName(String mName) {
    youth.middleName = mName;
  }

  getLastName() {
    return youth.lastName;
  }

  setLastName(String lName) {
    youth.lastName = lName;
  }

  setFullName() {
    youth.youthFullName =
        "${youth.firstName} ${youth.middleName} ${youth.lastName}";
  }

  getDOB() {
    return youth.dob ?? '';
  }

  setDOB(String dob) {
    youth.dob = dob;
  }

  getEmail() {
    return youth.emailid;
  }

  setEmail(String email) {
    youth.emailid = email;
  }

  getContactNo() {
    return youth.mobile1;
  }

  setContactInfo(String number) {
    youth.mobile1 = number;
  }

  getStreetAddress() {
    return youth.streetAddress;
  }

  setStreetAddress(String streetAddress) {
    youth.streetAddress = streetAddress;
  }

  getPinCode() {
    return youth.pincode;
  }

  setPinCode(String pincode) {
    youth.pincode = pincode;
  }

  getCity() {
    return youth.city;
  }

  setCity(String city) {
    youth.city = city;
  }

  getState() {
    return youth.state;
  }

  getRefGrp() {
    return referenceGrp;
  }

  setRefGrp(String refGrp) {
    return referenceGrp = refGrp;
  }

  getRefTeam() {
    return youth.team;
  }

  setRefTeam(String refGrp) {
    return youth.team = refGrp;
  }

  setState(String state) {
    youth.state = state;
  }

  setInTeamRef(String val) {
    youth.inTeamRef = val;
  }

  String? getInTeamRef() {
    return youth.inTeamRef;
  }

  getBloodGroup() {
    return youth.bloodGroup;
  }

  setBloodGroup(String bloodGroup) {
    youth.bloodGroup = bloodGroup;
  }

  getCareerType() {
    return youth.careerType;
  }

  setCareerType(String careerStatus) {
    youth.collegeName = '';
    youth.courseName = '';
    youth.companyName = '';
    youth.designation = '';

    youth.careerType = careerStatus;
  }

// validation code here
  String? validateStepOneGender() {
    if (youth.gender != null && youth.gender == '') {
      return "Gender is required";
    }
    return null;
  }

  String? validateStepTwoNamesField() {
    var firstName = youth.firstName;
    var middleName = youth.middleName;
    var lastName = youth.lastName;
    if (firstName != null && firstName == '') {
      return AppStrings.firstNameRequired;
    } else if (middleName != null && middleName == '') {
      return AppStrings.middleNameRequired;
    } else if (lastName != null && lastName == '') {
      return AppStrings.lastNameRequired;
    } else {
      setFullName();
    }
    return null;
  }

  String? validateStepThreeDOB() {
    if (youth.dob != null && youth.dob == '') {
      return AppStrings.dobRequired;
    }
    return null;
  }

  String? validateStepFourContactInfo() {
    Pattern pattern = "(0/91)?[6-9][0-9]{9}";
    RegExp regex = RegExp(pattern.toString());
    var email = youth.emailid;
    var contactNo = youth.mobile1;

    if (email != null && email == '') {
      return AppStrings.emailRequired;
    } else if (!email!.contains('@')) {
      return AppStrings.enterValidEmail;
    } else if (contactNo != null && contactNo == '') {
      return AppStrings.contactNoRequired;
    } else if (!regex.hasMatch(contactNo!)) {
      return "Invalid Contact Number";
    }
    return null;
  }

  String? validateStepFiveUserAddress() {
    if (youth.streetAddress != null && youth.streetAddress == '') {
      return AppStrings.streetAddressRequired;
    } else if (youth.city != null && youth.city == '') {
      return AppStrings.cityIsRequired;
    } else if (youth.state != null && youth.state == '') {
      return AppStrings.stateIsRequired;
    }
    return null;
  }

  // String? validateStepSixBloodType() {
  //   if (youth.bloodGroup != null && youth.bloodGroup == '') {
  //     return AppStrings.bloodTypeRequired;
  //   }
  //   return null;
  // }

  String? validateStepEightTeamLead() {
    if (referenceName != null && referenceName == '') {
      return AppStrings.referenceNameRequired;
    }
    return null;
  }

  String? validateStepSevenCareerTypeStudent() {
    if (youth.collegeName != null && youth.collegeName == '') {
      return AppStrings.collegeNameRequired;
    } else if (youth.courseName != null && youth.courseName == '') {
      return AppStrings.courseRequired;
    }
    return null;
  }

  String? validateStepSevenCareerTyeProfessional() {
    if (youth.companyName != null && youth.companyName == '') {
      return AppStrings.companyNameRequired;
    } else if (youth.designation != null && youth.designation == '') {
      return AppStrings.designationIsRequired;
    }
    return null;
  }

  String? validateStep7() {
    if (getCareerType() == "Student") {
      return validateStepSevenCareerTypeStudent();
    }
    if (getCareerType() == "Professional") {
      return validateStepSevenCareerTyeProfessional();
    }
    return null;
  }
}
// import 'package:mozak/model/youth.dart';
//
// import '../constants/AppStrings.dart';
//
// class UserFormModel {
//   var selectedYouthObj;
//   Youth youth = Youth(
//     firstName: "Shubham",
//     gender: "Male",
//     middleName: "Kishor",
//     lastName: "Dathia",
//     emailid: "shubhamdathia7257@gmail.com",
//     mobile1: "7303545657",
//     careerType: "Student",
//     collegeName: "K. J. Somaiya College of Engineering",
//     courseName: "B. Tech Computer Eng",
//     refGrp: "Gurukrupa",
//     streetAddress: "Achanak Mitra Mandal, Dumping Rd",
//     city: "Mulund Mumbai",
//     dob: "2001-21-12",
//     pincode: "400080",
//     isTL: false,
//     isKK: false,
//     team: 'GK08',
//     tlCode: 'GK0801',
//     state: 'Maharashtra',
//   );
//   /*
//     int? id;
//   String? rollno;
//   String? youthFullName;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? gender;
//   String? pincode;
//   String? streetAddress;
//   String? city;
//   String? state;
//   String? bloodGroup;
//   String? careerType;
//   String? collegeName;
//   String? courseName;
//   String? companyName;
//   String? designation;
//   String? refGrp;
//   String? team;
//   String? dob;
//   String? mobile1;
//   String? mobile2;
//   String? emailid;
//   String? status;
//   String? tlCode;
//   String? inTeamRef;
//   bool isTL = false;
//   bool isKK = false;
//    */
//   var data = {
//     'gender': "",
//     'first_name': "",
//     'middle_name': "",
//     'last_name': "",
//     'date_of_birth': "",
//     'email': "",
//     'contact_no': "",
//     'street_address': "",
//     'city': "",
//     'state': "Maharashtra",
//     'blood_group': "Not given",
//     'career_type': "Student",
//     'college_name': "",
//     'course_name': "",
//     'company_name': "",
//     'designation': "",
//     'refGrp': "Gurukrupa",
//     'tlID': '',
//     'teamCode': "GK01",
//     'tlCode': "GK0801",
//   };
//
//   getCollegeName() {
//     return youth.collegeName;
//   }
//
//   setCollegeName(String collegeName) {
//     youth.collegeName = collegeName;
//   }
//
//   getCourseName() {
//     return youth.courseName;
//   }
//
//   setCourseName(String courseName) {
//     youth.courseName = courseName;
//   }
//
//   getCompanyName() {
//     return youth.companyName;
//   }
//
//   setCompanyName(String companyName) {
//     youth.companyName = companyName;
//   }
//
//   getDesignation() {
//     return youth.designation;
//   }
//
//   setDesignation(String designation) {
//     youth.designation = designation;
//   }
//
//   getReferenceName() {
//     return youth.tlCode;
//   }
//
//   getTlCode() {
//     return youth.tlCode;
//   }
//
//   setReferenceName(String refName) {
//     data['ref'] = refName;
//   }
//
//   setTlCode(String tlCode) {
//     youth.tlCode = tlCode;
//   }
//
//   setGender(String gender) {
//     youth.gender = gender;
//   }
//
//   getGender() {
//     return youth.gender;
//   }
//
//   getFirstName() {
//     return youth.firstName;
//   }
//
//   setFirstName(String fName) {
//     youth.firstName = fName;
//   }
//
//   getMiddleName() {
//     return youth.middleName;
//   }
//
//   setMiddleName(String mName) {
//     youth.middleName = mName;
//   }
//
//   getLastName() {
//     return youth.lastName;
//   }
//
//   setLastName(String lName) {
//     youth.lastName = lName;
//   }
//
//   getDOB() {
//     return youth.dob ?? '';
//   }
//
//   setDOB(String dob) {
//     youth.dob = dob;
//   }
//
//   getEmail() {
//     return youth.emailid;
//   }
//
//   setEmail(String email) {
//     youth.emailid = email;
//   }
//
//   getContactNo() {
//     return youth.mobile1;
//   }
//
//   setContactInfo(String number) {
//     youth.mobile1 = number;
//   }
//
//   getStreetAddress() {
//     return youth.streetAddress;
//   }
//
//   setStreetAddress(String streetAddress) {
//     youth.streetAddress = streetAddress;
//   }
//
//   getCity() {
//     return youth.city;
//   }
//
//   setCity(String city) {
//     youth.city = city;
//   }
//
//   getState() {
//     return youth.state;
//   }
//
//   getRefGrp() {
//     return youth.refGrp;
//   }
//
//   setRefGrp(String refGrp) {
//     return youth.refGrp = refGrp;
//   }
//
//   getRefTeam() {
//     return youth.team;
//   }
//
//   setRefTeam(String teamCode) {
//     return youth.team = teamCode;
//   }
//
//   setState(String state) {
//     youth.state = state;
//   }
//
//   setInTeamRef(String val) {
//     youth.inTeamRef = val;
//   }
//
//   String? getInTeamRef() {
//     return youth.inTeamRef;
//   }
//
//   getBloodGroup() {
//     return youth.bloodGroup;
//   }
//
//   setBloodGroup(String bloodGroup) {
//     youth.bloodGroup = bloodGroup;
//   }
//
//   getCareerType() {
//     return youth.careerType;
//   }
//
//   setCareerType(String careerStatus) {
//     youth.collegeName = '';
//     youth.courseName = '';
//     youth.companyName = '';
//     youth.designation = '';
//
//     youth.careerType = careerStatus;
//   }
//
// // validation code here
//   String? validateStepOneGender() {
//     if (youth.gender != null && youth.gender == '') {
//       return "Gender is required";
//     }
//     return null;
//   }
//
//   String? validateStepTwoNamesField() {
//     var firstName = youth.firstName;
//     var middleName = youth.middleName;
//     var lastName = youth.lastName;
//     if (firstName != null && firstName == '') {
//       return AppStrings.firstNameRequired;
//     } else if (middleName != null && middleName == '') {
//       return AppStrings.middleNameRequired;
//     } else if (lastName != null && lastName == '') {
//       return AppStrings.lastNameRequired;
//     }
//     return null;
//   }
//
//   String? validateStepThreeDOB() {
//     if (youth.dob != null && youth.dob == '') {
//       return AppStrings.dobRequired;
//     }
//     return null;
//   }
//
//   String? validateStepFourContactInfo() {
//     Pattern pattern = "(0/91)?[6-9][0-9]{9}";
//     RegExp regex = RegExp(pattern.toString());
//     var email = youth.emailid;
//     var contactNo = youth.mobile1;
//
//     if (email != null && email == '') {
//       return AppStrings.emailRequired;
//     } else if (!email!.contains('@')) {
//       return AppStrings.enterValidEmail;
//     } else if (contactNo != null && contactNo == '') {
//       return AppStrings.contactNoRequired;
//     } else if (!regex.hasMatch(contactNo!)) {
//       return "Invalid Contact Number";
//     }
//     return null;
//   }
//
//   String? validateStepFiveUserAddress() {
//     if (youth.streetAddress != null && youth.streetAddress == '') {
//       return AppStrings.streetAddressRequired;
//     } else if (youth.city != null && youth.city == '') {
//       return AppStrings.cityIsRequired;
//     } else if (youth.state != null && youth.state == '') {
//       return AppStrings.stateIsRequired;
//     }
//     return null;
//   }
//
//   // String? validateStepSixBloodType() {
//   //   if (youth.bloodGroup != null && youth.bloodGroup == '') {
//   //     return AppStrings.bloodTypeRequired;
//   //   }
//   //   return null;
//   // }
//
//   String? validateStepEightTeamLead() {
//     if (youth.tlCode != null && youth.tlCode == '') {
//       return AppStrings.referenceNameRequired;
//     }
//     return null;
//   }
//
//   String? validateStepSevenCareerTypeStudent() {
//     if (youth.collegeName != null && youth.collegeName == '') {
//       return AppStrings.collegeNameRequired;
//     } else if (youth.courseName != null && youth.courseName == '') {
//       return AppStrings.courseRequired;
//     }
//     return null;
//   }
//
//   String? validateStepSevenCareerTyeProfessional() {
//     if (youth.companyName != null && youth.companyName == '') {
//       return AppStrings.companyNameRequired;
//     } else if (youth.designation != null && youth.designation == '') {
//       return AppStrings.designationIsRequired;
//     }
//     return null;
//   }
//
//   String? validateStep7() {
//     if (getCareerType() == "Student") {
//       return validateStepSevenCareerTypeStudent();
//     }
//     if (getCareerType() == "Professional") {
//       return validateStepSevenCareerTyeProfessional();
//     }
//     return null;
//   }
// }
