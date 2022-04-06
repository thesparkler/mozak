import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

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
  late String userCareerType, userDesignation, userCompanyName;
  late String userSchoolOrCollegeName, userCourse;
  late String userCityAddress;

  @override
  void initState() {
    super.initState();

    userFirstName = widget.model.getFirstName();
    userMiddleName = widget.model.getMiddleName();
    userLastName = widget.model.getLastName();
    userGender = widget.model.getGender();
    userEmail = widget.model.getEmail();
    userContactNo = widget.model.getContactNo();
    userBloodType = widget.model.getBloodGroup();
    userTeamLead = widget.model.getReferenceName();
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
                    child: AutoSizeText(
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

                _myName(),

                _ageAndGender(),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      userCityAddress,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: hexToColor(AppColors.whiteTextColor),
                          fontSize: 20.0,
                          height: 1.5),
                      maxLines: 2,
                    ),
                  ),
                ),

                // contact me text
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 20.0),
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

                // call or email data
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
                        child: Text(
                           "+91-" + userContactNo,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: hexToColor(AppColors.paleOrange),
                              fontSize: 19.0,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        userEmail,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: hexToColor(AppColors.paleOrange),
                          fontSize: 19.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                // blood type
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.myBloodType,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: hexToColor(AppColors.whiteTextColor),
                            fontSize: 20.0,
                            height: 1.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          userBloodType,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: hexToColor(AppColors.paleOrange),
                              fontSize: 20.0,
                              height: 1.3),
                        ),
                      ),
                    ],
                  ),
                ),

                // student or professional
                Container(
                  child: userCareerType == "Student"
                      ? _isStudent()
                      : _isWorkingProfessional(),
                ),

                // team fall under
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.tlNameBelonging,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: hexToColor(AppColors.whiteTextColor),
                            fontSize: 20.0,
                            height: 1.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userTeamLead,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: hexToColor(AppColors.paleOrange),
                                fontSize: 20.0,
                                height: 1.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ageAndGender() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          Text(
            "A",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                color: hexToColor(AppColors.whiteTextColor),
                fontSize: 20.0,
                height: 1.3),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              age.toString() + "yrs",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: hexToColor(AppColors.paleOrange),
                  fontSize: 20.0,
                  height: 1.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "old ${userGender.toLowerCase()} from",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 20.0,
                  height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _myName() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          AutoSizeText(
            "Hi, I'm",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                color: hexToColor(AppColors.whiteTextColor),
                fontSize: 20.0,
                height: 1.3),
            maxLines: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              capitalizeFirstLetter(userFirstName),
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: hexToColor(AppColors.paleOrange),
                  fontSize: 20.0,
                  height: 1.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              userMiddleName[0].toString().toUpperCase() + ".",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: hexToColor(AppColors.paleOrange),
                  fontSize: 20.0,
                  height: 1.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              capitalizeFirstLetter(userLastName),
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: hexToColor(AppColors.paleOrange),
                  fontSize: 20.0,
                  height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _isStudent() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Currently, I'm a",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 20.0,
                    height: 1.3),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  userCareerType,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: hexToColor(AppColors.paleOrange),
                      fontSize: 20.0,
                      height: 1.3),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Text(
                  "Studying in",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 20.0,
                      height: 1.3),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    userCourse,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: hexToColor(AppColors.paleOrange),
                        fontSize: 20.0,
                        height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "at",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 20.0,
                        height: 1.3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                child: Text(
                  userSchoolOrCollegeName,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: hexToColor(AppColors.paleOrange),
                      fontSize: 20.0,
                      height: 1.3),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _isWorkingProfessional() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Currently,",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 20.0,
                  height: 1.3),
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "I'm a Working",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 20.0,
                      height: 1.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                child: Text(
                  userCareerType,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: hexToColor(AppColors.paleOrange),
                      fontSize: 20.0,
                      height: 1.3),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Working as a",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 20.0,
                    height: 1.3),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                userDesignation,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: hexToColor(AppColors.paleOrange),
                    fontSize: 20.0,
                    height: 1.3),
              ),
            ),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "at",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 20.0,
                        height: 1.3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userCompanyName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: hexToColor(AppColors.paleOrange),
                        fontSize: 20.0,
                        height: 1.3),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
