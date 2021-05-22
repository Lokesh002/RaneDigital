import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/CauseValidation/CauseValidationScreen.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/FishBone/environmentFishBone.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/FishBone/machineFishBone.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/FishBone/manFishBone.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/FishBone/materialFishBone.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/FishBone/methodFishBone.dart';

class FishBoneTabScreen extends StatefulWidget {
  final QPCR qpcr;
  FishBoneTabScreen(this.qpcr);
  @override
  _FishBoneTabScreenState createState() => _FishBoneTabScreenState();
}

class _FishBoneTabScreenState extends State<FishBoneTabScreen> {
  // List<Widget> _widgets = <Widget>[];
  // int _defaultIndex = 0;
  int _selectedIndex = 0;
  PageController pageController = new PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //   _selectedIndex = _defaultIndex;
  }

  SizeConfig screenSize;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        controller: pageController,
        children: [
          ManFishBoneScreen(globalQpcr),
          MachineFishBoneScreen(globalQpcr),
          MethodFishBoneScreen(globalQpcr),
          MaterialFishBoneScreen(globalQpcr),
          EnvironmentFishBoneScreen(globalQpcr)
        ],
      ),
      extendBody: false,
      appBar: AppBar(
        title: Text('Fish Bone Analysis'),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: screenSize.screenHeight * 1,
                bottom: screenSize.screenHeight * 1,
                right: screenSize.screenWidth * 5),
            child: MaterialButton(
              onPressed: () async {
                await getCausestoValidation();
                if ((globalQpcr.fishBoneAnalysis.man != null &&
                        globalQpcr.fishBoneAnalysis.man.isNotEmpty) ||
                    (globalQpcr.fishBoneAnalysis.material != null &&
                        globalQpcr.fishBoneAnalysis.material.isNotEmpty) ||
                    (globalQpcr.fishBoneAnalysis.machine != null &&
                        globalQpcr.fishBoneAnalysis.machine.isNotEmpty) ||
                    (globalQpcr.fishBoneAnalysis.method != null &&
                        globalQpcr.fishBoneAnalysis.method.isNotEmpty)) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CauseValidationScreen(globalQpcr)));
                } else {
                  Fluttertoast.showToast(
                      msg: "Please enter at least one cause");
                }
              },
              color: Colors.white,
              elevation: 5,
              height: screenSize.screenHeight * 5,
              minWidth: screenSize.screenWidth * 20,
              child: Text(
                'Next',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (page) {
          setState(() {
            _selectedIndex = page;
          });
          pageController.jumpToPage(page);
        },
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme:
            IconThemeData(color: Theme.of(context).accentColor),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              child: CircleAvatar(
                radius: _selectedIndex == 0
                    ? screenSize.screenHeight * 2.6
                    : screenSize.screenHeight * 2.5,
                backgroundColor: _selectedIndex == 0
                    ? Theme.of(context).accentColor
                    : Colors.white,
                child: Icon(Icons.account_circle_rounded),
                // color: _selectedIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            label: "Man",
          ),
          BottomNavigationBarItem(
            icon: Container(
              child: CircleAvatar(
                radius: _selectedIndex == 1
                    ? screenSize.screenHeight * 2.6
                    : screenSize.screenHeight * 2.5,
                backgroundColor: _selectedIndex == 1
                    ? Theme.of(context).accentColor
                    : Colors.white,
                child: Icon(Icons.precision_manufacturing_rounded),

                // color: _selectedIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            label: "Machine",
          ),
          BottomNavigationBarItem(
            icon: Container(
              child: CircleAvatar(
                radius: _selectedIndex == 2
                    ? screenSize.screenHeight * 2.6
                    : screenSize.screenHeight * 2.5,
                backgroundColor: _selectedIndex == 2
                    ? Theme.of(context).accentColor
                    : Colors.white,
                child: Icon(Icons.mediation),
                // color: _selectedIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            label: "Method",
          ),
          BottomNavigationBarItem(
            icon: Container(
              child: CircleAvatar(
                radius: _selectedIndex == 3
                    ? screenSize.screenHeight * 2.6
                    : screenSize.screenHeight * 2.5,
                backgroundColor: _selectedIndex == 3
                    ? Theme.of(context).accentColor
                    : Colors.white,
                child: Icon(Icons.radio_button_checked),
                // color: _selectedIndex == 2 ? Colors.white : Colors.black,
              ),
            ),
            label: "Material",
          ),
          BottomNavigationBarItem(
            icon: Container(
              child: CircleAvatar(
                radius: _selectedIndex == 4
                    ? screenSize.screenHeight * 2.6
                    : screenSize.screenHeight * 2.5,
                backgroundColor: _selectedIndex == 4
                    ? Theme.of(context).accentColor
                    : Colors.white,
                child: Icon(Icons.brightness_5),
                // color: _selectedIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            label: "Environment",
          ),
        ],
      ),
    );
  }

  Future getCausestoValidation() async {
    List<String> newValidation = [];

    newValidation.addAll(globalQpcr.fishBoneAnalysis.man);
    newValidation.addAll(globalQpcr.fishBoneAnalysis.machine);
    newValidation.addAll(globalQpcr.fishBoneAnalysis.material);
    newValidation.addAll(globalQpcr.fishBoneAnalysis.method);
    newValidation.addAll(globalQpcr.fishBoneAnalysis.environment);

    List<ValidationReport> oldValidation = [];
    oldValidation.addAll(globalQpcr.validationReports);
    print(oldValidation);
    int oldIndex = 0;
    List<ValidationReport> res = [];
    if (oldValidation != null && oldValidation.length != 0) {
      for (int i = 0; i < newValidation.length; i++) {
        if (oldIndex < oldValidation.length) {
          if (newValidation[i] == oldValidation[oldIndex].cause) {
            res.add(oldValidation[oldIndex]);
            oldIndex++;
            print("true1");
          } else {
            bool flag = false;
            print(i);
            for (int j = oldIndex; j < oldValidation.length; j++) {
              print("__$j");
              if (newValidation[i] == oldValidation[j].cause) {
                print("true");
                res.add(oldValidation[j]);
                oldValidation.removeRange(oldIndex, j);
                print("old: " + oldValidation.toString());
                flag = true;
                oldIndex = oldIndex + 1;
                break;
              }
            }

            if (!flag) {
              print(false);
              ValidationReport validationReport = ValidationReport();
              validationReport.cause = newValidation[i];
              validationReport.isValid = null;
              validationReport.specification = null;
              validationReport.remarks = null;
              res.add(validationReport);
            }
          }
        } else {
          ValidationReport validationReport = ValidationReport();
          validationReport.cause = newValidation[i];
          validationReport.isValid = null;
          validationReport.specification = null;
          validationReport.remarks = null;
          res.add(validationReport);
        }
      }
    } else {
      for (int i = 0; i < newValidation.length; i++) {
        ValidationReport validationReport = ValidationReport();
        validationReport.cause = newValidation[i];
        validationReport.isValid = null;
        validationReport.specification = null;
        validationReport.remarks = null;
        res.add(validationReport);
      }
    }
    globalQpcr.validationReports = res;

    Networking networking = Networking();
    QPCRList qpcrList = QPCRList();
    var data = qpcrList.QpcrToMap(globalQpcr);
    var d = await networking.postData('QPCR/QPCRSave', {"newQPCR": data});
    log(d.toString());
    globalQpcr = qpcrList.getQPCR(d);
  }
}
