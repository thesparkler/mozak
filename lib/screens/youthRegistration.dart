import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mozak/model/youth.dart';
import 'package:mozak/utils/youthData.dart';
import '../constants/AppColors.dart';
import '../utils/NoGlowBehaviour.dart';
import '../utils/api_service.dart';
import '../utils/app_tools.dart';
import 'package:email_validator/email_validator.dart';

final Map<String, String> group = {
  "Aksharbramh": "AB",
  "Bramhadarshan": "BR",
  "Charanraj": "CR",
  "Dasatva": "DS",
  "Gurukrupa": "GK",
  "Harikrupa": "HK",
  "Santkrupa": "SK",
  "Sarvamangal": "SM",
  "Samanvay": "SY",
};

class YouthRegistration extends StatefulWidget {
  const YouthRegistration({Key? key}) : super(key: key);

  @override
  State<YouthRegistration> createState() => _YouthRegistrationState();
}

class _YouthRegistrationState extends State<YouthRegistration> {
  String groupCode = group.values.first;
  String groupName = group.keys.first;
  bool isNew = false;

  var teamLeader;
  var currentList = <Youth>[];

  DateTime? pickedDate;

  var date;
  var selected;

  Youth youth = Youth(isTL: false, isKK: false);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> signUpController = {
    'firstName': TextEditingController(),
    'middleName': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'mobile': TextEditingController(),
    'pincode': TextEditingController(),
    'address': TextEditingController(),
    'team': TextEditingController(),
    'tlcode': TextEditingController(),
    'dateController': TextEditingController(),
    'street': TextEditingController(),
    'city': TextEditingController(),
    'state': TextEditingController(text: "Maharashtra"),
  };

  @override
  void initState() {
    currentList = YouthData.instance.youthList
        .where((element) =>
            element.isTL && element.rollno?.substring(0, 2) == groupCode)
        .toList();
    teamLeader = currentList[0];
    youth.tlCode = teamLeader.rollno.toString();
    youth.team = teamLeader.rollno.substring(0, 4);
    print('${youth.tlCode}');
    super.initState();
  }

  pickDate(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), //get today's date
      firstDate: DateTime(
          1934), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      var formatter = DateFormat('yyyy-MM-dd');

