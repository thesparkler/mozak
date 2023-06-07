import 'package:flutter/material.dart';
import 'package:mozak/model/youth.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/utils/NoGlowBehaviour.dart';
import '../utils/youthData.dart';
import '../constants/AppColors.dart';
import '../utils/api_service.dart';
import '../utils/app_tools.dart';
class YouthList extends StatefulWidget {
  const YouthList({Key? key}) : super(key: key);

  @override
  State<YouthList> createState() => _YouthListState();
}

class _YouthListState extends State<YouthList> {
  String youthCode = "HK";
  int index = 0;

  List<String> groups = ['AB', 'BR', 'CR', 'DS', 'GK', 'HK', 'SK', 'SM', 'SY'];

  late List<Youth> youthList;
  // Future<List<Youth>> getYouthList() async {
  //   youthList = await ApiService().getAllYouths();
  //   return youthList;
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Youths',
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

    // final bodyHeight = mediaQuery.size.height -
    //     appBar.preferredSize.height -
    //     mediaQuery.padding.top -
    //     mediaQuery.padding.bottom;
    //
    // final bodyWidth = mediaQuery.size.width -
    //     mediaQuery.padding.left -
    //     mediaQuery.padding.right;

<<<<<<< HEAD
    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    return Scaffold(
      appBar: appBar,
      backgroundColor: hexToColor(AppColors.appThemeColor),

      body: Container(
          height: bodyHeight,
          width: bodyWidth,
          padding: EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
            return Column(
              children: [
                Container(
                    height: constraints.maxHeight * 0.2,
                    width: bodyWidth * 0.9,
                    child: DropdownButton<String>(
                      value: youthCode,
                      onChanged: (String? newValue) {
                        setState(() {
                          youthCode = newValue ?? youthCode;
                        });
                      },
                      items:
                          groups.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: value == youthCode
                                ? Text(
                                    value,
                                  )
                                : Text(
                                    value,
                                    style: TextStyle(
                                        color:
                                            hexToColor(AppColors.paleOrange)),
                                  ));
                      }).toList(),
                    )
                ),
                Container(
                  height: bodyHeight * 0.6,
                  width: bodyWidth * 0.9,
                  child: FutureBuilder<List<Youth>>(
                      future: getYouthList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Youth>> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          youthList = snapshot.data!;
                          return Container(
                            height: bodyHeight * 0.8,
                            width: bodyWidth * 0.9,
                            child: ListView(   
                                children: youthList
                                    .where((element) =>
                                        element.team!.substring(0, 2) ==
                                        '$youthCode')
                                    .map((e) => getYouthRow(e))
                                    .toList()),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                )
              ],
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add_alt_1),
        onPressed: () => {
          Navigator.of(context).pushNamed("new youth"),
        },
      )
=======
    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
          appBar: appBar,
          backgroundColor: hexToColor(AppColors.appThemeColor),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: DropdownButton<String>(
                            value: youthCode,
                            onChanged: (String? newValue) {
                              setState(() {
                                youthCode = newValue ?? youthCode;
                              });
                            },
                            items: groups
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: value == youthCode
                                    ? Text(
                                        value,
                                      )
                                    : Text(
                                        value,
                                        style: TextStyle(
                                            color: hexToColor(
                                                AppColors.paleOrange)),
                                      ),
                              );
                            }).toList(),
                          )),
                      FutureBuilder<List<Youth>>(
                          future: YouthData.instance.getYouthList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Youth>> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  '${snapshot.error} occurred',
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              youthList = snapshot.data!;
                              return ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: youthList
                                      .where((element) =>
                                          element.team!.substring(0, 2) ==
                                          '$youthCode')
                                      .map((e) => getYouthRow(e))
                                      .toList());
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 35),
                                child: Center(
                                  child: LinearProgressIndicator(
                                    color: hexToColor(AppColors.appThemeColor),
                                    backgroundColor:
                                        hexToColor(AppColors.whiteTextColor),
                                  ),
                                ),
                              );
                            }
                          })
                    ],
                  );
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.person_add_alt_1),
            onPressed: () => {
              Navigator.of(context).pushNamed("UserForm"),
            },
          )),
>>>>>>> AttendancePagesandStats
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getYouthRow(Youth e) {
    return InkWell(
      onTap: () => {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            context: context,
            backgroundColor: hexToColor(AppColors.appThemeColor),
            builder: (BuildContext context) {
              return Container(
                  padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Roll No: " + e.rollno.toString(),
                          softWrap: true,
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.whiteTextColor),
                          ),
                        ),
                        Text(
                          "Name: " + e.youthFullName.toString(),
                          softWrap: true,
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.whiteTextColor),
                          ),
                        ),
                        Text(
                          "EmailID: " + e.emailid.toString(),
                          softWrap: true,
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.whiteTextColor),
                          ),
                        ),
                        Text(
                          "DOB: " + e.dob.toString(),
                          softWrap: true,
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.whiteTextColor),
                          ),
                        ),
                        Text(
                          "Mobile No: " + e.mobile1.toString(),
                          softWrap: true,
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.whiteTextColor),
                          ),
                        ),
                        Text(
                          "Status: " + e.status.toString(),
                          softWrap: true,
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.whiteTextColor),
                          ),
                        ),
                        // Text('Email: ${e.emailid}'),
                        // Text('DOB: ${e.dob}'),
                        // Text('Mobile: ${e.mobile1}'),
                        // Text('Status: ${e.status}')
                      ],
                    );
                  }));
            }) //(event.center, DateTime.parse(event.date))
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 8, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            e.rollno + " " + e.youthFullName.toString(),
            softWrap: true,
            style: kGoogleStyleTexts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: hexToColor(AppColors.whiteTextColor),
            ),
          ),
        ),
      ),
    );
    // return SizedBox(
    //   height: 100,
    //   child: ListTile(
    //     onTap: () {
    //       showModalBottomSheet(
    //           shape: RoundedRectangleBorder(
    //               borderRadius:
    //                   BorderRadius.vertical(top: Radius.circular(20))),
    //           context: context,
    //           builder: (BuildContext context) {
    //             return Container(
    //                 height: MediaQuery.of(context).size.height * 0.5,
    //                 width: MediaQuery.of(context).size.width,
    //                 child: LayoutBuilder(builder: (context, constraints) {
    //                   return Column(
    //                     children: [
    //                       ListTile(
    //                         leading: Text(
    //                           "${e.rollno}",
    //                           style: TextStyle(color: Colors.white),
    //                         ),
    //                         title: Text("${e.youthFullName}",
    //                             style: TextStyle(color: Colors.white)),
    //                       ),
    //                       Text('Email: ${e.emailid}'),
    //                       Text('DOB: ${e.dob}'),
    //                       Text('Mobile: ${e.mobile1}'),
    //                       Text('Status: ${e.status}')
    //                     ],
    //                   );
    //                 }));
    //           });
    //     },
    //     leading: Text(
    //       "${e.rollno}",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     title:
    //         Text("${e.youthFullName}", style: TextStyle(color: Colors.white)),
    //   ),
    // );
  }
}
