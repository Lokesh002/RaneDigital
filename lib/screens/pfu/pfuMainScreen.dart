import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class PFUMainScreen extends StatefulWidget {
  @override
  _PFUMainScreenState createState() => _PFUMainScreenState();
}

SavedData savedData = SavedData();

class _PFUMainScreenState extends State<PFUMainScreen> {
  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.screenHeight * 5),
          child: Text("PFU"),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.screenHeight * 10),
          child: Container(
            width: screenSize.screenWidth * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/generatePFUScreen');
                  },
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "Generate PFU",
                ),
                SizedBox(height: screenSize.screenHeight * 5),
                ReusableButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/viewPFUScreen');
                  },
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "View PFU",
                ),
                SizedBox(height: screenSize.screenHeight * 5),
                ReusableButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/closePFUScreen');
                  },
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "Close PFU",
                )
              ],
            ),
          )),
    );
  }
}
