import 'package:flutter/material.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/model/center.dart' as center;

import '../constants/AppColors.dart';
import '../utils/app_tools.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({Key? key}) : super(key: key);

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  late List<center.Center> centerList;

  int index = 0;
  bool showCreateCenterCard = false;
  TextEditingController locationController = new TextEditingController();

  void openCreateCenterPage() {
    showCreateCenterCard = true;

    setState(() {});
  }

  void closeCreateCenterPage() {
    print("hii");
    setState(() {
      showCreateCenterCard = false;
    });
  }

  void addCenter(String location) {
    ApiService().setCenter(location);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<center.Center>> getCenterList() {
    var obj = ApiService().getCenters();
    return obj.then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    index = 0;
    final appBar = AppBar(
      title: Text(
        'Centres',
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
          TextButton(
              onPressed: openCreateCenterPage, child: Text("Add a new center")),
          showCreateCenterCard
              ? Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: hexToColor(AppColors.paleOrange),
                  child: Form(
                      child: Column(
                    children: [
                      TextField(controller: locationController),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () async {
                                closeCreateCenterPage();
                              },
                              child: Text("Cancel",style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: hexToColor(AppColors.whiteTextColor),))),
                          TextButton(
                              onPressed: () async {
                                addCenter(locationController.text.toString());
                                closeCreateCenterPage();
                              },
                              child: Text("Save",
                                  style: kGoogleStyleTexts.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: hexToColor(AppColors.whiteTextColor),))),
                        ],
                      )
                    ],
                  )))
              : SizedBox(
                  height: 5,
                ),
          FutureBuilder<List<center.Center>>(
              future: getCenterList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<center.Center>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    centerList = snapshot.data!;
                    return Column(
                      children: centerList
                          .map((e) => getCenterRow(e.location))
                          .toList(),
                    );
                  }
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
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

  Widget getCenterRow(String name) {
    index++;
    return Row(
      children: [
        Container(child: Text(index.toString())),
        Container(child: Text(" $name"))
      ],
    );
  }
}
