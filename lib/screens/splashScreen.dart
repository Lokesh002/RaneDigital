import 'package:flutter/material.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //SavedData savedData = SavedData();

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      Networking networking = Networking();
      var updatedAppVersion = await networking.deleteData('updateDesktopApp');
      print(updatedAppVersion);
      if (updatedAppVersion == desktopVersion) {
        if (await SavedData.getLoggedIn()) {
          Navigator.pushReplacementNamed(context, '/homeScreen');
        } else {
          Navigator.pushReplacementNamed(context, '/loginScreen');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/updateAppScreen');
      }
    });
  }

  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Container(
            width: screenSize.screenWidth * 100,
            height: screenSize.screenHeight * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.screenWidth * 100,
                  height: screenSize.screenHeight * 70,
                  child:
                      Hero(tag: "logo", child: Image.asset("images/logo.png")),
                ),
                Text('Made By: Lokesh Joshi')
              ],
            ),
          ),
        ));
  }
}
