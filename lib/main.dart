import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/screens/SplashScreen.dart';
import 'package:mozak/screens/userform/UserForm.dart';
import 'package:mozak/utils/app_tools.dart';
import 'package:flutter_config/flutter_config.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("PrivateKey: ${FlutterConfig.get('PRIVATE_KEY')}");


    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return  MaterialApp(
      theme: ThemeData(
        disabledColor: hexToColor(AppColors.grey)
      ),
      debugShowCheckedModeBanner: false,
      home: const UserForm(),
    );
  }
}