      setState(() {
        date = signUpController['dateController']?.text =
            formatter.format(selected);
      });
    }
  }

  void _trySubmit(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      EasyLoading.instance
        ..backgroundColor = Colors.white10
        ..userInteractions = false;
      EasyLoading.show(status: "Please Wait.....!");

      // create new youth object
      youth.youthFullName = youth.getFullName();
      var response = await ApiService().setYouth(youth);
      print(response.firstName);
      var newYouth;
      // set roll no
      try {
        newYouth = await ApiService().setRollNo(response, isNew);
        print(newYouth.rollno);
      } catch (e) {
        EasyLoading.dismiss();
      }
      YouthData.instance.youthList = [];
      await YouthData.instance.getYouthList();
      EasyLoading.dismiss();
      Navigator.of(context)
          .pushReplacementNamed("FormSuccessScreen", arguments: newYouth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(
        'New Youth Registration',
        style: kGoogleStyleTexts.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: hexToColor(AppColors.whiteTextColor),
        ),
        textAlign: TextAlign.center,
      ),
      iconTheme: IconThemeData(
        color: hexToColor(AppColors.whiteTextColor),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: hexToColor(AppColors.appThemeColor),
    );

    final bodyHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        backgroundColor: hexToColor(AppColors.appThemeColor),
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: bodyWidth,
            child: Form(
                key: _formKey,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return Column(
                      children: [
                        _buildFirstName(bodyHeight, bodyWidth),
                        _buildMiddleName(bodyHeight, bodyWidth),
                        _buildLastName(bodyHeight, bodyWidth),
                        _buildMobileNumber(bodyHeight, bodyWidth),
                        _buildEmailID(bodyHeight, bodyWidth),
                        _buildAddressStreet(bodyHeight, bodyWidth),
                        _buildCityDistrict(bodyHeight, bodyWidth),
                        _buildState(bodyHeight, bodyWidth),
                        _buildPincode(bodyHeight, bodyWidth),
                        _buildDOB(bodyHeight, bodyWidth, context),
                        SizedBox(
                          height: 5,
                        ),
                        _buildSelectGroup(bodyHeight, bodyWidth),
                        // Container(
                        //     //Group dropdown container
                        //     height: bodyHeight * 0.09,
                        //     width: bodyWidth * 0.8,
                        //     padding: EdgeInsets.all(5.0),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5.0),
                        //       border: Border.all(
                        //         color: hexToColor(
                        //             AppColors.textFieldOutlineBorderColor),
                        //         width: 1.0,
                        //       ),
                        //     ),
                        //     child: DropdownMenu<String>(
                        //       dropdownMenuEntries: [],
                        //     )),
                        SizedBox(
                          height: 10,
                        ),
                        _buildSelectTL(bodyHeight, bodyWidth),
                        SizedBox(
                          height: 10,
                        ),
                        _buildSelectTempNew(bodyHeight, bodyWidth),
                        Text(
                          "*Leaving Unselected creates a permanent Roll Number",
                          softWrap: true,
                          style: TextStyle(color: Colors.white38),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  hexToColor(AppColors.paleOrange)),
                            ),
                            onPressed: () => _trySubmit(context),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: hexToColor(AppColors.centerLogoText)),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Please Check all Details before Submitting the form.",
                          softWrap: true,
                          style: TextStyle(color: Colors.white38),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }

  Container _buildSelectTempNew(double bodyHeight, double bodyWidth) {
    return Container(
      // Create temp rollno
      height: bodyHeight * 0.09,
      width: bodyWidth * 0.775,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.white54,
            width: 1.0,
          )),
      child: RadioListTile<bool>(
          toggleable: true,
          value: true,
          activeColor: Colors.white54,
          fillColor: MaterialStateProperty.all(Colors.white54),
          title: Text(
            'Create Temporary Rollno',
            style: TextStyle(color: Colors.white54),
          ),
          groupValue: isNew,
          onChanged: (value) {
            setState(() {
              isNew = !isNew;
              print('.................$isNew');
            });
          }),
    );
  }

  Container _buildSelectTL(double bodyHeight, double bodyWidth) {
    return Container(
        // Team leader drop down
        height: bodyHeight * 0.08,
        width: bodyWidth * 0.775,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: hexToColor(AppColors.textFieldOutlineBorderColor),
            width: 1.0,
          ),
        ),
        child: DropdownButton<Youth>(
          isExpanded: true,
          underline: SizedBox(),
          dropdownColor: hexToColor(AppColors.homeGridColor),
          icon: SizedBox.shrink(),
          value: teamLeader,
          onChanged: (Youth? value) {
            setState(() {
              teamLeader = value!;
              youth.tlCode = teamLeader.rollno.toString();
              youth.team = teamLeader.team;
              print('${youth.tlCode}');
            });
          },
          items: currentList.map<DropdownMenuItem<Youth>>((Youth value) {
            return DropdownMenuItem<Youth>(
              value: value,
              child: Text(
                value.rollno! + " " + value.youthFullName.toString(),
                softWrap: true,
                style: TextStyle(
                  color: hexToColor(AppColors.whiteTextColor).withOpacity(0.60),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ));
  }

  Container _buildSelectGroup(double bodyHeight, double bodyWidth) {
    return Container(
        //Group dropdown container
        height: bodyHeight * 0.08,
        width: bodyWidth * 0.775,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: hexToColor(AppColors.textFieldOutlineBorderColor),
            width: 1.0,
          ),
        ),
        child: DropdownButton<String>(
          hint: Text("Select"),
          underline: SizedBox(),
          value: groupName,
          dropdownColor: hexToColor(AppColors.homeGridColor),
          icon: SizedBox.shrink(),
          onChanged: (String? value) {
            setState(() {
              groupName = value!;
              groupCode = group[groupName]!;
              currentList = YouthData.instance.youthList
                  .where((element) =>
                      element.isTL &&
                      element.rollno?.substring(0, 2) == groupCode)
                  .toList();

              teamLeader = currentList[0];
              youth.tlCode = teamLeader.rollno.toString();
              youth.team = teamLeader.team;
              print('${youth.tlCode}');
              // print('$dropdownValue');
            });
          },
          items: group.keys.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                softWrap: true,
                style: TextStyle(
                  color: hexToColor(AppColors.whiteTextColor).withOpacity(0.60),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ));
  }

  Container _buildDOB(
      double bodyHeight, double bodyWidth, BuildContext context) {
    return Container(
      //DOB container
      height: bodyHeight * 0.1,
      width: bodyWidth * 0.8,
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: hexToColor(AppColors.whiteTextColor),
        controller: signUpController['dateController'],
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_month,
            color: Colors.white60,
          ),
          labelText: 'DOB',
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          // hintText: signUpController['dateController'],
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: hexToColor(AppColors.whiteTextColor),
            fontSize: 17.0),
        validator: (value) => value != null ? null : 'Please select DOB',
        readOnly: true,
        onTap: () => pickDate(context),
        onSaved: (value) {
          youth.dob = value.toString();
        },
      ),
    );
  }

  Container _buildPincode(double bodyHeight, double bodyWidth) {
    return Container(
        // pin code
        height: bodyHeight * 0.1,
        width: bodyWidth * 0.8,
        padding: EdgeInsets.all(5.0),
        child: TextFormField(
          cursorColor: hexToColor(AppColors.whiteTextColor),
          controller: signUpController['pincode'],
          key: ValueKey('Pincode'),
          decoration: InputDecoration(
            labelText: 'Pincode',
            labelStyle: TextStyle(
              color: Colors.white60,
            ),
            hintText: 'Enter your pincode',
            hintStyle: TextStyle(
              color: Colors.white38,
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ),
          ),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: hexToColor(AppColors.whiteTextColor),
              fontSize: 17.0),
          validator: (value) =>
              (!RegExp(r'(^(?:[+0]9)?[0-9]{6}$)').hasMatch(value!) ||
                      value.length > 6)
                  ? 'Invalid pincode'
                  : null,
          keyboardType: TextInputType.phone,
          onSaved: (value) {
            print('$value');
            youth.pincode = value.toString();
          },
        ));
  }

  Container _buildEmailID(double bodyHeight, double bodyWidth) {
    return Container(
        //email
        height: bodyHeight * 0.1,
        width: bodyWidth * 0.8,
        padding: EdgeInsets.all(5.0),
        child: TextFormField(
          cursorColor: hexToColor(AppColors.whiteTextColor),
          controller: signUpController['email'],
          key: ValueKey('Email-Id'),
          decoration: InputDecoration(
            labelText: 'Email Id',
            labelStyle: TextStyle(
              color: Colors.white60,
            ),
            hintText: 'Enter your email address',
            hintStyle: TextStyle(
              color: Colors.white38,
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ),
          ),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: hexToColor(AppColors.whiteTextColor),
              fontSize: 17.0),
          keyboardType: TextInputType.emailAddress,
          validator: (value) => !EmailValidator.validate(value!, true)
              ? 'Invalid email id'
              : null,
          onSaved: (value) {
            print('$value');
            youth.emailid = value.toString();
          },
        ));
  }

  Container _buildMobileNumber(double bodyHeight, double bodyWidth) {
    return Container(
        // mobile
        height: bodyHeight * 0.1,
        width: bodyWidth * 0.8,
        padding: EdgeInsets.all(5.0),
        child: TextFormField(
          cursorColor: hexToColor(AppColors.whiteTextColor),
          controller: signUpController['mobile'],
          key: ValueKey('Mobile Number'),
          decoration: InputDecoration(
            labelText: 'Phone.No',
            labelStyle: TextStyle(
              color: Colors.white60,
            ),
            hintText: 'Enter your mobile number',
            prefixText: '+91',
            hintStyle: TextStyle(
              color: Colors.white38,
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ),
          ),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: hexToColor(AppColors.whiteTextColor),
              fontSize: 17.0),
          //         inputFormatters: <TextInputFormatter>[
          //   LengthLimitingTextInputFormatter(10),
          // ],
          validator: (value) =>
              (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(value!) ||
                      value.length == 0)
                  ? 'Invalid phone number'
                  : null,
          keyboardType: TextInputType.phone,
          onSaved: (value) {
            print('$value');
            youth.mobile1 = value.toString();
          },
        ));
  }

  Container _buildLastName(double bodyHeight, double bodyWidth) {
    return Container(
      // last name
      height: bodyHeight * 0.1,
      width: bodyWidth * 0.8,
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: hexToColor(AppColors.whiteTextColor),
        controller: signUpController['lastName'],
        onSaved: (name) {
          youth.lastName = name;
        },
        decoration: InputDecoration(
          labelText: 'Last Name',
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          hintText: 'Last Name',
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: hexToColor(AppColors.whiteTextColor),
            fontSize: 17.0),
        keyboardType: TextInputType.text,
        validator: (value) => value!.isEmpty
            ? 'Please enter your last name'
            : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value))
                ? 'Invalid name'
                : null,
      ),
    );
  }

  Container _buildMiddleName(double bodyHeight, double bodyWidth) {
    return Container(
      // middle Name
      height: bodyHeight * 0.1,
      width: bodyWidth * 0.8,
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: hexToColor(AppColors.whiteTextColor),
        controller: signUpController['middleName'],
        onSaved: (name) {
          youth.middleName = name;
        },
        decoration: InputDecoration(
          labelText: 'Middle Name',
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          hintText: 'Middle Name',
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: hexToColor(AppColors.whiteTextColor),
            fontSize: 17.0),
        keyboardType: TextInputType.text,
        validator: (value) => value!.isEmpty
            ? 'Please enter your middle name'
            : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value))
                ? 'Invalid name'
                : null,
      ),
    );
  }

  Container _buildFirstName(double bodyHeight, double bodyWidth) {
    return Container(
      // firstname
      height: bodyHeight * 0.1,
      width: bodyWidth * 0.8,
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: hexToColor(AppColors.whiteTextColor),
        controller: signUpController['firstName'],
        onSaved: (name) {
          youth.firstName = name;
        },
        decoration: InputDecoration(
          labelText: 'First Name',
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          hintText: 'First Name',
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: hexToColor(AppColors.whiteTextColor),
            fontSize: 17.0),
        keyboardType: TextInputType.text,
        validator: (value) => value!.isEmpty
            ? 'Please enter your name'
            : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value))
                ? 'Invalid name'
                : null,
      ),
    );
  }

  Container _buildAddressStreet(double bodyHeight, double bodyWidth) {
    return Container(
      // firstname
      height: bodyHeight * 0.1,
      width: bodyWidth * 0.8,
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: hexToColor(AppColors.whiteTextColor),
        controller: signUpController['street'],
        onSaved: (name) {
          youth.streetAddress = name;
        },
        decoration: InputDecoration(
          labelText: 'Street Address Locality',
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          hintText: 'Eg. 203-B, Lok Everest',
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: hexToColor(AppColors.whiteTextColor),
            fontSize: 17.0),
        keyboardType: TextInputType.text,
        validator: (value) => value!.isEmpty
            ? 'Please enter Your Locality'
            : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]').hasMatch(value))
                ? 'Invalid name'
                : null,
      ),
    );
  }

  Container _buildCityDistrict(double bodyHeight, double bodyWidth) {
    return Container(
      // firstname
      height: bodyHeight * 0.1,
      width: bodyWidth * 0.8,
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: hexToColor(AppColors.whiteTextColor),
        controller: signUpController['city'],
        onSaved: (name) {
          youth.streetAddress = name;
        },
        decoration: InputDecoration(
          labelText: 'City / District',
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          hintText: 'Eg. Bhandup, Mumbai',
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: hexToColor(AppColors.whiteTextColor),
            fontSize: 17.0),
        keyboardType: TextInputType.text,
        validator: (value) => value!.isEmpty
            ? 'Please enter Your City'
            : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]').hasMatch(value))
                ? 'Invalid name'
                : null,
      ),
    );
  }

  Container _buildState(double bodyHeight, double bodyWidth) {
    return Container(
      // firstname

      height: bodyHeight * 0.1,
      width: bodyWidth * 0.8,
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: hexToColor(AppColors.whiteTextColor),
        controller: signUpController['state'],
        onSaved: (name) {
          youth.streetAddress = name;
        },
        decoration: InputDecoration(
          labelText: 'State',
          labelStyle: TextStyle(
            color: Colors.white60,
          ),
          hintText: 'Eg. Delhi',
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white54,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: hexToColor(AppColors.whiteTextColor),
            fontSize: 17.0),
        keyboardType: TextInputType.text,
        validator: (value) => value!.isEmpty
            ? 'Please enter Your State'
            : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]').hasMatch(value))
                ? 'Invalid name'
                : null,
      ),
    );
  }
}
