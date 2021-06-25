import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/ReusableCard.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/icon_content.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/pfu/closePfu/otherDeptPFU.dart';
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

  String raisingDepartment;
  var age = 20;

  List<String> finalDepartments = [];

  getDepartments() async {
    raisingDepartment = SavedData.getDepartment();
    for (int i = 0; i < departments.length; i++) {
      print(departments[i]);
      if (departments[i] != raisingDepartment) {
        finalDepartments.add(departments[i]);
      }
    }
    finalDepartments.add('ALL');
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
        appBar: AppBar(
          title: Text("Select Department"),
        ),
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
        appBar: AppBar(
          title: Text("Select Department"),
        ),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: screenSize.screenHeight * 12,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenSize.screenHeight * 7),
                    child: Container(
                      height: screenSize.screenHeight * 10,
                      child: Text(
                        "Other Department",
                        softWrap: true,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.screenHeight * 3.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenSize.screenHeight * 72,
                  width: screenSize.screenWidth * 100,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: finalDepartments.length > 6 ? 6 : 5),
                    itemBuilder: (BuildContext context, int index) {
                      return ReusableCard(
                        onPress: () {
                          selectedDepartment = finalDepartments[index];
                          setState(() {});
                        },
                        colour: selectedDepartment == finalDepartments[index]
                            ? klabelColor
                            : kactiveColor,
                        cardChild: IconContent(
                          icon: "images/${finalDepartments[index]}.png",
                          label: finalDepartments[index],
                        ),
                      );
                    },
                    itemCount: finalDepartments.length,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selectedDepartment != null)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TabBarScreen(selectedDepartment);
                      }));
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select one department.")));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: screenSize.screenHeight * 10,
                    color: kresultTextColor,
                    //margin: EdgeInsets.only(top: screenSize.screenHeight * 0),
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
        ),
      );
    }
  }
}
