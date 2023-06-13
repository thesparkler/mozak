import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mozak/model/youth.dart';
import 'package:mozak/utils/youthData.dart';
import '../constants/AppColors.dart';
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

  //var youth = Youth(rollno: '', youthFullName: '');
  // late Youth youth;
  String youthCode = group.values.first;
  String dropdownValue = group.keys.first;
  bool isNew = false;

  var dropdownValue1;
  var currentList = <Youth>[];

  DateTime? pickedDate;
  var datecontroller = TextEditingController(text: "");
  var date;
  var selected;

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> sigUpController = {
    'firstName': TextEditingController(),
    'middleName': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'mobile': TextEditingController(),
    'pincode': TextEditingController(),
    'address': TextEditingController(),
    'team': TextEditingController(),
    'tlcode': TextEditingController(),
  };

  @override
  void initState() {
    currentList = YouthData.instance.youthList.where((element) => element.isTL).toList();
    dropdownValue1=currentList[0];
    super.initState();
  }

  void pickDate(BuildContext context) async {
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
        date = datecontroller.text = formatter.format(selected);
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
      var response = await ApiService().setYouth(youth);
      YouthData.instance.youthList = [];
      Navigator.of(context).pop();
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(
        'New Youth',
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

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: bodyHeight,
          width: bodyWidth,
          padding: EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Column(
                    children: [
                      Container( // firstname

                        height: constraint.maxHeight * 0.1,
                        width: constraint.maxWidth * 0.8,
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: sigUpController['firstName'],
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              hintText: 'First Name',
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.text,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your name'
                              : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                      .hasMatch(value))
                                  ? 'Invalid name'
                                  : null,

                        ),
                      ),
                      Container( // middle Name
                        height: constraint.maxHeight * 0.1,
                        width: constraint.maxWidth * 0.8,
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: sigUpController['middleName'],
                          decoration: InputDecoration(
                              labelText: 'Middle Name',
                              hintText: 'Middle Name',
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.text,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your middle name'
                              : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value))
                              ? 'Invalid name'
                              : null,

                        ),
                      ),
                      Container(
                        height: constraint.maxHeight * 0.1,
                        width: constraint.maxWidth * 0.8,
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: sigUpController['lastName'],
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              hintText: 'Last Name',
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.text,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your last name'
                              : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value))
                              ? 'Invalid name'
                              : null,

                        ),
                      ),
                      Container(
                          height: constraint.maxHeight * 0.1,
                          width: constraint.maxWidth * 0.8,
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: sigUpController['mobile'],
                            key: ValueKey('Mobile Number'),
                            decoration: InputDecoration(
                              labelText: 'Phone.No',
                              hintText: 'Enter your mobile number',
                              prefixText: '+91',
                              border: OutlineInputBorder(),
                            ),
                            //         inputFormatters: <TextInputFormatter>[
                            //   LengthLimitingTextInputFormatter(10),
                            // ],
                            validator: (value) =>
                                (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                                            .hasMatch(value!) ||
                                        value.length == 0)
                                    ? 'Invalid phone number'
                                    : null,
                            keyboardType: TextInputType.phone,
                            onSaved: (value) {
                              print('$value');
                              youth.mobile1 = value.toString();
                            },
                          )),
                      Container(
                          height: constraint.maxHeight * 0.1,
                          width: constraint.maxWidth * 0.8,
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: sigUpController['email'],
                            key: ValueKey('Email-Id'),
                            decoration: InputDecoration(
                              labelText: 'Email Id',
                              hintText: 'Enter your email address',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                !EmailValidator.validate(value!, true)
                                    ? 'Invalid email id'
                                    : null,
                            onSaved: (value) {
                              print('$value');
                              youth.emailid = value.toString();
                            },
                          )),
                      Container(
                          height: constraint.maxHeight * 0.1,
                          width: constraint.maxWidth * 0.8,
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: sigUpController['pincode'],
                            key: ValueKey('Pincode'),
                            decoration: InputDecoration(
                              labelText: 'Pincode',
                              hintText: 'Enter your pincode',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                (!RegExp(r'(^(?:[+0]9)?[0-9]{6}$)')
                                            .hasMatch(value!) ||
                                        value.length > 6)
                                    ? 'Invalid pincode'
                                    : null,
                            keyboardType: TextInputType.phone,
                            onSaved: (value) {
                              print('$value');
                              youth.pincode = value.toString();
                            },
                          )),
                      Container( //DOB container
                        height: constraint.maxHeight * 0.1,
                        width: constraint.maxWidth * 0.8,
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: datecontroller,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_month),
                            labelText: 'DOB',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value != null ? null : 'Please select DOB',
                          readOnly: true,
                          onTap: () => pickDate(context),
                          onSaved: (value) {
                            print('$value');
                            youth.dob = value.toString();
                          },
                        ),
                      ),
                      Container( //isTL container
                          height: constraint.maxHeight * 0.09,
                          width: constraint.maxWidth * 0.8,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: hexToColor(
                                  AppColors.textFieldOutlineBorderColor),
                              width: 1.0,
                            ),
                          ),
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: dropdownValue,
                            icon: SizedBox.shrink(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                                currentList = YouthData.instance.youthList
                                    .where((element) => element.isTL)
                                    .toList();

                                dropdownValue1 = currentList[0];
                                // print('$dropdownValue');
                              });
                            },
                            items: group.keys
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),

                    Container(
                      height: constraint.maxHeight * 0.09,
                      width: constraint.maxWidth *0.8,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: hexToColor(AppColors.textFieldOutlineBorderColor),
                          width: 1.0,
                        ),
                      ),
                      child:DropdownButton<Youth>(
                        isExpanded: true,
                        underline: SizedBox(), 
                        value: dropdownValue1,
                        icon: SizedBox.shrink(),
                        onChanged: (Youth? value) {
                          setState(() {
                            dropdownValue1 = value!;
                            print('${dropdownValue1.rollno.toString()}');
                            youth.tlCode = dropdownValue1.rollno.toString();
                            youth.team = dropdownValue1.rollno.substring(0,4);
                            // youth.rollno= youth.team.toString()+"0A";
                          });
                        },
                        items: currentList.map<DropdownMenuItem<Youth>>((Youth value) {
                          return DropdownMenuItem<Youth>(
                            value: value,
                            child: Text(value.rollno!+" "+value.youthFullName,softWrap: true,overflow: TextOverflow.fade,),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      height: constraint.maxHeight * 0.09,
                      width: constraint.maxWidth *0.8,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: hexToColor(AppColors.textFieldOutlineBorderColor),
                          width: 1.0,
                        )
                      ),
                      child: RadioListTile<bool>(
                        toggleable: true,
                        value: true,
                        title: Text('Create Temporary Rollno'), 
                        groupValue: isNew, 
                        onChanged: (value)
                        {
                          setState(() {
                            isNew = !isNew;
                            print('.................$isNew');
                          });
                        }
                      ),
                      ),
                      ElevatedButton(
                          onPressed: () => _trySubmit(context),
                          child: Text('Submit'))
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
