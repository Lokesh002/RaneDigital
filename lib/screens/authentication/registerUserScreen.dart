import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'dart:convert' as convert;
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
  bool moreThanOneDept = false;

  String name;
  String genId;
  String password;

  String address;
  String accountType;
  List<bool> departmentsSelected = [];
  List<String> accessDepartments = [];
  bool registeredSuccess = false;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final genIdController = TextEditingController();
  final passwordController = TextEditingController();

  dataSaveToSharedPref(String userId, String name, String genId,
      String department, String accountType, var access) async {
    SavedData.setLoggedIn(true);
    SavedData.setUserName(name);
    SavedData.setAccountType(accountType);
    SavedData.setDepartment(department);
    SavedData.setGenId(genId);
    SavedData.setUserId(userId);
    SavedData.setFTAEditAccess(access["ftaEdit"]);
    SavedData.setFTAAddAccess(access["ftaAdd"]);
    SavedData.setFTADeleteAccess(access["ftaDelete"]);
    SavedData.setFTAViewAccess(access["ftaSee"]);
    SavedData.setAddNewUserAccess(access["addNewUser"]);

    List<String> accDept = [];
    for (int i = 0; i < access['accessDept'].length; i++) {
      accDept.add(access['accessDept'][i].toString());
    }

    SavedData.setAccessDept(accDept);
    SavedData.setPfuAccess(access["pfu"]);
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

  void getData() {
    for (int i = 0; i < departments.length; i++) {
      if (departmentsSelected.length != departments.length) {
        departmentsSelected.add(false);
        accessDepartments = [];
      } else {
        departmentsSelected[i] = false;
        accessDepartments = [];
      }
    }
  }

  void getStringListofDept() {
    accessDepartments = [];
    if (moreThanOneDept) {
      if (departmentsSelected != null && departmentsSelected.length != 0)
        for (int i = 0; i < departmentsSelected.length; i++) {
          if (departmentsSelected[i]) {
            accessDepartments.add(departments[i]);
          }
        }
    } else {
      accessDepartments = [selectedDepartment];
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    genIdController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);

    Icon staff = staffSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 3,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 3,
            color: Theme.of(context).primaryColor,
          );
    Icon lineLeader = lineLeaderSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 3,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 3,
            color: Theme.of(context).primaryColor,
          );
    Icon operator = operatorSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 3,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 3,
            color: Theme.of(context).primaryColor,
          );
    Icon admin = adminSelected
        ? Icon(
            Icons.check_circle,
            size: screenSize.screenHeight * 3,
            color: Theme.of(context).primaryColor,
          )
        : Icon(
            Icons.check_circle_outline,
            size: screenSize.screenHeight * 3,
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
                          width: screenSize.screenWidth * 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Choose more than one department: "),
                              Checkbox(
                                  value: moreThanOneDept,
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (val) {
                                    moreThanOneDept = val;
                                    getData();
                                    selectedDepartment = null;
                                    setState(() {});
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.screenHeight * 6,
                        ),
                        Visibility(
                            visible: moreThanOneDept,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.screenWidth * 5),
                                  child: Wrap(
                                    spacing: 5,
                                    runSpacing: 3,
                                    children: List.generate(departments.length,
                                        (index) {
                                      return FilterChip(
                                        backgroundColor: Colors.blueAccent,
                                        disabledColor: Colors.orangeAccent,
                                        checkmarkColor: Colors.blue,
                                        selectedColor: Colors.amberAccent,
                                        label: Text(departments[index]),
                                        selected: departmentsSelected[index],
                                        onSelected: (v) {
                                          setState(() {
                                            departmentsSelected[index] =
                                                !departmentsSelected[index];
                                          });
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            )),
                        Visibility(
                          visible: !moreThanOneDept,
                          child: Container(
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
                                          horizontal:
                                              screenSize.screenWidth * 3),
                                      child: DropdownButtonFormField(
                                        disabledHint: Text("Choose Department"),
                                        validator: (val) => val == null
                                            ? 'Select Department'
                                            : null,
                                        elevation: 7,
                                        isExpanded: false,
                                        hint: Text('Choose Department',
                                            style: TextStyle(
                                                color: Colors.black45)),
                                        value: selectedDepartment,
                                        items: getDepartmentList(),
                                        onChanged: (value) {
                                          selectedDepartment = value;
                                          print(
                                              'selected1: $selectedDepartment');

                                          setState(() {});
                                        },
                                      )),
                                ),
                              )),
                        ),
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
                          getStringListofDept();
                          print(departmentsSelected.toString());
                          print(convert.jsonEncode(accessDepartments));
                          if (moreThanOneDept
                              ? (accessDepartments.length > 0)
                              : selectedDepartment != null) {
                            if (accountType != null) {
                              if (_formKey.currentState.validate()) {
                                clearTextInput();

                                Networking networking = Networking();
                                var userData = await networking
                                    .postData("User/registerUser", {
                                  'genId': this.genId,
                                  'username': this.name,
                                  'department': this.accessDepartments[0],
                                  'password': this.password,
                                  'accountType': this.accountType,
                                  'accessDept': this.accessDepartments,
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
                                        this.accessDepartments[0],
                                        accountType,
                                        userData["access"]);
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                        context, '/homeScreen');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(userData)));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error")));
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please select account type")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please select atleast one department.")));
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
