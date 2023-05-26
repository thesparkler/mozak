import 'package:flutter/material.dart';
import 'package:mozak/model/youth.dart';
import 'package:mozak/screens/userform/UserForm.dart';

import '../utils/api_service.dart';

class YouthList extends StatefulWidget {
  const YouthList({Key? key}) : super(key: key);

  @override
  State<YouthList> createState() => _YouthListState();
}

class _YouthListState extends State<YouthList> {
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late List<Youth> youthList;
  Future<List<Youth>> getYouthList() {
    var obj = ApiService().getAllYouths();
    return obj.then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    index = 0;

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
      body: Container(
          child: Column(
        children: [
          TextButton(
              onPressed: () => {
                    Navigator.of(context).pushNamed("UserForm"),
                  },
              child: Text("Add a new Youth")),
          FutureBuilder<List<Youth>>(
              future: getYouthList(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Youth>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
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
                          .toList(),
                    );
                  }
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      )),
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
    return Row(
      children: [
        Container(child: Text(index.toString())),
        Container(child: Text(" $name"))
      ],
    );
  }
}
