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

  @override
  void initState() {
    var obj = ApiService().getCenters();
    obj.then((value) => {
      for(var o in value){
        print(o.toString())
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
