import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/app_tools.dart';
import 'package:intl/intl.dart';

class UserDob extends StatefulWidget {
  final UserFormModel model;

  const UserDob(this.model, {Key? key}) : super(key: key);

  @override
  State<UserDob> createState() => _UserDobState();
}

class _UserDobState extends State<UserDob> {
  final maxLines = 2;
  var userName = '';
  var dateController = TextEditingController(text: "");
  var selected;
  var date;

  @override
  void initState() {
    super.initState();
    userName = widget.model.getFirstName();
    dateController.text = widget.model.getDOB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _myNameText(),
            _dobTitleText(),
            _dobTapHereIcon(),
            Container(
              child: widget.model.getDOB() == ''
                  ? Container()
                  : _dateOfBirthField(),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: hexToColor(AppColors.orangeAccent),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: hexToColor(AppColors.appThemeColor),
          ),
          child: child ?? const Text(""),
        );
      },
      initialDate: DateTime(1997),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (selected != null) {
      var formatter = DateFormat('yyyy-MM-dd');

      setState(() {
        date = dateController.text = formatter.format(selected);
        widget.model.setDOB(date);
      });
    }
  }

  Widget _dateOfBirthField() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 40.0, right: 18.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.dobFieldText,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 15.0)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              height: maxLines * 25.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: hexToColor(AppColors.grey),
                  width: 0.8,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  enabled: false,
                  controller: dateController,
                  decoration: const InputDecoration(
                      hintText: 'YYYY-MM-DD',
                      hintStyle:
                          TextStyle(color: Color(0xFF757575), fontSize: 15.0)),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dobTapHereIcon() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 30.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            color: hexToColor(AppColors.paleOrange),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.birthDateCalendar,
                      height: 50,
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        AppStrings.tapHereText,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 10.0,
                            height: 1.3),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _myNameText() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 25.0),
      child: Row(
        children: [
          Text(
            AppStrings.helloText + "",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                color: hexToColor(AppColors.whiteTextColor),
                fontSize: 22.0,
                height: 1.3),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              capitalizeFirstLetter(userName),
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.paleOrange),
                  fontSize: 22.0,
                  height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dobTitleText() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppStrings.dobTitleText,
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
