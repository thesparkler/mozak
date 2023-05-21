import 'package:flutter/material.dart';
import 'package:mozak/utils/api_service.dart';

import '../model/weekly_forum_event.dart';


class WeeklyForumEventsPage extends StatefulWidget {
  const WeeklyForumEventsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyForumEventsPage> createState() => _WeeklyForumEventsPageState();
}

class _WeeklyForumEventsPageState extends State<WeeklyForumEventsPage> {

  @override
  initState() {
    Future<List<WeeklyForumEvent>> list = ApiService().getWFEvents();

     print(list.then((value) => {
       for(var ob in value){
         print(ob)
       }
     }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
