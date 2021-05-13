import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableCard.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/icon_content.dart';
import 'package:rane_dms/components/networking.dart';

import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/documentScreens/deptHome.dart';
import 'package:rane_dms/screens/homeScreen.dart';

class DocumentMainScreen extends StatefulWidget {
  @override
  _DocumentMainScreenState createState() => _DocumentMainScreenState();
}

class _DocumentMainScreenState extends State<DocumentMainScreen> {
  SizeConfig screenSize;
  bool allowed;
  String myDept;
  Widget getIcon(String photo, String dept, var department) {
    return GestureDetector(
      onTap: () {
        if (allowed != null) {
          if (allowed) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //Here DecodedData is a locally saved variable containing selected course data
              return department;
            }));
          } else {
            if (myDept == dept) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                //Here DecodedData is a locally saved variable containing selected course data
                return department;
              }));
            } else {
              Fluttertoast.showToast(msg: "You cannot access this department.");
            }
          }
        } else {
          Fluttertoast.showToast(msg: "ERROR! Not able to connect to Server.");
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.screenWidth * 2,
            vertical: screenSize.screenHeight * 1),
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/$photo.png",
              width: screenSize.screenWidth * 15,
              height: screenSize.screenHeight * 10,
            ),
            Text(
              dept,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: screenSize.screenHeight * 2.5),
            ),
          ],
        ),
      ),
    );
  }

  getSecurity() async {
    Networking networking = Networking();
    var allowed = await networking.getData('securityForDRS');
    print(allowed);
    this.allowed = allowed['allowed'];

    myDept = await savedData.getDepartment();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSecurity();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                  child: Image.asset(
                "images/logo.png",
                width: screenSize.screenWidth * 80,
                height: screenSize.screenHeight * 25,
              )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenSize.screenHeight * 20),
                  child: Text(
                    "Data Retrieval System",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.screenHeight * 3,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          // Column(
          //   children: <Widget>[
          //     Padding(
          //         padding: EdgeInsets.symmetric(
          //             vertical: screenSize.screenHeight * 2,
          //             horizontal: screenSize.screenWidth * 10),
          //         child: Container(
          //           width: screenSize.screenWidth * 100,
          //           height: screenSize.screenHeight * 70,
          //           child: GridView.builder(
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: departments.length > 6 ? 3 : 2),
          //             itemBuilder: (BuildContext context, int index) {
          //               return getIcon(departments[index], departments[index],
          //                   DeptHome(departments[index]));
          //             },
          //             itemCount: departments.length,
          //           ),
          //         )),
          Container(
            height: screenSize.screenHeight * 78,
            width: screenSize.screenWidth * 100,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: departments.length > 6 ? 3 : 2),
              itemBuilder: (BuildContext context, int index) {
                return ReusableCard(
                  colour: Theme.of(context).primaryColor,
                  cardChild: IconContent(
                    icon: "images/${departments[index]}.png",
                    label: departments[index],
                  ),
                  onPress: () {
                    if (allowed != null) {
                      if (allowed) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          //Here DecodedData is a locally saved variable containing selected course data
                          return DeptHome(departments[index]);
                        }));
                      } else {
                        if (myDept == departments[index]) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            //Here DecodedData is a locally saved variable containing selected course data
                            return DeptHome(departments[index]);
                          }));
                        } else {
                          Fluttertoast.showToast(
                              msg: "You cannot access this department.");
                        }
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "ERROR! Not able to connect to Server.");
                    }
                  },
                );
              },
              itemCount: departments.length,
            ),
          ),
        ],
      ),
    );
  }
}
