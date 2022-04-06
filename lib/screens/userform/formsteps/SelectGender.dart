import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/app_tools.dart';

class SelectGender extends StatefulWidget {
  final UserFormModel model;
  final next;

  const SelectGender(this.model, this.next, {Key? key}) : super(key: key);

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  int currStep = 0;

  @override
  Widget build(BuildContext context) {
    var maleSelected = Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: hexToColor(AppColors.paleOrange),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(AppAssets.maleImgBlack),
      ),
    );

    var maleUnselected = Container(
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
        child: Image.asset(AppAssets.maleImgWhite),
      ),
    );

    var femaleSelected = Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: hexToColor(AppColors.paleOrange),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(AppAssets.femaleImgBlack),
      ),
    );

    var femaleUnSelected = Container(
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
        child: Image.asset(AppAssets.femaleImgWhite),
      ),
    );

    return Scaffold(
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 18.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.genderSelection,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 22.0)),
            ),
          ),

          // Gender selection ui
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 18.0),
            child: Row(
              children: [
                // female selection
                GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.model.setGender("Female");
                        widget.next();
                      });
                    },
                    child: widget.model.getGender() == "Female"
                        ? femaleSelected
                        : femaleUnSelected),

                // male selection
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.model.setGender("Male");
                        widget.next();
                      });
                    },
                    child: widget.model.getGender() == "Male"
                        ? maleSelected
                        : maleUnselected,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
