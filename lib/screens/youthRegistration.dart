import 'package:flutter/material.dart';
import '../constants/AppColors.dart';
import '../utils/api_service.dart';
import '../utils/app_tools.dart';
import 'package:email_validator/email_validator.dart';

class YouthRegistration extends StatefulWidget {
  const YouthRegistration({Key? key}) : super(key: key);

  @override
  State<YouthRegistration> createState() => _YouthRegistrationState();
}

class _YouthRegistrationState extends State<YouthRegistration> {

  
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
            child: LayoutBuilder(
              builder: (context,constraint)
              {
                return Column(
                  children: [
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxWidth *0.8,
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter Full Name',
                          border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) => value!.isEmpty
                          ? 'Please enter your name'
                          : (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(value))
                              ? 'Invalid name'
                              : null,
                      ),
                    ),
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxWidth *0.8,
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        key: ValueKey('Mobile Number'),
                        decoration: InputDecoration(
                          labelText: 'Phone.No',
                          hintText: 'Enter your mobile number',
                          prefixText: '+91',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => 
                          (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(value!) || value.length == 0)
                          ? 'Invalid phone number'
                          : null,
                        keyboardType: TextInputType.phone,
                      )
                    ),
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxWidth *0.8,
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        key: ValueKey('Email-Id'),
                        decoration: InputDecoration(
                          labelText: 'Email Id',
                          hintText: 'Enter your email address',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => !EmailValidator.validate(value!, true)
                            ? 'Invalid email id'
                            : null,
                      )
                    ),
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxWidth *0.8,
                      padding: EdgeInsets.all(5.0),
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                      
                    ),
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxWidth *0.8,
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder())
                      ),
                    )
                  ],
                );
              },)
          ),
        ),
      ),
    );
  }
}
 