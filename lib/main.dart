import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/screens/FormSuccessScreen.dart';
import 'package:mozak/screens/LoginScreen.dart';
import 'package:mozak/screens/SplashScreen.dart';
import 'package:mozak/screens/teamsPage.dart';
import 'package:mozak/screens/centerPage.dart';
import 'package:mozak/screens/home.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/screens/youthList.dart';
import 'package:mozak/screens/weekly_forum_event_page.dart';
import 'package:mozak/screens/youthRegistration.dart';
import 'package:mozak/utils/app_tools.dart';
import 'package:mozak/model/youth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    //..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white70
    ..backgroundColor = Colors.grey.shade100
    ..indicatorColor = Colors.white70
    ..textColor = Colors.white70
    //..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
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
        '/': (context) => SplashScreen(),
        'LoginPage': (context) => LoginPage(),
        'HomePage': (context) => HomePage(),
        'Youths': (context) => YouthList(), //1
        //'Weekly Forum Events': (context) => WeeklyForumEventsPage(),
        'Centers': (context) => CenterPage(), //2
        'Groups': (context) => TeamsPage(), //3
        'Weekly Forum Event': (context) => WeeklyForumEventsPage(), //4
        'Teams': (context) => TeamsPage(),
        'UserForm': (context) => UserForm(),
        'new youth': (context) => YouthRegistration(),
        'updateYouth': (context) => YouthRegistration(),
        'FormSuccessScreen': (context) => FormSuccessScreen(),

        //'AttendancePage': (context) => AttendancePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
