import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/screens/LoginScreen.dart';
import 'package:mozak/screens/SplashScreen.dart';
import 'package:mozak/screens/attendance_page.dart';
import 'package:mozak/screens/event_attendance.dart';
import 'package:mozak/screens/teams_page.dart';
import 'package:mozak/screens/center_page.dart';
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
        'Youths': (context) => YouthList(),
        'Weekly Forum Events': (context) => WeeklyForumEventsPage(),
        'Centers': (context) => CenterPage(),
        'Groups': (context) => HomePage(),
        'Attendance': (context) => AttendancePage(),
        'Teams': (context) => TeamsPage(),
        'UserForm': (context) => UserForm(),
        'AttendancePage': (context) => AttendancePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
