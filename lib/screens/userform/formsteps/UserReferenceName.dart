import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

class UserReferenceName extends StatefulWidget {
  final UserFormModel model;

  const UserReferenceName(this.model, {Key? key}) : super(key: key);

  @override
  State<UserReferenceName> createState() => _UserReferenceNameState();
}

class _UserReferenceNameState extends State<UserReferenceName> {
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  // String? selectedState;
  //String dropdownValue = "BR";
  //String tLNameCode = "Aditya Jejurkar	BR01";
  // final List<String> _grpList = [
  //   "BR",
  //   "CR",
  //   "DS",
  //   "GK",
  //   "HK",
  //   "SK",
  //   "SM",
  //   "SY",
  // ];

  String dropdownValue = "Maharashtra";
  final List<String> _stateList = [
    "Andaman and Nicobar",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Orissa",
    "Puducherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal	"
  ];
  // final List<String> BR = [
  //   "Aditya Jejurkar	BR01",
  //   "Akshay Shelar	BR02",
  //   "Deepak Bhilare	BR03",
  //   "Nikhil Jagdale	BR04",
  //   "Nikhil Jagtap	BR05",
  //   "Omkar Lande	BR06",
  //   "Rammani Gupta	BR07",
  //   "Rupesh Tukaram Jadhav	BR08",
  //   "Suraj Nanasaheb Jadhav	BR09",
  // ];
  // final List<String> CR = [
  //   "Mahendra Dora	CR01",
  //   "Nimesh Solanki	CR02",
  //   "Rakesh Gupta	CR03",
  //   "Rakesh Patel	CR04",
  //   "Ronak Panchal	CR05",
  //   "Shrikant Lonkar	CR06",
  //   "Vikas Sharma	CR07",
  //   "Yogesh Mahapadi	CR08",
  // ];
  // final List<String> DS = [
  //   "Ajay Gawde	DS01",
  //   "Amol Jaybhaye	DS02",
  //   "Chethan Gowda	DS03",
  //   "Ganesh Sargar	DS04",
  //   "Girish Chhatani	DS05",
  //   "Haresh Shingare	DS06",
  //   "Manish Shirvadkar	DS07",
  //   "Naresh Manish Salvi	DS08",
  //   "Omkar Sanjay Desai	DS09",
  //   "Samir Shinde	DS10",
  //   "Saurabh Rasal	DS11",
  //   "Shreedhar Dhopat	DS12",
  //   "Shubham Dalvi	DS13",
  //   "Siddhesh Kadam	DS14",
  // ];
  // final List<String> GK = [
  //   "Bhavesh Rawal	GK01",
  //   "Dakshesh	GK02",
  //   "Deep Panchal	GK03",
  //   "Karan Gosalia	GK04",
  //   "Nikhil Katta	GK05",
  //   "Pratik Mehta	GK06",
  //   "Rohit More	GK07",
  //   "Sagar Sarvaiya	GK08",
  //   "Shreeram Ingale	GK09",
  //   "Urvesh Kothari	GK10",
  //   "Vishal Goswami	GK11",
  //   "Vishal Mehta	GK12",
  // ];
  // final List<String> HK = [
  //   "Aatish Gupta	HK01",
  //   "Abhishek Trivedi	HK02",
  //   "Amar Daxini 	HK03",
  //   "Anirudha Patil	HK04",
  //   "Jayesh Kasargod	HK05",
  //   "Lopesh	HK06",
  //   "Manish Jain	HK07",
  //   "Nirav Mirani	HK08",
  //   "Nobin Trinath Sahu	HK09",
  //   "Pramod Gupta	HK10",
  //   "Santosh Prajapati	HK11",
  //   "Shaktinarayan HK12",
  //   "Urvesh Trivedi	HK13",
  //   "Vinod Gupta HK14",
  //   "Yash Mirani HK15",
  // ];
  // final List<String> SK = [
  //   "Abhay Shembade	SK01",
  //   "Harsh Mahesh Kanzariya	SK02",
  //   "Harshad L Bhanushali	SK03",
  //   "Kailash Bhanushali	SK04",
  //   "Milan Rambhiya	SK05",
  //   "Santan Swain	SK06",
  //   "Vinay Ramesh Katwa	SK07",
  // ];
  // final List<String> SM = [
  //   "Anil Chaurasiya	SM01",
  //   "Devendra prajapati	SM02",
  // ];
  // final List<String> SY = [
  //   "Abhay Shembade	SY01",
  //   "Abhishek Dubey	SY02",
  //   "Abhishek Pandey SY03",
  //   "Avanish Singh SY04",
  //   "Jayesh Salvi	SY05",
  //   "Kishor Patel	SY06",
  //   "Shilpesh Tawde	SY07",
  // ];

  @override
  void initState() {
    super.initState();

    dropdownValue = widget.model.getRefGrp();
    //tLNameCode = widget.model.getReferenceName();
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
                    const EdgeInsets.only(left: 18.0, top: 35.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.justLastQuestionText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.referenceNameTitleText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.3),
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
                        _buildTeamLeadField(),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamLeadField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.teamLeadFieldText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
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
              items: _stateList.map<DropdownMenuItem<String>>((String value) {
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
                  widget.model.setState(newValue!);
                });
              },
              value: dropdownValue,
            ),

            // DropdownButton(
            //   icon: const SizedBox.shrink(),
            //   dropdownColor: hexToColor(AppColors.appThemeColor),
            //   style: GoogleFonts.montserrat(
            //       fontWeight: FontWeight.w400,
            //       color: hexToColor(AppColors.whiteTextColor),
            //       fontSize: 17.0),
            //   underline: DropdownButtonHideUnderline(child: Container()),
            //   items: _grpList.map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //         value: value,
            //         child: value == dropdownValue
            //             ? Text(
            //                 value,
            //                 style: const TextStyle(color: Colors.white),
            //               )
            //             : Text(
            //                 value,
            //                 style: TextStyle(
            //                     color: hexToColor(AppColors.paleOrange)),
            //               ));
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       dropdownValue = newValue ?? dropdownValue;
            //       widget.model.setRefGrp(newValue!);
            //     });
            //   },
            //   value: dropdownValue,
            // ),
          ),
        ),
      ],
    );
  }
}
