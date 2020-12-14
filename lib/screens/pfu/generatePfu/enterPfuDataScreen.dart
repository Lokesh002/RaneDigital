import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class EnterPFUDataScreen extends StatefulWidget {
  Line selectedLine;
  String dept;
  Machines selectedMachine;
  EnterPFUDataScreen(this.selectedLine, this.selectedMachine, this.dept);

  @override
  _EnterPFUDataScreenState createState() => _EnterPFUDataScreenState();
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

class _EnterPFUDataScreenState extends State<EnterPFUDataScreen> {
  String selectedDepartment;
  String userId;
  String problem;
  String problemDescription;
  String raisingDepartment;
  String address;
  String accountType;
  File _image;
  bool registeredSuccess = false;

  String pfuId;
  final _formKey = GlobalKey<FormState>();
  final problemController = TextEditingController();
  final problemDescController = TextEditingController();

  clearTextInput() {
    problemController.clear();
    problemDescController.clear();
  }

  SavedData savedData = SavedData();

  List departments = ["MED", "PPC", "MFG", "Store", "QAD", "PLE"];
  List<DropdownMenuItem> getDepartmentList() {
    List<DropdownMenuItem> departmentList = [];

    for (int i = 0; i < departments.length; i++) {
      if (departments[i] != raisingDepartment) {
        var item = DropdownMenuItem(
          child: Text(departments[i]),
          value: departments[i],
        );
        departmentList.add(item);
      } else {
        print("yes");
      }
    }

    return departmentList;
  }

  @override
  void dispose() {
    problemController.dispose();
    problemDescController.dispose();

    super.dispose();
  }

  getData() async {
    raisingDepartment = widget.dept;
    userId = await savedData.getUserId();
  }

  SizeConfig screenSize;

  @override
  void initState() {
    super.initState();
    getData();
  }

  final ImagePicker _picker = ImagePicker();
  getImageFromGallery(BuildContext cntext) async {
    try {
      var image = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 25,
        maxHeight: screenSize.screenHeight * 50,
        maxWidth: screenSize.screenWidth * 100,
      );
      setState(() {
        _image = File(image.path);
        print("image path: $image");
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
//    if (_image != null) {
//      final response = await uploadImage(_image, cntext);
//      print('asa' + response.toString());
//      // Check if any error occured
//      if (response == null) {
//        //pr.hide();
//
//        print('User details not updated');
//      } else {
//        setState(() {
//          photo = response;
//        });
//        print(response);
//      }
//    } else {
//      print('Please Select a profile photo');
//    }
  }

  Future<int> uploadImage(File file, BuildContext context) async {
    showAlertDialog(context);

    Dio dio = Dio();
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "myPhoto": await MultipartFile.fromFile(file.path, filename: fileName),
      "pfuId": pfuId,
    });

    Response response = await dio.post(
      'http://192.168.43.18:3000/uploadPFUPhoto',
      data: formData,
    );
    print(response.data);

    Navigator.pop(context);
    return (response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
                    widget.selectedLine.lineName,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: screenSize.screenHeight * 3.5,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 1,
                  ),
                  Text(
                    widget.selectedMachine.machineName,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: screenSize.screenHeight * 2,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 2,
                  ),
                  Text(
                    "Enter PFU Details",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: screenSize.screenHeight * 2.5,
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
                                      val.isEmpty ? 'Enter Problem' : null,
                                  controller: problemController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.start,
                                  onChanged: (problem) {
                                    this.problem = problem;
                                    print(this.problem);
                                  },

                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenSize.screenHeight * 2),
                                  // focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: "Problem",
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
                                  minLines: 3,
                                  maxLines: 5,
                                  validator: (val) => val.isEmpty
                                      ? 'Enter Problem Description'
                                      : null,
                                  controller: problemDescController,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.start,
                                  onChanged: (problemDesc) {
                                    this.problemDescription = problemDesc;
                                    print(this.problemDescription);
                                  },
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenSize.screenHeight * 2),
                                  // focusNode: focusNode,

                                  decoration: InputDecoration(
                                    hintText: "Problem Description",
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
                            width: screenSize.screenWidth * 80,
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
                                      disabledHint:
                                          Text("Choose Responsible Department"),
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
                        SizedBox(
                          height: screenSize.screenHeight * 3,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.screenWidth * 10,
                                  right: screenSize.screenWidth * 3),
                              child: ReusableButton(
                                  onPress: () async {
                                    await getImageFromGallery(context);
                                  },
                                  content: "Add Photo",
                                  height: screenSize.screenHeight * 5,
                                  width: screenSize.screenWidth * 30),
                            ),
                            Container(
                              width: screenSize.screenWidth * 50,
                              child: Text(
                                _image != null
                                    ? _image.path.split('/').last
                                    : "Please Add Photo",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: screenSize.screenHeight * 1.5,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 3,
                  ),
                  Center(
                    child: ReusableButton(
                        height: screenSize.screenHeight * 8,
                        width: screenSize.screenWidth * 50,
                        content: "Register",
                        onPress: () async {
                          if (_formKey.currentState.validate()) {
                            if (_image != null) {
                              Networking networking = Networking();

                              var data =
                                  await networking.postData('PFU/generate', {
                                "problem": problem,
                                "description": problemDescription,
                                "raisingDepartment": raisingDepartment,
                                "departmentResponsible": selectedDepartment,
                                "machine": widget.selectedMachine.machineId,
                                "raisingPerson": userId,
                                "line": widget.selectedLine.lineId
                              });

                              if (data != null) {
                                if (data != "Error") {
                                  pfuId = data['_id'];
                                  int statusCode =
                                      await uploadImage(_image, context);

                                  if (statusCode == 200) {
                                    Fluttertoast.showToast(
                                        msg: "Successfully Added PFU.");

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: "Error.");
                                }
                              } else {
                                Fluttertoast.showToast(msg: "Error.");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please add a photo first.");
                            }
                          }
                        }),
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
