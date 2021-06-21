import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableBorderButton.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/FTA/LinelistScreen.dart';
import 'package:rane_dms/screens/pms/pmsMainScreen.dart';

import 'profile/profileScreen.dart';

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
        body: Container(
          width: screenSize.screenWidth * 100,
          height: screenSize.screenHeight * 100,
          child: ListView(
            children: [
              Padding(
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
                              child: PopupMenuButton(
                                  itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    value: 'Profile',
                                    child: Text('Profile'),
                                  ),
                                ];
                              }, onSelected: (value) {
                                if (value == 'Profile') {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProfileScreen();
                                  }));
                                }
                              }),
                            )
                          ],
                        ),
                        SizedBox(height: screenSize.screenHeight * 5),
                        ReusableBorderButton(
                          onPress: () {
                            Navigator.pushNamed(context, '/documentMainScreen');
                          },
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 80,
                          content: "DRS",
                        ),
                        SizedBox(height: screenSize.screenHeight * 5),
                        ReusableBorderButton(
                          onPress: () {
                            Navigator.pushNamed(context, '/pfuMainScreen');
                          },
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 80,
                          content: "PFU",
                        ),
                        SizedBox(height: screenSize.screenHeight * 5),
                        ReusableBorderButton(
                          onPress: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              //Here DecodedData is a locally saved variable containing selected course data
                              return FTALineListScreen();
                            }));
                          },
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 80,
                          content: "FTA",
                        ),
                        SizedBox(height: screenSize.screenHeight * 5),
                        ReusableBorderButton(
                          onPress: () async {
                            Fluttertoast.showToast(
                                msg: "This page is under construction.");
                            // Navigator.pushNamed(context, '/QPCRMainScreen');
                          },
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 80,
                          content: "QPCR",
                        ),
                        SizedBox(height: screenSize.screenHeight * 5),
                        ReusableBorderButton(
                          onPress: () async {
                            Fluttertoast.showToast(
                                msg: "This page is under construction.");
                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //   //Here DecodedData is a locally saved variable containing selected course data
                            //   return PMSMainScreen();
                            // }));
                          },
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 80,
                          content: "PMS",
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
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
