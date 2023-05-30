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

  String youthCode = "HK";

  List<String> groups = ['HK', 'SY', 'BR', 'CR', 'AB','GK','SK'];

  // List<DropdownMenuItem> dropDown() {
  //   List<DropdownMenuItem<dynamic>> dropDownItems = [];

  //   for (int i = 0; i < groups.length; i++) {
  //     String grp = groups[i];
  //     var newItem = DropdownMenuItem(
  //       child: Text(grp),
  //       value: grp,
  //     );
  //     // add to the list of menu item
  //     dropDownItems.add(newItem);
  //   }
  //   return dropDownItems.map((e) => null);
  // }

  late List<Youth> youthList;
  Future<List<Youth>> getYouthList() async {
    List<Youth> obj = await ApiService().getAllYouths();
    return obj;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text('Youth Data'),
      centerTitle: true,
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
      backgroundColor: hexToColor(AppColors.appThemeColor),
      body: Container(
          height: bodyHeight,
          width: bodyWidth,
          padding: EdgeInsets.all(8.0),
          child: LayoutBuilder(builder: (context, constraints) {
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
                                    style: const TextStyle(color: Colors.white),
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
                  height: bodyHeight * 0.7,
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
                                        element.team!.substring(0, 2) == '$youthCode')
                                    .map((e) => getYouthRow(
                                        e.rollno!, e.youthFullName!))
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
          })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add_alt_1),
        onPressed: () => {
          Navigator.of(context).pushNamed("UserForm"),
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    index = 0;
    super.dispose();
  }

  Widget getYouthRow(String rollno, String name) {
    return ListTile(
      leading: Text(
        "$rollno",
        style: TextStyle(color: Colors.white),
      ),
      title: Text("$name", style: TextStyle(color: Colors.white)),
    );
  }
}
