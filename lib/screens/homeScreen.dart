import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/ReusableCard.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

SavedData savedData = SavedData();

class _HomeScreenState extends State<HomeScreen> {
  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
            padding: EdgeInsets.only(top: screenSize.screenHeight * 5),
            child: Container(
              width: screenSize.screenWidth * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          width: screenSize.screenWidth * 100,
                          height: screenSize.screenHeight * 30,
                          child: Image.asset(
                            "images/logo.png",
                            height: screenSize.screenHeight * 30,
                            width: screenSize.screenWidth * 80,
                          )),
                      Container(
                        height: screenSize.screenHeight * 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/profileScreen');
                          },
                          iconSize: screenSize.screenHeight * 10,

                          icon: CircleAvatar(
                              backgroundColor: Theme.of(context).accentColor,
                              radius: screenSize.screenHeight * 4,
                              child: Icon(
                                Icons.account_box,
                                size: screenSize.screenHeight * 5,
                                color: Theme.of(context).primaryColor,
                              )), // Icon
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.screenHeight * 5),
                  ReusableButton(
                    onPress: () {
                      Navigator.pushNamed(context, '/documentMainScreen');
                    },
                    height: screenSize.screenHeight * 10,
                    width: screenSize.screenWidth * 80,
                    content: "Documents",
                  ),
                  SizedBox(height: screenSize.screenHeight * 5),
                  ReusableButton(
                    onPress: () {
                      Navigator.pushNamed(context, '/pfuMainScreen');
                    },
                    height: screenSize.screenHeight * 10,
                    width: screenSize.screenWidth * 80,
                    content: "PFU",
                  ),
                  SizedBox(height: screenSize.screenHeight * 5),
                  ReusableButton(
                    onPress: () async {
                      Fluttertoast.showToast(
                          msg: "This page is under construction.");
                    },
                    height: screenSize.screenHeight * 10,
                    width: screenSize.screenWidth * 80,
                    content: "4M Change",
                  ),
                ],
              ),
            )),
      ),
    );
  }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press back again to exit!");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
