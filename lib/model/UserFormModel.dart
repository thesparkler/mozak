import '../constants/AppStrings.dart';

class UserFormModel {
  var data = {
    'gender': '',
    'first_name': '',
    'middle_name': '',
    'last_name': '',
    'date_of_birth': '',
    'email': '',
    'contact_no': '',
    'street_address': '',
    'city': '',
    'state': 'Maharashtra',
    'blood_group': '',
    'career_type': 'Student',
    'college_name': '',
    'course_name': '',
    'company_name': '',
    'designation': '',
    'reference_name': '',
  };

  getCollegeName() {
    return data['college_name'];
  }

  setCollegeName(String collegeName) {
    data['college_name'] = collegeName;
  }

  getCourseName() {
    return data['course_name'];
  }

  setCourseName(String courseName) {
    data['course_name'] = courseName;
  }

  getCompanyName() {
    return data['company_name'];
  }

  setCompanyName(String companyName) {
    data['company_name'] = companyName;
  }

  getDesignation() {
    return data['designation'];
  }

  setDesignation(String designation) {
    data['designation'] = designation;
  }

  getReferenceName() {
    return data['reference_name'];
  }

  setReferenceName(String refName) {
    data['reference_name'] = refName;
  }

  setGender(String gender) {
    data['gender'] = gender;
  }

  getGender() {
    return data['gender'];
  }

  getFirstName() {
    return data['first_name'];
  }

  setFirstName(String fName) {
    data['first_name'] = fName;
  }

  getMiddleName() {
    return data['middle_name'];
  }

  setMiddleName(String mName) {
    data['middle_name'] = mName;
  }

  getLastName() {
    return data['last_name'];
  }

  setLastName(String lName) {
    data['last_name'] = lName;
  }

  getDOB() {
    return data['date_of_birth'] ?? '';
  }

  setDOB(String dob) {
    data['date_of_birth'] = dob;
  }

  getEmail() {
    return data['email'];
  }

  setEmail(String email) {
    data['email'] = email;
  }

  getContactNo() {
    return data['contact_no'];
  }

  setContactInfo(String number) {
    data['contact_no'] = number;
  }

  getStreetAddress() {
    return data['street_address'];
  }

  setStreetAddress(String streetAddress) {
    data['street_address'] = streetAddress;
  }

  getCity() {
    return data['city'];
  }

  setCity(String city) {
    data['city'] = city;
  }

  getState() {
    return data['state'];
  }

  setState(String state) {
    data['state'] = state;
  }

  getBloodGroup() {
    return data['blood_group'];
  }

  setBloodGroup(String bloodGroup) {
    data['blood_group'] = bloodGroup;
  }

  getCareerType() {
    return data['career_type'];
  }

  setCareerType(String careerStatus) {
    data['college_name'] = '';
    data['course_name'] = '';
    data['company_name'] = '';
    data['designation'] = '';

    data['career_type'] = careerStatus;
  }

// validation code here
  String? validateStepOneGender() {
    if (data['gender'] != null && data['gender'] == '') {
      return "Gender is required";
    }
    return null;
  }

  String? validateStepTwoNamesField() {
    var firstName = data['first_name'];
    var middleName = data['middle_name'];
    var lastName = data['last_name'];
    if (firstName != null && firstName == '') {
      return AppStrings.firstNameRequired;
    } else if (middleName != null && middleName == '') {
      return AppStrings.middleNameRequired;
    } else if (lastName != null && lastName == '') {
      return AppStrings.lastNameRequired;
    }
    return null;
  }

  String? validateStepThreeDOB() {
    if (data['date_of_birth'] != null && data['date_of_birth'] == '') {
      return AppStrings.dobRequired;
    }
    return null;
  }

  String? validateStepFourContactInfo() {
    Pattern pattern = "(0/91)?[7-9][0-9]{9}";
    RegExp regex = RegExp(pattern.toString());
    var email = data['email'];
    var contactNo = data['contact_no'];

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
    if (data['street_address'] != null && data['street_address'] == '') {
      return AppStrings.streetAddressRequired;
    } else if (data['city'] != null && data['city'] == '') {
      return AppStrings.cityIsRequired;
    } else if (data['state'] != null && data['state'] == '') {
      return AppStrings.stateIsRequired;
    }
    return null;
  }

  // String? validateStepSixBloodType() {
  //   if (data['blood_group'] != null && data['blood_group'] == '') {
  //     return AppStrings.bloodTypeRequired;
  //   }
  //   return null;
  // }

  String? validateStepEightTeamLead() {
    if (data['reference_name'] != null && data['reference_name'] == '') {
      return AppStrings.referenceNameRequired;
    }
    return null;
  }

  String? validateStepSevenCareerTypeStudent() {
    if (data['college_name'] != null && data['college_name'] == '') {
      return AppStrings.collegeNameRequired;
    } else if (data['course_name'] != null && data['course_name'] == '') {
      return AppStrings.courseRequired;
    }
    return null;
  }

  String? validateStepSevenCareerTyeProfessional() {
    if (data['company_name'] != null && data['company_name'] == '') {
      return AppStrings.companyNameRequired;
    } else if (data['designation'] != null && data['designation'] == '') {
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
