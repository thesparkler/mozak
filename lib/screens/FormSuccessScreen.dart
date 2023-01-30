import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mozak/constants/AppAssets.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/utils/app_tools.dart';

class FormSuccessScreen extends StatefulWidget {
  const FormSuccessScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormSuccessScreenState();
}

class FormSuccessScreenState extends State<FormSuccessScreen> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset(
                    AppAssets.lottieDone,
                    repeat: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(AppStrings.thankYouText,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 25.0)),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(AppStrings.submittedResponse,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w200,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.4),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserForm()));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 70.0, right: 70.0, top: 50),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(AppStrings.backToLogin,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w300,
                              color: hexToColor(AppColors.grey),
                              fontSize: 20.0,
                              height: 1.4),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
