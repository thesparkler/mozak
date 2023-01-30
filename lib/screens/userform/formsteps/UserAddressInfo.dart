import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/constants/AppStrings.dart';
import 'package:mozak/model/UserFormModel.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import 'package:mozak/utils/app_tools.dart';

class UserAddressInfo extends StatefulWidget {
  final UserFormModel model;

  final next;

  const UserAddressInfo(this.model, this.next, {Key? key}) : super(key: key);

  @override
  State<UserAddressInfo> createState() => _UserAddressInfoState();
}

class _UserAddressInfoState extends State<UserAddressInfo> {
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  var n;
  // String? selectedState;
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

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    dropdownValue = widget.model.getState();
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
                    const EdgeInsets.only(left: 18.0, top: 15.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.addressTitleText,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: hexToColor(AppColors.whiteTextColor),
                        fontSize: 22.0,
                        height: 1.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 28.0, bottom: 18.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildStreetAddressField(),
                        _buildCityField(),
                        //   _buildStateField(),
                        _stateDropDownField(),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreetAddressField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.addressFieldText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        SizedBox(
          height: maxLines * 60.0,
          child: TextFormField(
              onChanged: (val) {
                widget.model.setStreetAddress(val);
              },
              textInputAction: TextInputAction.next,
              initialValue: widget.model.getStreetAddress(),
              keyboardType: TextInputType.text,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 17.0),
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: hexToColor(AppColors.textFieldOutlineBorderColor)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: hexToColor(AppColors.paleOrange))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color:
                            hexToColor(AppColors.textFieldOutlineBorderColor))),
                hintText: AppStrings.addressFieldHintText,
                hintStyle: TextStyle(
                    fontSize: 15, color: hexToColor(AppColors.hintTextColor)),
              )),
        ),
      ],
    );
  }

  Widget _buildCityField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.cityFieldText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 15.0),
            ),
          ),
        ),
        SizedBox(
          height: maxLines * 40.0,
          child: TextFormField(
              onChanged: (val) {
                widget.model.setCity(val);
              },
              onEditingComplete: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              initialValue: widget.model.getCity(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: hexToColor(AppColors.whiteTextColor),
                  fontSize: 17.0),
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: hexToColor(AppColors.textFieldOutlineBorderColor)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: hexToColor(AppColors.paleOrange))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        color:
                            hexToColor(AppColors.textFieldOutlineBorderColor))),
                hintText: AppStrings.cityFieldHintText,
                hintStyle: TextStyle(
                    fontSize: 15, color: hexToColor(AppColors.hintTextColor)),
              )),
        ),
      ],
    );
  }

  Widget _stateDropDownField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.stateFieldText,
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
          ),
        ),
      ],
    );
  }
}
