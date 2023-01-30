import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

class UserContactInfo extends StatefulWidget {
  final UserFormModel model;
  final next;

  const UserContactInfo(this.model, this.next, {Key? key}) : super(key: key);

  @override
  State<UserContactInfo> createState() => _UserContactInfoState();
}

class _UserContactInfoState extends State<UserContactInfo> {
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();

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
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, top: 20.0, bottom: 40.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.contactDetailsTitleText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.5),
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
                        _buildEmailField(),
                        _buildContactNo(),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.emailText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(
            height: maxLines * 25.0,
            child: TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: (val) {
                  widget.model.setEmail(val);
                },
                initialValue: widget.model.getEmail(),
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
                  hintText: AppStrings.emailHintText,
                  hintStyle: TextStyle(
                      fontSize: 15, color: hexToColor(AppColors.hintTextColor)),
                )),
          ),
        ),
      ],
    );
  }

  Widget _buildContactNo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.contactNoFieldText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: SizedBox(
            height: maxLines * 25.0,
            child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                ],
                textInputAction: TextInputAction.done,
                onChanged: (val) {
                  widget.model.setContactInfo(val);
                },
                onEditingComplete: () {
                  widget.next();
                },
                initialValue: widget.model.getContactNo(),
                keyboardType: TextInputType.number,
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
                  hintText: AppStrings.contactNoFieldHintText,
                  hintStyle: TextStyle(
                      fontSize: 15, color: hexToColor(AppColors.hintTextColor)),
                )),
          ),
        ),
      ],
    );
  }
}
