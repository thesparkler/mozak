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
    return 
      
      Column(
        children: [
          TextButton(onPressed: () => addCenter("Ghatkopar"), child: Text("Add a new center")),
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
                    children: centerList.map((e) => getCenterRow(e.location)).toList(),
                  );
                }
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        ],
      );
  }

  Widget getCenterRow(String name) {
    index++;
    return Row(
      children: [Container(child: Text(index.toString())), Container(child: Text(name))],
    );
  }
}
