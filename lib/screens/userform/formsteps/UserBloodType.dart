import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/app_tools.dart';

class UserBloodType extends StatefulWidget {
  final UserFormModel model;
  final next;

  const UserBloodType(this.model, this.next, {Key? key}) : super(key: key);

  @override
  State<UserBloodType> createState() => _UserBloodType();
}

class _UserBloodType extends State<UserBloodType> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 35.0, bottom: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.bloodGroupTitleText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GridView(
                  padding: const EdgeInsets.only(right: 50.0),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  children: [
                    _bloodGroup(AppStrings.oPlusBloodGroup),
                    _bloodGroup(AppStrings.aPlusBloodGroup),
                    _bloodGroup(AppStrings.bPlusBloodGroup),
                    _bloodGroup(AppStrings.abPlusBloodGroup),
                    _bloodGroup(AppStrings.oNegBloodGroup),
                    _bloodGroup(AppStrings.aNegBloodGroup),
                    _bloodGroup(AppStrings.bNegBloodGroup),
                    _bloodGroup(AppStrings.abNegBloodGroup),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bloodGroup(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.model.setBloodGroup(text);
          widget.next();
        });
      },
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: widget.model.getBloodGroup() == text
              ? hexToColor(AppColors.paleOrange)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.model.getBloodGroup() == text
                ? hexToColor(AppColors.paleOrange)
                : Colors.white,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: widget.model.getBloodGroup() == text
                      ? Colors.black
                      : hexToColor(AppColors.whiteTextColor),
                  fontSize: 22.0,
                  height: 1.5)),
        ),
      ),
    );
  }
}
