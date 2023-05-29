import 'package:flutter/material.dart';
import 'package:mozak/model/youth.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import '../constants/AppColors.dart';
import '../utils/api_service.dart';
import '../utils/app_tools.dart';

class YouthList extends StatefulWidget {
  const YouthList({Key? key}) : super(key: key);

  @override
  State<YouthList> createState() => _YouthListState();
}

class _YouthListState extends State<YouthList> {
  int index = 0;

  late List<Youth> youthList;
  Future<List<Youth>> getYouthList() async {
    List<Youth> obj = await ApiService().getAllYouths();
    return obj;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    index = 0;

    final mediaQuery = MediaQuery.of(context);

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

    final bodyHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final bodyWidth = mediaQuery.size.width -
        mediaQuery.padding.left -
        mediaQuery.padding.right;

    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: true,
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Column(
        children: [
          Container(
            height: bodyHeight / 18,
            width: bodyWidth / 2,
            decoration: BoxDecoration(
                color: hexToColor(AppColors.paleOrange),
                backgroundBlendMode: BlendMode.lighten,
                border: Border.all(
                  color: hexToColor(AppColors.paleOrange),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: TextButton(
              onPressed: () => {
                Navigator.of(context).pushNamed("UserForm"),
              },
              child: Text(
                "Add a new Youth",
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: hexToColor(AppColors.whiteTextColor),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10, left: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("All Centers",
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.whiteTextColor),
                  )),
            ),
          ),
          FutureBuilder<List<Youth>>(
              future: getYouthList(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Youth>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  youthList = snapshot.data!;
                  return Column(
                      children: youthList
                          .map((e) => getYouthRow(e.youthFullName!))
                          .toList());
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    index = 0;
    super.dispose();
  }

  Widget getYouthRow(String name) {
    index++;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 8),
      child: Row(
        children: [
          Container(
              child: Text(index.toString(),
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.whiteTextColor),
                  ))),
          Container(
              child: Text(" $name",
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.whiteTextColor),
                  )))
        ],
      ),
    );
  }
}
