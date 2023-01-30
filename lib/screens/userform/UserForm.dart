import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> with TickerProviderStateMixin {
  int currStep = 6;
  int stepCount = 9;
  UserFormModel model = UserFormModel();
  final PageController _controller = PageController();
  late ValueNotifier<double> _valueNotifier;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _valueNotifier = ValueNotifier<double>(1);

    _controller.addListener(() {
      _valueNotifier.value =
          (_controller.page != null ? _controller.page! + 1 : 1);
    });
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status $e');
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
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
      var snackBar = errorSnackBar(context, msg);
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
        Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: InkWell(
            onTap: () async {
              EasyLoading.instance
                ..backgroundColor = Colors.white10
                ..userInteractions = false;
              EasyLoading.show(
                status: 'Please wait...',
              );
              if (_connectionStatus == ConnectivityResult.none) {
                errorSnackBar(context, AppStrings.noInternetConnDescriptionOne);
                EasyLoading.dismiss();
              } else {
                await MozakSheetApi.insertUserData(model);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FormSuccessScreen()));
                EasyLoading.dismiss();
              }
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
        ),
      ],
    ));
  }
}
