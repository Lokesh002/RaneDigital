import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/documentScreens/deptHome.dart';

class DocumentMainScreen extends StatefulWidget {
  @override
  _DocumentMainScreenState createState() => _DocumentMainScreenState();
}

class _DocumentMainScreenState extends State<DocumentMainScreen> {
  SizeConfig screenSize;
  Widget getIcon(String photo, String dept, var department) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          //Here DecodedData is a locally saved variable containing selected course data
          return department;
        }));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.screenHeight * 2,
            vertical: screenSize.screenHeight * 1),
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/$photo.png",
              width: screenSize.screenWidth * 25,
              height: screenSize.screenHeight * 15,
            ),
            Text(
              dept,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: screenSize.screenHeight * 3),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                  child: Image.asset(
                "images/logo.png",
                width: screenSize.screenWidth * 80,
                height: screenSize.screenHeight * 30,
              )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenSize.screenHeight * 20),
                  child: Text(
                    "Data Retrieval System",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.screenHeight * 2),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenSize.screenHeight * 2,
                    horizontal: screenSize.screenWidth * 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        getIcon("MED", "MED", DeptHome("MED")),
                        getIcon("PLE", "PLE", DeptHome("PLE")),
                        getIcon("MFG", "MFG", DeptHome("MFG")),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        getIcon("PPC", "PPC", DeptHome("PPC")),
                        getIcon("QAD", "QAD", DeptHome("QAD")),
                        getIcon("Store", "Store", DeptHome("Store")),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
