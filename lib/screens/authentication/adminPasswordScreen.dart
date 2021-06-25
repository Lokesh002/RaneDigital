import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class AdminPasswordScreen extends StatefulWidget {
  @override
  _AdminPasswordScreenState createState() => _AdminPasswordScreenState();
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

class _AdminPasswordScreenState extends State<AdminPasswordScreen> {
  String adminPassword;
  String adminGenId;
  String button = "Proceed";
  var _passController = TextEditingController();
  var _genIdController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passController.dispose();
    _genIdController.dispose();
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
                        "Enter Admin Details",
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
                                  val.isEmpty ? 'Enter Admin GenId' : null,
                              controller: _genIdController,

                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              onChanged: (value) {
                                adminGenId = value;
                              },

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat"),
                              // focusNode: focusNode
                              decoration: InputDecoration(
                                hintText: "Gen Id",
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
                        child: Container(
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 80,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: screenSize.screenHeight * 0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter Admin Password' : null,
                              controller: _passController,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              onChanged: (value) {
                                adminPassword = value;
                              },

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat"),
                              // focusNode: focusNode
                              decoration: InputDecoration(
                                hintText: "Admin Password",
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
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      ),
                      Center(
                        child: ReusableButton(
                            onPress: () async {
                              if (_formKey.currentState.validate()) {
                                Networking networking = Networking();
                                var result = await networking.postData(
                                    "User/verifyAdmin", {
                                  "genId": adminGenId,
                                  "password": adminPassword
                                });
                                if (result != "User not Found") {
                                  if (result != "Invalid Password") {
                                    if (result["allowed"] == true) {
                                      Navigator.pushReplacementNamed(
                                          context, '/registerUserScreen');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Enter correct details")));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("$result")));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("$result")));
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
