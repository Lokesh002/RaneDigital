import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 10,
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _LoginScreenState extends State<LoginScreen> {
  String genId;
  String password;
  String department;
  String login = 'Login';
  final genIdController = TextEditingController();
  final passwordController = TextEditingController();

  clearTextInput() {
    genIdController.clear();
    passwordController.clear();
  }

  @override
  void initState() {
    //Navigator.pushReplacementNamed(context, "/loadingScreen");
    //signedIn = false;
    super.initState();
  }

  dataSaveToSharedPref(String userId, String name, String genId,
      String department, String accountType, var access) async {
    SavedData savedData = SavedData();

    await savedData.setLoggedIn(true);
    await savedData.setUserName(name);
    await savedData.setAccountType(accountType);
    await savedData.setDepartment(department);
    await savedData.setGenId(genId);
    print("user Id" + userId);
    await savedData.setUserId(userId);
    await savedData.setAddNewUserAccess(access["addNewUser"]);
//    await savedData.setCssAddAccess(access["cssAdd"]);
//    await savedData.setQssAddAccess(access["qssAdd"]);
//    await savedData.setCssEditAccess(access["cssEdit"]);
//    await savedData.setQssEditAccess(access["qssEdit"]);
    await savedData.setPfuAccess(access["pfu"]);
    print(await savedData.getAddNewUserAccess());
    print(await savedData.getGenId());
//    await savedData.setCssVerifyAccess(access["cssVerify"]);
//    await savedData.setQssVerifyAccess(access["qssVerify"]);
//    await savedData.setQssViewAccess(access["qssView"]);
//    await savedData.setCssViewAccess(access["cssView"]);
  }

  @override
  void dispose() {
    genIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(children: <Widget>[
              Container(
                  width: screenSize.screenWidth * 80,
                  height: screenSize.screenHeight * 25,
                  child: Hero(
                    child: Image.asset(
                      "images/logo.png",
                      fit: BoxFit.fitWidth,
                    ),
                    tag: "logo",
                  )),
              SizedBox(
                height: screenSize.screenHeight * 4,
              ),

              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: screenSize.screenHeight * 4,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenSize.screenWidth * 15,
                          right: screenSize.screenWidth * 15,
                          top: screenSize.screenHeight * 2),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: screenSize.screenHeight * 0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your Gen ID' : null,
                              controller: genIdController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              onChanged: (name) {
                                this.genId = name;
                                print(this.genId);
                              },

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat"),
                              // focusNode: focusNode
                              decoration: InputDecoration(
                                hintText: "GEN ID",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.screenHeight * 2)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenSize.screenWidth * 15,
                          right: screenSize.screenWidth * 15,
                          top: screenSize.screenHeight * 2),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: screenSize.screenHeight * 0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your password' : null,
                              controller: passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              onChanged: (name) {
                                this.password = name;
                                print(this.password);
                              },

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat"),
                              // focusNode: focusNode

                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.screenHeight * 2)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 4,
                    ),
                    Center(
                      child: ReusableButton(
                          height: screenSize.screenHeight * 6,
                          width: screenSize.screenWidth * 50,
                          content: login,
                          onPress: () async {
                            final isValid = _formKey.currentState.validate();
                            if (!isValid) {
                              return;
                            }
                            _formKey.currentState.save();
                            Networking networking = Networking();
                            var userData = await networking.postData(
                                "User/getUser", {
                              'genId': this.genId,
                              'password': this.password
                            });
                            if (userData != null) {
                              //print("userdata " + userData);
                              if (userData != "Invalid Password" &&
                                  userData != "User not Found") {
                                clearTextInput();

                                await dataSaveToSharedPref(
                                    userData["_id"],
                                    userData["username"],
                                    userData["genId"],
                                    userData["department"],
                                    userData["accountType"],
                                    userData["access"]);

                                print("PFU access: " +
                                    userData["access"]["pfu"].toString());
                                Navigator.pushReplacementNamed(
                                    context, '/homeScreen');
                              } else {
                                Fluttertoast.showToast(msg: userData);
                              }
                            } else {
                              Fluttertoast.showToast(msg: "Error");
                              clearTextInput();
                            }
                          }),
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 4,
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 10,
                    ),
                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: screenSize.screenHeight * 3,
                            ),
                            Container(
                              width: double.infinity,
                              height: screenSize.screenHeight * 19,
                              color: Color(0xffdfdffa),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: screenSize.screenHeight * 5,
                                  ),
                                  SizedBox(
                                    height: screenSize.screenWidth * 5,
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("New User? ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "Montserrat",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.left),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                '/adminPasswordScreen');
                                          },
                                          child: Text("Sign Up ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "Montserrat",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize:
                                                      screenSize.screenHeight *
                                                          1.7),
                                              textAlign: TextAlign.left),
                                        ),
                                        Text("Now ! ",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "Montserrat",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.left),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: screenSize.screenHeight * 3 + 1,
                            child: CircleAvatar(
                              radius: screenSize.screenHeight * 3,
                              child: Text(
                                "OR",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Montserrat"),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //)
            ]),
          ),
        ],
      ),
    );
  }
}
