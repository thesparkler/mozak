import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/api/mozak_sheet_api.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/screens/FormSuccessScreen.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/screens/userform/formsteps/SelectGender.dart';
import 'package:mozak/screens/userform/formsteps/UserAddressInfo.dart';
import 'package:mozak/screens/userform/formsteps/UserCareerType.dart';
import 'package:mozak/screens/userform/formsteps/UserContactInfo.dart';
import 'package:mozak/screens/userform/formsteps/UserDob.dart';
import 'package:mozak/screens/userform/formsteps/UserReferenceName.dart';
import 'package:mozak/screens/userform/formsteps/VerifyDetails.dart';
import 'package:mozak/utils/CustomLinearProgress.dart';
import 'package:mozak/utils/app_tools.dart';
import 'formsteps/UserBloodType.dart';
import 'formsteps/UserFullName.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> with TickerProviderStateMixin {
  int currStep = 1;
  int stepCount = 9;
  UserFormModel model = UserFormModel();
  final PageController _controller = PageController();
  late ValueNotifier<double> _valueNotifier;
  final nameFormKey = GlobalKey<FormState>;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<double>(1);

    _controller.addListener(() {
      _valueNotifier.value =
          (_controller.page != null ? _controller.page! + 1 : 1);
    });
  }

  void next() {
    String? msg;
    switch (currStep) {
      case 1:
        msg = model.validateStepOneGender();
        break;
      case 2:
        msg = model.validateStepTwoNamesField();
        break;
      case 3:
        msg = model.validateStepThreeDOB();
        break;
      case 4:
        msg = model.validateStepFourContactInfo();
        break;
      case 5:
        msg = model.validateStepFiveUserAddress();
        break;
      case 7:
        msg = model.validateStep7();
        break;
      case 8:
        msg = model.validateStepEightTeamLead();
        break;
    }
    if (null != msg) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(msg),
      //   action: SnackBarAction(
      //     label: 'Dismiss',
      //     textColor: Colors.white,
      //     onPressed: () {
      //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //     },
      //   ),
      //   backgroundColor: Color(0xFFD10000),
      // ));
      final snackBar = SnackBar(
        backgroundColor: Color(0xFFD10000),
        content: Container(
            width: MediaQuery.of(context).size.width,
            height: 25,
            // padding: const EdgeInsets.all(8),
            // decoration: BoxDecoration(
            //   color: Colors.greenAccent,
            //   border: Border.all(color: Colors.green, width: 3),
            //   boxShadow: const [
            //     BoxShadow(
            //       color: Color(0xFFD10000),
            //       spreadRadius: 2.0,
            //       blurRadius: 8.0,
            //       offset: Offset(2, 4),
            //     )
            //   ],
            //   borderRadius: BorderRadius.circular(4),
            // ),
            child: Row(
              children: [
                Text(msg, style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 15.0),),
                const Spacer(),
                GestureDetector(
                  onTap: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 5.0, top: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      "Dismiss",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          color: hexToColor(AppColors.whiteTextColor),
                          fontSize: 15.0),
                      // TextStyle(
                      //   color: Colors.white,
                      // ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                // TextButton(
                //     onPressed: () => debugPrint("Undid"),
                //     child: Text("Undo", style: TextStyle(color: Colors.white)))
              ],
            )),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }
    // everything is green
    _controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void prev() {
    _controller.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    var steps = [
      SelectGender(model, next),
      UserFullName(model),
      UserDob(model),
      UserContactInfo(model),
      UserAddressInfo(model),
      UserBloodType(model, next),
      UserCareerType(model),
      UserReferenceName(model),
      VerifyDetails(model),
    ];

    return Scaffold(
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Column(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: _valueNotifier,
            builder: (context, v, child) {
              currStep = v.round();
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Step ${v.round()} of $stepCount",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: hexToColor(AppColors.paleOrange),
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    CustomLinearProgress(
                      progress: v / stepCount,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          v > 1.0 ? _buildPreviousIcon() : Container(),
                          v < 8.5 ? _buildNextIcon() : _buildDoneIcon(),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return steps[index];
              },
              itemCount: stepCount,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousIcon() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => prev(),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: hexToColor(AppColors.prevBtnColor)),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: hexToColor(
                AppColors.whiteTextColor,
              ),
              size: 15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(AppStrings.prevStepText,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                color: hexToColor(AppColors.prevNextBtnTextColor),
                fontSize: 15.0,
              )),
        ),
      ],
    );
  }

  Widget _buildNextIcon() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(AppStrings.nextStepText,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                color: hexToColor(AppColors.whiteTextColor),
                fontSize: 15.0,
              )),
        ),
        GestureDetector(
          onTap: () => next(),
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: hexToColor(AppColors.orangeAccent)),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: hexToColor(
                  AppColors.whiteTextColor,
                ),
                size: 15,
              )),
        ),
      ],
    );
  }

  Widget _buildDoneIcon() {
    return SizedBox(
        child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(AppStrings.saveDetailsText,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                color: hexToColor(AppColors.whiteTextColor),
                fontSize: 15.0,
              )),
        ),
        GestureDetector(
          onTap: () async {
            await MozakSheetApi.insertUserData(model);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FormSuccessScreen()));
          },
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: hexToColor(AppColors.greenAccent)),
              child: Icon(
                Icons.done,
                color: hexToColor(
                  AppColors.colorBlack,
                ),
                size: 22,
              )),
        ),
      ],
    ));
  }
}
