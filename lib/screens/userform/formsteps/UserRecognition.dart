import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

class UserRecognition extends StatefulWidget {
  final UserFormModel model;

  final next;

  const UserRecognition(this.model, this.next, {Key? key}) : super(key: key);

  @override
  State<UserRecognition> createState() => _UserRecognitionState();
}

class _UserRecognitionState extends State<UserRecognition> {
  final maxLines = 2;
  var recognition = <String, bool>{"New": true, "Old": false};
  String dropdownValue = "New";

  @override
  void initState() {
    dropdownValue = widget.model.getRecognition();
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
              _isYouthNew(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 40.0),
                child: Form(
                    child: Column(
                  children: [
                    _buildDropDown(),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropDown() {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 10, top: 20.0),
        //   child: Align(
        //     alignment: Alignment.centerLeft,
        //     child: Text(
        //       AppStrings.stateFieldText,
        //       style: GoogleFonts.montserrat(
        //           fontWeight: FontWeight.w400,
        //           color: hexToColor(AppColors.whiteTextColor),
        //           fontSize: 15.0),
        //     ),
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: hexToColor(AppColors.textFieldOutlineBorderColor),
              width: 1.0,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: DropdownButton(
              icon: const SizedBox.shrink(),
              dropdownColor: hexToColor(AppColors.appThemeColor),
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 17.0),
              underline: DropdownButtonHideUnderline(child: Container()),
              items: recognition.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: value == dropdownValue
                        ? Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          )
                        : Text(
                            value,
                            style: TextStyle(
                                color: hexToColor(AppColors.paleOrange)),
                          ));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue ?? dropdownValue;
                  widget.model.setRecognition(newValue!);
                });
              },
              value: dropdownValue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _isYouthNew() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 18.0, bottom: 18.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppStrings.recognitionText1,
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
