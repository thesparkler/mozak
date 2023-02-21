import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

class UserFullName extends StatefulWidget {
  final UserFormModel model;

  final next;

  const UserFullName(this.model, this.next, {Key? key}) : super(key: key);

  @override
  State<UserFullName> createState() => _UserFullNameState();
}

class _UserFullNameState extends State<UserFullName> {
  final maxLines = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _greetMessage(),
              _mayIKnowYourNameText(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 40.0),
                child: Form(
                    child: Column(
                  children: [
                    _buildFirstName(),
                    _buildMiddleName(),
                    _buildLastName(),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.firsNameText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            height: maxLines * 25.0,
            child: TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (val) {
                  widget.model.setFirstName(val);
                },
                initialValue: widget.model.getFirstName(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "First name is required";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 17.0),
                maxLines: 1,
                decoration: InputDecoration(
                  isDense: false,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            hexToColor(AppColors.textFieldOutlineBorderColor)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: hexToColor(AppColors.paleOrange))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: hexToColor(
                              AppColors.textFieldOutlineBorderColor))),
                  hintText: AppStrings.firstNameHintText,
                  hintStyle: TextStyle(
                      fontSize: 15, color: hexToColor(AppColors.hintTextColor)),
                )),
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.middleNameText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            height: maxLines * 25.0,
            child: TextFormField(
                onChanged: (val) {
                  widget.model.setMiddleName(val);
                },
                initialValue: widget.model.getMiddleName(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 17.0),
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            hexToColor(AppColors.textFieldOutlineBorderColor)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: hexToColor(AppColors.paleOrange))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: hexToColor(
                              AppColors.textFieldOutlineBorderColor))),
                  hintText: AppStrings.middleNameHintText,
                  hintStyle: TextStyle(
                      fontSize: 15, color: hexToColor(AppColors.hintTextColor)),
                )),
          ),
        ),
      ],
    );
  }

  Widget _buildLastName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.lastNameText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            height: maxLines * 25.0,
            child: TextFormField(
                textInputAction: TextInputAction.done,
                onChanged: (val) {
                  widget.model.setLastName(val);
                },
                onEditingComplete: () {
                  widget.next();
                },
                initialValue: widget.model.getLastName(),
                keyboardType: TextInputType.text,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 17.0),
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            hexToColor(AppColors.textFieldOutlineBorderColor)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide:
                          BorderSide(color: hexToColor(AppColors.paleOrange))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: hexToColor(
                              AppColors.textFieldOutlineBorderColor))),
                  hintText: AppStrings.lastNameHintText,
                  hintStyle: TextStyle(
                      fontSize: 15, color: hexToColor(AppColors.hintTextColor)),
                )),
          ),
        ),
      ],
    );
  }

  Widget _greetMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
              text: AppStrings.splashScreenTextTwo + ",",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300, fontSize: 21.0),
              children: <TextSpan>[
                TextSpan(
                  text: AppStrings.bhulkoo,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 23.0,
                      color: hexToColor(AppColors.paleOrange),
                      height: 1.4),
                )
              ]),
        ),
      ),
    );
  }

  Widget _mayIKnowYourNameText() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 18.0, bottom: 18.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppStrings.enterFullNameTitleText,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              color: hexToColor(AppColors.whiteTextColor),
              fontSize: 22.0,
              height: 1.5),
        ),
      ),
    );
  }
}
