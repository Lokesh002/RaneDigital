import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/components/constants.dart';

class RegisterUserScreen extends StatefulWidget {
  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  String selectedDepartment;
  bool staffSelected = false;
  bool lineLeaderSelected = false;
  bool operatorSelected = false;
  bool adminSelected = false;

  String name;
  String genId;
  String password;

  String address;
  String accountType;

  bool registeredSuccess = false;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final genIdController = TextEditingController();
  final passwordController = TextEditingController();

  dataSaveToSharedPref(String userId, String name, String genId,
      String department, String accountType, var access) async {
    SavedData savedData = SavedData();

    await savedData.setLoggedIn(true);
    await savedData.setUserName(name);
    await savedData.setAccountType(accountType);
    await savedData.setDepartment(department);
    await savedData.setGenId(genId);
    await savedData.setUserId(userId);
    await savedData.setAddNewUserAccess(access["addNewUser"]);

    await savedData.setPfuAccess(access["pfu"]);
    print(savedData.getAddNewUserAccess());
  }

  clearTextInput() {
    nameController.clear();
    genIdController.clear();
    passwordController.clear();
  }

  List<DropdownMenuItem> getDepartmentList() {
    List<DropdownMenuItem> departmentList = [];
    for (int i = 0; i < departments.length; i++) {
      var item = DropdownMenuItem(
        child: Text(departments[i]),
        value: departments[i],
      );
      departmentList.add(item);
    }

    return departmentList;
  }

  @override
  void dispose() {
    nameController.dispose();
    genIdController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);

    Icon staff = staffSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          );
    Icon lineLeader = lineLeaderSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          );
    Icon operator = operatorSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          );
    Icon admin = adminSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 2,
            color: Theme.of(context).primaryColor,
          );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(children: <Widget>[
              Container(
                width: screenSize.screenWidth * 80,
                height: screenSize.screenHeight * 15,
                child: Image.asset(
                  "images/logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: screenSize.screenHeight * 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Register User",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: screenSize.screenHeight * 3.5,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 2,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[]),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenSize.screenHeight * 5,
                              right: screenSize.screenHeight * 5,
                              top: screenSize.screenHeight * 2),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: screenSize.screenHeight * 2),
                                child: TextFormField(
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter your name' : null,
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.start,
                                  onChanged: (name) {
                                    this.name = name;
                                    print(this.name);
                                  },

                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenSize.screenHeight * 2),
                                  // focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: "Name",
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
                              left: screenSize.screenHeight * 5,
                              right: screenSize.screenHeight * 5,
                              top: screenSize.screenHeight * 2),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter Gen Id' : null,
                                  controller: genIdController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.start,
                                  onChanged: (name) {
                                    this.genId = name;
                                    print(this.genId);
                                  },
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenSize.screenHeight * 2),
                                  // focusNode: focusNode,

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
                              left: screenSize.screenHeight * 5,
                              right: screenSize.screenHeight * 5,
                              top: screenSize.screenHeight * 2),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  validator: (val) => val.length < 6
                                      ? 'Enter a 6+ character long password'
                                      : null,
                                  obscureText: true,
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.start,
                                  onChanged: (pass) {
                                    this.password = pass;
                                    print(this.password);
                                  },
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenSize.screenHeight * 2),
                                  // focusNode: focusNode,
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
                          height: screenSize.screenHeight * 6,
                        ),
                        Container(
                            width: screenSize.screenWidth * 50,
                            height: screenSize.screenHeight * 11,
                            child: Material(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenSize.screenHeight * 1),
                              ),
                              child: Center(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.screenWidth * 3),
                                    child: DropdownButtonFormField(
                                      disabledHint: Text("Choose Department"),
                                      validator: (val) => val == null
                                          ? 'Select Department'
                                          : null,
                                      elevation: 7,
                                      isExpanded: false,
                                      hint: Text('Choose',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor)),
                                      value: selectedDepartment,
                                      items: getDepartmentList(),
                                      onChanged: (value) {
                                        selectedDepartment = value;
                                        print('selected1: $selectedDepartment');

                                        setState(() {});
                                      },
                                    )),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: screenSize.screenHeight * 2,
                        ),
                        Center(
                            child: Text(
                          "Account type",
                          style: TextStyle(
                              fontSize: screenSize.screenHeight * 2,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: screenSize.screenHeight * 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  operator,
                                  SizedBox(
                                    width: screenSize.screenWidth * 2,
                                  ),
                                  Text(
                                    "Operator",
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 2),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  staffSelected = false;
                                  lineLeaderSelected = false;
                                  operatorSelected = true;
                                  adminSelected = false;
                                  this.accountType = "operator";
                                });
                              },
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 2,
                            ),
                            GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  lineLeader,
                                  SizedBox(
                                    width: screenSize.screenWidth * 2,
                                  ),
                                  Text(
                                    "Line Leader",
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 2),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  staffSelected = false;
                                  lineLeaderSelected = true;
                                  operatorSelected = false;
                                  adminSelected = false;
                                  this.accountType = "lineLeader";
                                });
                              },
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 2,
                            ),
                            GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  staff,
                                  SizedBox(
                                    width: screenSize.screenWidth * 2,
                                  ),
                                  Text(
                                    "Staff",
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 2),
                                  )
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  staffSelected = true;
                                  lineLeaderSelected = false;
                                  operatorSelected = false;
                                  adminSelected = false;
                                  this.accountType = "staff";
                                });
                              },
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 2,
                            ),
                            GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  admin,
                                  SizedBox(
                                    width: screenSize.screenWidth * 2,
                                  ),
                                  Text(
                                    "Admin",
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 2),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  staffSelected = false;
                                  lineLeaderSelected = false;
                                  operatorSelected = false;
                                  adminSelected = true;
                                  this.accountType = "admin";
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 6,
                  ),
                  Center(
                    child: ReusableButton(
                        height: screenSize.screenHeight * 8,
                        width: screenSize.screenWidth * 50,
                        content: "Register",
                        onPress: () async {
                          if (accountType != null) {
                            if (_formKey.currentState.validate()) {
                              print("details\n" +
                                  name +
                                  "\n" +
                                  genId +
                                  "\n" +
                                  password +
                                  "\n" +
                                  selectedDepartment +
                                  "\n" +
                                  accountType);
                              clearTextInput();

                              Networking networking = Networking();
                              var userData = await networking
                                  .postData("User/registerUser", {
                                'genId': this.genId,
                                'username': this.name,
                                'department': this.selectedDepartment,
                                'password': this.password,
                                'accountType': this.accountType,
                              });
                              if (userData != null) {
                                //print("userdata " + userData);
                                if (userData != "User already exists") {
                                  clearTextInput();
                                  print(userData["access"]);
                                  await dataSaveToSharedPref(
                                      userData["_id"],
                                      name,
                                      genId,
                                      selectedDepartment,
                                      accountType,
                                      userData["access"]);
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(
                                      context, '/homeScreen');
                                } else {
                                  Fluttertoast.showToast(msg: userData);
                                }
                              } else {
                                Fluttertoast.showToast(msg: "Error");
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select account type");
                          }
                        }),
                  ),
                  SizedBox(
                    height: screenSize.screenWidth * 5,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Already a user? Sign In.",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              fontStyle: FontStyle.normal,
                              fontSize: screenSize.screenHeight * 1.7),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenWidth * 5,
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
