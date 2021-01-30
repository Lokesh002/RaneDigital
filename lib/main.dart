import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:rane_dms/screens/authentication/adminPasswordScreen.dart';
import 'package:rane_dms/screens/authentication/loginScreen.dart';
import 'package:rane_dms/screens/authentication/registerUserScreen.dart';
import 'package:rane_dms/screens/pfu/closePfu/closePFUScreen.dart';
import 'package:rane_dms/screens/pfu/generatePfu/addLineAndMachine/addLineScreen.dart';
import 'package:rane_dms/screens/pfu/generatePfu/addLineAndMachine/addMachineScreen.dart';
import 'package:rane_dms/screens/pfu/generatePfu/generatePFUScreen.dart';
import 'package:rane_dms/screens/pfu/pfuMainScreen.dart';
import 'package:rane_dms/screens/pfu/viewPfu/enterFilterDataScreen.dart';
import 'package:rane_dms/screens/profile/newPasswordScreen.dart';
import 'package:rane_dms/screens/profile/profileScreen.dart';
import 'package:rane_dms/screens/splashScreen.dart';
import 'package:rane_dms/screens/documentMainScreen.dart';
import 'package:rane_dms/screens/homeScreen.dart';
import 'package:rane_dms/screens/updateAppScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  getColr() {
//    themes.getColor();
//  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // getColr();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
//          primaryColor: primaryColor,
//          accentColor: accentColor,
          primaryColor: Colors.blue,
          accentColor: Color(0xffe0e0e0),
          backgroundColor: Colors.white),
      initialRoute: '/',
      themeMode: ThemeMode.light,
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashScreen(),
        '/documentMainScreen': (context) => DocumentMainScreen(),
        '/homeScreen': (context) => HomeScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/adminPasswordScreen': (context) => AdminPasswordScreen(),
        '/registerUserScreen': (context) => RegisterUserScreen(),
        '/profileScreen': (context) => ProfileScreen(),
        '/pfuMainScreen': (context) => PFUMainScreen(),
        '/generatePFUScreen': (context) => GeneratePFUScreen(),
        '/viewPFUScreen': (context) => EnterFilterDataScreen(),
        '/closePFUScreen': (context) => ClosePFUScreen(),
        '/addLineScreen': (context) => AddLineScreen(),
        '/changePassword': (context) => ChangePassword(),
        '/updateAppScreen': (context) => UpdateAppScreen()
      },
    );
  }
}
