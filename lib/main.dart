import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/model/weekly_forum_event.dart';
import 'package:mozak/screens/attendancePage.dart';
import 'package:mozak/screens/teamsPage.dart';
import 'package:mozak/screens/centerPage.dart';
import 'package:mozak/screens/home.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/screens/youthList.dart';
import 'package:mozak/screens/weekly_forum_event_page.dart';
import 'package:mozak/utils/app_tools.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLoading.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    return MaterialApp(
      theme: ThemeData(disabledColor: hexToColor(AppColors.grey)),
      debugShowCheckedModeBanner: false,
      //home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'Youths': (context) => YouthList(), //1
        //'Weekly Forum Events': (context) => WeeklyForumEventsPage(),
        'Centers': (context) => CenterPage(), //2
        'Groups': (context) => TeamsPage(), //3
        'Attendance': (context) => WeeklyForumEventsPage(), //4
        'Teams': (context) => TeamsPage(),
        'UserForm': (context) => UserForm(),
        //'AttendancePage': (context) => AttendancePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
