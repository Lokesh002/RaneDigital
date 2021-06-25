import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:rane_dms/screens/QPCR/QPCRMainScreen.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeQPCRScreen.dart';
import 'package:rane_dms/screens/QPCR/generateQPCR/QPCRGenerateChoiceScreen.dart';
import 'package:rane_dms/screens/QPCR/generateQPCR/processRejQPCR.dart';
import 'package:rane_dms/screens/QPCR/viewQPCR/enterQPCRFilterDataScreen.dart';
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
import 'package:provider/provider.dart';
import 'dart:ui';

const debug = true;

void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await FlutterDownloader.initialize(debug: debug);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Rane Digital',
      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Color(0xffe0e0e0),
          backgroundColor: Colors.white),
      initialRoute: '/',
      themeMode: ThemeMode.light,
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashScreen(),
        // '/documentMainScreen': (context) => DocumentMainScreen(),
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
        // '/updateAppScreen': (context) => UpdateAppScreen(),
        // '/QPCRMainScreen': (context) => QPCRMainScreen(),
        // '/generateQPCRScreen': (context) => QPCRGenerateChoiceScreen(),
        // '/viewQPCRScreen': (context) => EnterQPCRFilterDataScreen(),
        // '/closeQPCRScreen': (context) => CloseQPCRScreen(),
      },
    );
  }
}
