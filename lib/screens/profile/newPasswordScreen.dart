import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String newPassword;
  String userId;
  String button = "Proceed";
  var _passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SavedData savedData = SavedData();
    userId = await savedData.getUserId();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: screenSize.screenHeight * 95,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
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
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter New Password' : null,
                              controller: _passController,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              onChanged: (value) {
                                newPassword = value;
                              },

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat"),
                              // focusNode: focusNode
                              decoration: InputDecoration(
                                hintText: "New Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.screenHeight * 2)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      ),
                      Center(
                        child: ReusableButton(
                            onPress: () async {
                              if (_formKey.currentState.validate()) {
                                Networking networking = Networking();
                                var result = await networking.postData(
                                    "User/changePassword", {
                                  "userId": userId,
                                  "newPassword": newPassword
                                });
                                if (result != "Error!") {
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Enter correct details");
                                }
                              }
                            },
                            content: button,
                            height: screenSize.screenHeight * 8,
                            width: screenSize.screenWidth * 50),
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
