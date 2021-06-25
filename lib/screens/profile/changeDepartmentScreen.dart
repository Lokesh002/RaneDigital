import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class ChangeDepartmentScreen extends StatefulWidget {
  final List<String> accessDept;
  ChangeDepartmentScreen(this.accessDept);
  @override
  _ChangeDepartmentScreenState createState() => _ChangeDepartmentScreenState();
}

class _ChangeDepartmentScreenState extends State<ChangeDepartmentScreen> {
  String newDepartment;
  String userId;
  String button = "Proceed";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  setSharedPref(String dept) async {
    SavedData.setDepartment(dept);
  }

  getData() async {
    userId = SavedData.getUserId();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, null);
        return;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              height: screenSize.screenHeight * 95,
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenSize.screenWidth * 80,
                        height: screenSize.screenHeight * 30,
                        child: Image.asset(
                          "images/logo.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      ),
                      Text(
                        "Enter New Password",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: screenSize.screenHeight * 3.5,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 5,
                      ),
                      Center(
                        child: Container(
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 80,
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: screenSize.screenHeight * 0),
                              child: Center(
                                child: DropdownButton(
                                  disabledHint: Text("Choose Department"),
                                  elevation: 7,
                                  isExpanded: false,
                                  hint: Text('Choose Department',
                                      style: TextStyle(color: Colors.black45)),
                                  value: newDepartment,
                                  items: List.generate(
                                    widget.accessDept.length,
                                    (index) => DropdownMenuItem(
                                      child: Text(widget.accessDept[index]),
                                      value: widget.accessDept[index],
                                    ),
                                  ),
                                  onChanged: (value) {
                                    newDepartment = value;
                                    print('selected1: $newDepartment');

                                    setState(() {});
                                  },
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      ),
                      Center(
                        child: ReusableButton(
                            onPress: () async {
                              if (newDepartment != null) {
                                Networking networking = Networking();
                                var result = await networking.postData(
                                    "User/changeDept", {
                                  "userId": userId,
                                  "newDepartment": newDepartment
                                });

                                if (result != "Error!") {
                                  await setSharedPref(result['department']);
                                  Navigator.pop(context, result['department']);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Choose a new department.")));
                                }
                              }
                            },
                            content: button,
                            height: screenSize.screenHeight * 8,
                            width: screenSize.screenWidth * 50),
                      ),
                    ],
                  ),
                ]),
              ))),
    );
  }
}
