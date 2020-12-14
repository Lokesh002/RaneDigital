import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/ReusableCard.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/icon_content.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/pfu/closePfu/machineListScreen.dart';
import 'package:rane_dms/screens/pfu/closePfu/tabBarScreen.dart';

class ClosePFUScreen extends StatefulWidget {
  @override
  _ClosePFUScreenState createState() => _ClosePFUScreenState();
}

class _ClosePFUScreenState extends State<ClosePFUScreen> {
  String selectedDepartment;
  bool isLoaded = false;
  int height = 180;
  int weight = 65;
  SavedData savedData = SavedData();
  String raisingDepartment;
  var age = 20;
  List<String> departments = [
    "MED",
    "PPC",
    "MFG",
    "Store",
    "QAD",
    "PLE",
    "ALL"
  ];
  List<String> finalDepartments = List<String>();

  getDepartments() async {
    raisingDepartment = await savedData.getDepartment();
    for (int i = 0; i < departments.length; i++) {
      print(departments[i]);
      if (departments[i] != raisingDepartment) {
        finalDepartments.add(departments[i]);
      }
    }
    isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDepartments();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Center(
          child: Container(
            child: SpinKitWanderingCubes(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              size: 100.0,
            ),
          ),
        ),
      );
    } else {
      SizeConfig screenSize = SizeConfig(context);
      return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: screenSize.screenHeight * 15,
                child: Padding(
                  padding: EdgeInsets.only(top: screenSize.screenHeight * 10),
                  child: Container(
                    height: screenSize.screenHeight * 10,
                    child: Text(
                      "Responsible Department",
                      softWrap: true,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.screenHeight * 3.5),
                    ),
                  ),
                ),
              ),
              Row(children: [
                ReusableCard(
                  onPress: () {
                    selectedDepartment = finalDepartments[0];
                    setState(() {});
                  },
                  colour: selectedDepartment == finalDepartments[0]
                      ? kactiveColor
                      : kinactiveColor,
                  cardChild: IconContent(
                    icon: "images/logo.png",
                    label: finalDepartments[0],
                  ),
                ),
                ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedDepartment = finalDepartments[1];
                    });
                  },
                  colour: selectedDepartment == finalDepartments[1]
                      ? kactiveColor
                      : kinactiveColor,
                  cardChild: IconContent(
                    icon: "images/logo.png",
                    label: finalDepartments[1],
                  ),
                ),
              ]),
              Row(children: [
                ReusableCard(
                  onPress: () {
                    selectedDepartment = finalDepartments[2];
                    setState(() {});
                  },
                  colour: selectedDepartment == finalDepartments[2]
                      ? kactiveColor
                      : kinactiveColor,
                  cardChild: IconContent(
                    icon: "images/logo.png",
                    label: finalDepartments[2],
                  ),
                ),
                ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedDepartment = finalDepartments[3];
                    });
                  },
                  colour: selectedDepartment == finalDepartments[3]
                      ? kactiveColor
                      : kinactiveColor,
                  cardChild: IconContent(
                    icon: "images/logo.png",
                    label: finalDepartments[3],
                  ),
                ),
              ]),
              Row(children: [
                ReusableCard(
                  onPress: () {
                    selectedDepartment = finalDepartments[4];
                    setState(() {});
                  },
                  colour: selectedDepartment == finalDepartments[4]
                      ? kactiveColor
                      : kinactiveColor,
                  cardChild: IconContent(
                    icon: "images/logo.png",
                    label: finalDepartments[4],
                  ),
                ),
                ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedDepartment = finalDepartments[5];
                    });
                  },
                  colour: selectedDepartment == finalDepartments[5]
                      ? kactiveColor
                      : kinactiveColor,
                  cardChild: IconContent(
                    icon: "images/logo.png",
                    label: finalDepartments[5],
                  ),
                ),
              ]),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TabBarScreen(selectedDepartment);
                  }));
                },
                child: Container(
                  width: double.infinity,
                  height: screenSize.screenHeight * 10,
                  color: kresultTextColor,
                  margin: EdgeInsets.only(top: screenSize.screenHeight * 2),
                  child: Center(
                      child: Text(
                    'PROCEED',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: screenSize.screenHeight * 2.75,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              )
            ]),
      );
    }
  }
}
