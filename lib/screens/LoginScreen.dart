import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
  }

  void _toogleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  showSnackBar(String text, Color color) {
    _scaffoldKey.currentState
        ?.showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: hexToColor(AppColors.appThemeColor),
        title: Row(
          children: [
            Text(AppStrings.dialogTitle,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: hexToColor(AppColors.whiteTextColor))),
          ],
        ),
        content: Text(AppStrings.dialogDescription,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
                color: hexToColor(AppColors.whiteTextColor))),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: hexToColor(AppColors.appThemeColor),
                          side: BorderSide(
                              width: 1.0,
                              color: hexToColor(AppColors.grey))),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        AppStrings.cancelBtnText,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: hexToColor(AppColors.grey),
                          fontSize: 15.0,
                        ),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: hexToColor(AppColors.redAccent)
                        //const Color(0xffC93131),
                      ),
                      onPressed: () {
                        exit(0);
                      },
                      child: Text(
                        AppStrings.exitBtnText,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: hexToColor(AppColors.whiteTextColor),
                          fontSize: 15.0,
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: Scaffold(
          backgroundColor: hexToColor(AppColors.appThemeColor),
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.60,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.hariSwamiBgImage),
                          )),
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    top: (MediaQuery.of(context).size.height / 2.50) - 30,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          color: hexToColor(AppColors.appThemeColor),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: AppStrings.helloText,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 21.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: AppStrings.bhulkooText,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: hexToColor(
                                                    AppColors.paleOrange),
                                                fontSize: 21.0),
                                          ),
                                          TextSpan(
                                            text: AppStrings.welcomeBackText,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 21.0,
                                                height: 1.5),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppStrings.emailText,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: maxLines * 25.0,
                                        child: TextFormField(
                                            onSaved: (val) => _email = val!,
                                            keyboardType: TextInputType.emailAddress,
                                            textInputAction: TextInputAction.next,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
                                                fontSize: 17.0),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: hexToColor(AppColors
                                                        .textFieldOutlineBorderColor)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide: BorderSide(
                                                      color: hexToColor(
                                                          AppColors
                                                              .paleOrange))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide: BorderSide(
                                                      color: hexToColor(AppColors
                                                          .textFieldOutlineBorderColor))),
                                              hintText:
                                              AppStrings.emailHintText,
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: hexToColor(
                                                      AppColors.hintTextColor)),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppStrings.passwordText,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: maxLines * 25.0,
                                        child: TextFormField(
                                            onSaved: (val) => _password = val!,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.done,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
                                                fontSize: 17.0),
                                            maxLines: 1,
                                            obscureText: !_showPassword,
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide: BorderSide(
                                                      color: hexToColor(
                                                          AppColors
                                                              .paleOrange))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide: BorderSide(
                                                      color: hexToColor(AppColors
                                                          .textFieldOutlineBorderColor))),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _toogleVisibility();
                                                },
                                                child: Icon(
                                                  _showPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: hexToColor(
                                                      AppColors.iconColor),
                                                  size: 22,
                                                ),
                                              ),
                                              hintText:
                                              AppStrings.passwordHintText,
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: hexToColor(
                                                      AppColors.hintTextColor)),
                                            )),
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 35,
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                        hexToColor(AppColors.orangeAccent)),
                                    onPressed: () {
                                      _formKey.currentState!.save();
                                      var result =
                                      validation(_email, _password);
                                      if (result != null) {
                                        showSnackBar(result,
                                            hexToColor(AppColors.redAccent));
                                        return;
                                      }
                                      showSnackBar(
                                          AppStrings.validationSuccessText,
                                          hexToColor(AppColors.greenAccent));
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const UserForm()));
                                    },
                                    child: Text(
                                      AppStrings.loginBtnText,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        color: hexToColor(
                                            AppColors.whiteTextColor),
                                        fontSize: 18.0,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validation(String email, String password) {
  if (email.isEmpty) {
    return AppStrings.isEmailRequired;
  }
  if (!email.contains("@")) {
    return AppStrings.emailErrorText;
  }
  if (password.isEmpty) {
    return AppStrings.isPasswordRequired;
  }
  if (password.length < 5) {
    return AppStrings.passwordLengthErrorText;
  }
  return null;
}
