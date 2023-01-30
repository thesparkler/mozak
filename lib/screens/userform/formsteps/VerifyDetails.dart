import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';
import 'package:auto_size_text/auto_size_text.dart';

class VerifyDetails extends StatefulWidget {
  final UserFormModel model;

  const VerifyDetails(this.model, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => VerifyDetailsState();
}

class VerifyDetailsState extends State<VerifyDetails> {
  int age = 0;
  late String userFirstName, userMiddleName, userLastName, userGender;
  late String userEmail, userContactNo;
  late String userBloodType;
  late String userTeamLead;
  late String userTeam;
  late String userCareerType, userDesignation, userCompanyName;
  late String userSchoolOrCollegeName, userCourse;
  late String userCityAddress;

  @override
  void initState() {
    EasyLoading.init();
    super.initState();
    userFirstName = widget.model.getFirstName();
    userMiddleName = widget.model.getMiddleName();
    userLastName = widget.model.getLastName();
    userGender = widget.model.getGender();
    userEmail = widget.model.getEmail();
    userContactNo = widget.model.getContactNo();
    userBloodType = widget.model.getBloodGroup();
    userTeamLead = widget.model.getReferenceName();
    userTeam = widget.model.getRefGrp();
    userCareerType = widget.model.getCareerType();
    userDesignation = widget.model.getDesignation();
    userCompanyName = widget.model.getCompanyName();
    userSchoolOrCollegeName = widget.model.getCollegeName();
    userCourse = widget.model.getCourseName();
    userCityAddress = widget.model.getCity();

    getUserAge();
  }

  getUserAge() {
    String? birthDate = widget.model.getDOB();
    if (birthDate != null) {
      DateTime date = DateTime.parse(birthDate);
      DateTime curDate = DateTime.now();
      age = (curDate.difference(date).inDays) ~/ 365;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> userEmailList;
    userEmailList = userEmail.split("@");
    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.verifyDetails,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Hello, ',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: hexToColor(AppColors.whiteTextColor),
                          fontSize: 20.0,
                          height: 1.3),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Jai Swaminarayan',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: hexToColor(AppColors.paleOrange),
                              fontSize: 20.0,
                              height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "I'm" +
                        "  " +
                        capitalizeFirstLetter(userFirstName) +
                        "  " +
                        userMiddleName[0].toString().toUpperCase() +
                        "." +
                        "  " +
                        capitalizeFirstLetter(userLastName),
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 20.0,
                        height: 1.8),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "A" +
                        "  " +
                        age.toString() +
                        " yrs old " +
                        userGender.toLowerCase() +
                        " from " +
                        userCityAddress,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 20.0,
                        height: 1.8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      AppStrings.contactMeByPhoneOrMail,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: hexToColor(AppColors.whiteTextColor),
                          fontSize: 20.0,
                          height: 1.4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
                          "+91-" + userContactNo,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: hexToColor(AppColors.paleOrange),
                              fontSize: 19.0,
                              height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 20,
                      ),
                      AutoSizeText(
                        "  " + userEmailList[0],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: hexToColor(AppColors.paleOrange),
                            fontSize: 19.0,
                            height: 1.4),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          "@" + userEmailList[1],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: hexToColor(AppColors.paleOrange),
                              fontSize: 19.0,
                              height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    AppStrings.myBloodType + "  " + userBloodType,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 20.0,
                        height: 1.9),
                  ),
                ),
                Container(
                  child: userCareerType == "Student"
                      ? _isStudent()
                      : _isWorkingProfessional(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      AppStrings.teamBelonging + " " + userTeam,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: hexToColor(AppColors.whiteTextColor),
                          fontSize: 20.0,
                          height: 1.4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      AppStrings.tlNameBelonging + " " + userTeamLead,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: hexToColor(AppColors.whiteTextColor),
                          fontSize: 20.0,
                          height: 1.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _isStudent() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              "Currently, I'm a" +
                  " " +
                  userCareerType +
                  " studying in " +
                  " " +
                  userCourse +
                  " at " +
                  userSchoolOrCollegeName,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 20.0,
                  height: 1.4),
            )));
  }

  Widget _isWorkingProfessional() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AutoSizeText(
          "Currently, I'm a working " +
              userCareerType.toLowerCase() +
              "." +
              " Working as a " +
              userDesignation +
              " at " +
              userCompanyName +
              ".",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              color: hexToColor(AppColors.whiteTextColor),
              fontSize: 20.0,
              height: 1.4),
        ),
      ),
    );
  }
}
