import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

TextStyle kGoogleStyleTexts = GoogleFonts.nunitoSans(
    fontWeight: FontWeight.w600, color: Colors.black, fontSize: 20.0);

String capitalizeFirstLetter(String text) {
  final String firstLetter = text.trim().substring(0, 1).toUpperCase();
  final remainingLetters = text.trim().substring(1);
  String combinedText = firstLetter + remainingLetters;
  return combinedText;
}

Future internetConnectivityDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Colors.white,
            height: 350,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: hexToColor(AppColors.paleOrange),
                  ),
                  height: 175,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.net, height: 75, width: 75),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          AppStrings.noInternetConnTitle,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: hexToColor(AppColors.colorBlack),
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 10, right: 10.0),
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: [
                          AutoSizeText(
                            AppStrings.noInternetConnDescriptionOne,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: AutoSizeText(
                              AppStrings.noInternetConnDescriptionTwo,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 25.0),
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black38,
                                        spreadRadius: 1.5),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    AppStrings.retryBtnText,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

SnackBar errorSnackBar(BuildContext context, String errorMsg) {
  return SnackBar(
    backgroundColor: hexToColor(AppColors.red),
    content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 25,
        child: Row(
          children: [
            Text(
              errorMsg,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
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
                  AppStrings.dismissText,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        )),
    duration: Duration(milliseconds: 1000),
  );
}
