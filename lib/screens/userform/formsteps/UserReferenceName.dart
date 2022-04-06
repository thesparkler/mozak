
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

class UserReferenceName extends StatefulWidget {
  final UserFormModel model;

  const UserReferenceName(this.model, {Key? key}) : super(key: key);

  @override
  State<UserReferenceName> createState() => _UserReferenceNameState();
}

class _UserReferenceNameState extends State<UserReferenceName> {
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.only(left: 18.0, top: 35.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.justLastQuestionText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.referenceNameTitleText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.3),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 40.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                       _buildTeamLeadField(),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamLeadField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.teamLeadFieldText,
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
              onChanged: (val) {
                widget.model.setReferenceName(val);
              },
              initialValue: widget.model.getReferenceName(),
              keyboardType: TextInputType.text,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 17.0),
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: hexToColor(AppColors
                          .textFieldOutlineBorderColor)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color:
                        hexToColor(AppColors.paleOrange))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color: hexToColor(AppColors
                            .textFieldOutlineBorderColor))),
                hintText: AppStrings.teamLeadFieldHintText,
                hintStyle: TextStyle(
                    fontSize: 15,
                    color: hexToColor(AppColors.hintTextColor)),
              )),
        ),
      ],
    );
  }
}
