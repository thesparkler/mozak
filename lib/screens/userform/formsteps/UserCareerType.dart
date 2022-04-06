import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

class UserCareerType extends StatefulWidget {
  final UserFormModel model;

  const UserCareerType(this.model, {Key? key}) : super(key: key);

  @override
  State<UserCareerType> createState() => UserCareerTypeState();
}

class UserCareerTypeState extends State<UserCareerType> {
  final maxLines = 2;
  final _studentFormKey = GlobalKey<FormState>();
  final _professionalFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var studentSelected = Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: hexToColor(AppColors.paleOrange),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(AppAssets.studentImgBlack),
      ),
    );

    var studentUnselected = Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(AppAssets.studentImgWhite),
      ),
    );

    var professionalSelected = Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: hexToColor(AppColors.paleOrange),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(AppAssets.workBlack),
        ),
      ),
    );

    var professionalUnselected = Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(AppAssets.workWhite),
        ),
      ),
    );

    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, top: 35.0, bottom: 35.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.currentlyDoingTitleText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.5),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.model.setCareerType("Student");
                        });
                      },
                      child: widget.model.getCareerType() == "Student"
                          ? studentSelected
                          : studentUnselected,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.model.setCareerType("Professional");
                            });
                          },
                          child: widget.model.getCareerType() == "Professional"
                              ? professionalSelected
                              : professionalUnselected,
                        )),
                  ],
                ),
              ),

              // form
              Container(
                child: widget.model.getCareerType() == "Student"
                    ? _isStudent()
                    : _isWorkingProfessional(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _isStudent() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 40.0),
      child: Form(
          key: _studentFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.collegeFieldText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: maxLines * 25.0,
                child: TextFormField(
                    //   key:const Key('text1'),
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      widget.model.setCollegeName(val);
                    },
                    initialValue: widget.model.getCareerType() == "Student"
                        ? widget.model.getCollegeName()
                        : '',
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 17.0),
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: hexToColor(
                                AppColors.textFieldOutlineBorderColor)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(AppColors.paleOrange))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(
                                  AppColors.textFieldOutlineBorderColor))),
                      hintText: AppStrings.collegeFieldHintText,
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: hexToColor(AppColors.hintTextColor)),
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.courseFieldText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: maxLines * 25.0,
                child: TextFormField(
                    //     key:const Key('text2'),
                    textInputAction: TextInputAction.done,
                    onChanged: (val) {
                      widget.model.setCourseName(val);
                    },
                    initialValue: widget.model.getCareerType() == "Student"
                        ? widget.model.getCourseName()
                        : '',
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 17.0),
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: hexToColor(
                                AppColors.textFieldOutlineBorderColor)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(AppColors.paleOrange))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(
                                  AppColors.textFieldOutlineBorderColor))),
                      hintText: AppStrings.courseFieldHintText,
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: hexToColor(AppColors.hintTextColor)),
                    )),
              ),
            ],
          )),
    );
  }

  Widget _isWorkingProfessional() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 40.0),
      child: Form(
          key: _professionalFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.companyNameFieldText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: maxLines * 25.0,
                child: TextFormField(
                    //     key:const Key('text3'),
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      widget.model.setCompanyName(val);
                    },
                    //    initialValue: companyName,
                    initialValue: widget.model.getCareerType() == "Professional"
                        ? widget.model.getCompanyName()
                        : '',
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 17.0),
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: hexToColor(
                                AppColors.textFieldOutlineBorderColor)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(AppColors.paleOrange))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(
                                  AppColors.textFieldOutlineBorderColor))),
                      hintText: AppStrings.companyFieldHintText,
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: hexToColor(AppColors.hintTextColor)),
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.designationFieldText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                height: maxLines * 25.0,
                child: TextFormField(
                    //   key:const Key('text4'),
                    textInputAction: TextInputAction.done,
                    onChanged: (val) {
                      // widget.model.getCareerType() == "Professional" ?
                      widget.model.setDesignation(val);
                    },
                    //    initialValue: designation,
                    initialValue: widget.model.getCareerType() == "Professional"
                        ? widget.model.getDesignation()
                        : '',
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 17.0),
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: hexToColor(
                                AppColors.textFieldOutlineBorderColor)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(AppColors.paleOrange))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              color: hexToColor(
                                  AppColors.textFieldOutlineBorderColor))),
                      hintText: AppStrings.designationHintText,
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: hexToColor(AppColors.hintTextColor)),
                    )),
              ),
            ],
          )),
    );
  }
}
