import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/generateQPCR/childPartRejQPCR.dart';
import 'package:rane_dms/screens/QPCR/generateQPCR/processRejQPCR.dart';

class QPCRGenerateChoiceScreen extends StatefulWidget {
  @override
  _QPCRGenerateChoiceScreenState createState() =>
      _QPCRGenerateChoiceScreenState();
}

class _QPCRGenerateChoiceScreenState extends State<QPCRGenerateChoiceScreen> {
  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: screenSize.screenWidth * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.screenWidth * 5),
              child: Image.asset(
                'images/logo.png',
                width: screenSize.screenWidth * 100,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: screenSize.screenHeight * 10,
            ),
            ReusableButton(
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProcessRejQPCRScreen()));
                },
                content: "Regarding Process Rejection",
                height: screenSize.screenHeight * 10,
                width: screenSize.screenWidth * 50),
            SizedBox(
              height: screenSize.screenHeight * 10,
            ),
            ReusableButton(
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChildPartRejQPCRScreen()));
                },
                content: "Regarding Child Part Rejection",
                height: screenSize.screenHeight * 10,
                width: screenSize.screenWidth * 50),
          ],
        ),
      ),
    );
  }
}
