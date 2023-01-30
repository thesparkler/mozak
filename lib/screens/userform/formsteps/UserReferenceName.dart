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
  String? _selectedCode;
  String selectedMandal = "Bramhadarshan";
  String selectedTL = "Aditya Jejurkar BR01";
  TextEditingController reference_name = TextEditingController();

  final List<String> _grpCodeList = [
    "Bramhadarshan",
    "Charanraj",
    "Dasatva",
    "Gurukrupa",
    "Harikrupa",
    "Santkrupa",
    "Sarvamangal",
    "Samanvay",
  ];
  final Map<String, String> codeMap = {
    "Bramhadarshan": "BR",
    "Charanraj": "CR",
    "Dasatva": "DS",
    "Gurukrupa": "GK",
    "Harikrupa": "HK",
    "Santkrupa": "SK",
    "Sarvamangal": "SM",
    "Samanvay": "SY",
  };

  final List<String> mandalBR = [
    "Aditya Jejurkar BR01",
    "Akshay Shelar BR02",
    "Deepak Bhilare	BR03",
    "Nikhil Jagdale	BR04",
    "Nikhil Jagtap BR05",
    "Omkar Lande BR06",
    "Rammani Gupta BR07",
    "Rupesh Tukaram Jadhav BR08",
    "Suraj Nanasaheb Jadhav	BR09",
  ];
  final List<String> mandalCR = [
    "Mahendra Dora CR01",
    "Nimesh Solanki	CR02",
    "Rakesh Gupta	CR03",
    "Rakesh Patel CR04",
    "Ronak Panchal CR05",
    "Shrikant Lonkar CR06",
    "Vikas Sharma	CR07",
    "Yogesh Mahapadi CR08",
  ];
  final List<String> mandalDS = [
    "Ajay Gawde DS01",
    "Amol Jaybhaye DS02",
    "Chethan Gowda DS03",
    "Ganesh Sargar DS04",
    "Girish Chhatani DS05",
    "Haresh Shingare DS06",
    "Manish Shirvadkar DS07",
    "Naresh Manish Salvi DS08",
    "Omkar Sanjay Desai	DS09",
    "Samir Shinde	DS10",
    "Saurabh Rasal DS11",
    "Shreedhar Dhopat	DS12",
    "Shubham Dalvi DS13",
    "Siddhesh Kadam	DS14",
  ];
  final List<String> mandalGK = [
    "Bhavesh Rawal GK01",
    "Dakshesh	GK02",
    "Deep Panchal	GK03",
    "Karan Gosalia GK04",
    "Nikhil Katta	GK05",
    "Pratik Mehta	GK06",
    "Rohit More GK07",
    "Sagar Sarvaiya GK08",
    "Shreeram Ingale GK09",
    "Urvesh Kothari	GK10",
    "Vishal Goswami	GK11",
    "Vishal Mehta	GK12",
  ];
  final List<String> mandalHK = [
    "Aatish Gupta	HK01",
    "Abhishek Trivedi	HK02",
    "Amar Daxini HK03",
    "Anirudha Patil	HK04",
    "Jayesh Kasargod HK05",
    "Lopesh	HK06",
    "Manish Jain HK07",
    "Nirav Mirani	HK08",
    "Nobin Trinath Sahu	HK09",
    "Pramod Gupta	HK10",
    "Santosh Prajapati HK11",
    "Shaktinarayan HK12",
    "Urvesh Trivedi	HK13",
    "Vinod Gupta HK14",
    "Yash Mirani HK15",
  ];
  final List<String> mandalSK = [
    "Abhay Shembade	SK01",
    "Harsh Mahesh Kanzariya	SK02",
    "Harshad L Bhanushali	SK03",
    "Kailash Bhanushali	SK04",
    "Milan Rambhiya	SK05",
    "Santan Swain	SK06",
    "Vinay Ramesh Katwa	SK07",
  ];
  final List<String> mandalSM = [
    "Anil Chaurasiya	SM01",
    "Devendra prajapati	SM02",
  ];
  final List<String> mandalSY = [
    "Abhay Shembade	SY01",
    "Abhishek Dubey	SY02",
    "Abhishek Pandey SY03",
    "Avanish Singh SY04",
    "Jayesh Salvi	SY05",
    "Kishor Patel	SY06",
    "Shilpesh Tawde	SY07",
  ];
  late List<String> currentTLList;

  @override
  void initState() {
    selectedMandal = widget.model.getRefGrp();
    _selectedCode = codeMap[selectedMandal]!;
    if (_selectedCode == "BR") {
      currentTLList = mandalBR;
      selectedTL = widget.model.getReferenceName();
    } else if (_selectedCode == "CR") {
      currentTLList = mandalCR;
      selectedTL = widget.model.getReferenceName();
    } else if (_selectedCode == "DS") {
      currentTLList = mandalDS;
      selectedTL = widget.model.getReferenceName();
    } else if (_selectedCode == "GK") {
      currentTLList = mandalGK;
      selectedTL = widget.model.getReferenceName();
    } else if (_selectedCode == "HK") {
      currentTLList = mandalHK;
      selectedTL = widget.model.getReferenceName();
    } else if (_selectedCode == "SK") {
      currentTLList = mandalSK;
      selectedTL = widget.model.getReferenceName();
    } else if (_selectedCode == "SM") {
      currentTLList = mandalSM;
      selectedTL = widget.model.getReferenceName();
    } else {
      currentTLList = mandalSY;
      selectedTL = widget.model.getReferenceName();
    }
    widget.model.setReferenceName(selectedTL);
    print(_selectedCode);
    print(widget.model.getReferenceName());
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
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 18.0, top: 35.0, bottom: 30.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       AppStrings.justLastQuestionText,
              //       style: GoogleFonts.montserrat(
              //           fontWeight: FontWeight.w400,
              //           color: hexToColor(AppColors.whiteTextColor),
              //           fontSize: 22.0,
              //           height: 1.3),
              //     ),
              //   ),
              // ),
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
                        _grpCodeDropDownField(),
                        _teamLeaderDropDownFeild()
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _grpCodeDropDownField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.reference,
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
    child: TextField(
      controller: reference_name,
      style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w400,
          color: hexToColor(AppColors.whiteTextColor),
          fontSize: 15.0),
    )

    )
    ),

        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.teamName,
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
              items: _grpCodeList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: value == selectedMandal
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
                  selectedMandal = newValue!;
                  widget.model.setRefGrp(newValue);
                  _selectedCode = codeMap[selectedMandal]!;
                  if (_selectedCode == "BR") {
                    currentTLList = mandalBR;
                    selectedTL = currentTLList[0].toString();
                  } else if (_selectedCode == "CR") {
                    currentTLList = mandalCR;
                    selectedTL = currentTLList[0].toString();
                  } else if (_selectedCode == "DS") {
                    currentTLList = mandalDS;
                    selectedTL = currentTLList[0].toString();
                  } else if (_selectedCode == "GK") {
                    currentTLList = mandalGK;
                    selectedTL = currentTLList[0];
                  } else if (_selectedCode == "HK") {
                    currentTLList = mandalHK;
                    selectedTL = currentTLList[0];
                  } else if (_selectedCode == "SK") {
                    currentTLList = mandalSK;
                    selectedTL = currentTLList[0];
                  } else if (_selectedCode == "SM") {
                    currentTLList = mandalSM;
                    selectedTL = currentTLList[0];
                  } else {
                    currentTLList = mandalSY;
                    selectedTL = currentTLList[0];
                  }
                  widget.model.setReferenceName(selectedTL);
                  print(_selectedCode);
                  print(widget.model.getReferenceName());
                });
              },
              value: selectedMandal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _teamLeaderDropDownFeild() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.reference,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.teamName,
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
              items:
                  currentTLList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: value == selectedTL
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
                  selectedTL = newValue!;
                  widget.model.setReferenceName(newValue);
                  print(widget.model.getRefGrp());
                });
              },
              value: selectedTL,
            ),
          ),
        ),
      ],
    );
  }
}
