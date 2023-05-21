import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/screens/LoginScreen.dart';
import 'package:mozak/screens/SplashScreen.dart';
import 'package:mozak/screens/home.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/screens/weekly_forum_events_page.dart';
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

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      theme: ThemeData(disabledColor: hexToColor(AppColors.grey)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => HomePage(),
        'Youth list':(context) => HomePage(),
        'Weekly Forum Events': (context) => WeeklyForumEventsPage(),
        'Add Center':(context) => HomePage(),
        'Add Group':(context) => HomePage(),
        'Take Attendance':(context) => HomePage(),
        'Add Team':(context) => HomePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
