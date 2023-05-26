import 'package:flutter/material.dart';
import 'package:mozak/utils/api_service.dart';
import 'package:mozak/model/center.dart' as center;

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
      title: Text('Centres'),
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
      body: Column(
        children: [
          TextButton(
              onPressed: openCreateCenterPage, child: Text("Add a new center")),
          showCreateCenterCard
              ? Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.greenAccent[100],
                  child: Form(
                      child: Column(
                    children: [
                      TextField(controller: locationController),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                closeCreateCenterPage();
                              },
                              child: Text("Cancel")),
                          ElevatedButton(
                              onPressed: () async {
                                addCenter(locationController.text.toString());
                                closeCreateCenterPage();
                              },
                              child: Text("SAVE")),
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
