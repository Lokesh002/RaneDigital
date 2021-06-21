import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/profile/changeDepartmentScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
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

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String genId = '';

  String department = '';
  String accountType = '';
  String photo;
  int balance;

  String levelOfSubscription = '';
  File _image;

  List<String> accessDept = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  // getImageFromGallery(BuildContext cntext) async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = image;
  //     print("image path: $image");
  //   });
  //   if (_image != null) {
  //     final response = await uploadImage(_image, cntext);
  //     print('asa' + response.toString());
  //     // Check if any error occured
  //     if (response == null) {
  //       //pr.hide();
  //
  //       print('User details not updated');
  //     } else {
  //       setState(() {
  //         photo = response;
  //       });
  //       print(response);
  //     }
  //   } else {
  //     print('Please Select a profile photo');
  //   }
  // }

  // Future<String> uploadImage(File file, BuildContext context) async {
  //   showAlertDialog(context);
  //
  //   Dio dio = Dio();
  //   String fileName = file.path.split('/').last;
  //   FormData formData = FormData.fromMap({
  //     "image": await MultipartFile.fromFile(file.path, filename: fileName),
  //   });
  //
  //   Response response = await dio.post(
  //     '',
  //     data: formData,
  //   );
  //   print(response.data);
  //   photo = response.data;
  //   SavedData.setProfileImage(photo);
  //   Navigator.pop(context);
  //   return (response.data);
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: screenSize.screenHeight * 45,
                    width: screenSize.screenWidth * 100,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenSize.screenHeight * 10,
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: screenSize.screenHeight * 10,
                              child: ClipOval(
                                child: SizedBox(
                                  width: screenSize.screenWidth * 35,
                                  height: screenSize.screenWidth * 35,
                                  child: (photo == null)
                                      ? Icon(
                                          Icons.person,
                                          color: Theme.of(context).accentColor,
                                          size: screenSize.screenHeight * 15,
                                        )
                                      : FadeInImage.assetNetwork(
                                          placeholder: 'images/logo.png',
                                          image: photo),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.screenHeight * 2,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.screenHeight * 3.5,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.screenHeight * 1,
                        ),
                        Text(
                          levelOfSubscription,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.screenHeight * 2.5,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenSize.screenWidth * 80,
                      height: screenSize.screenHeight * 90,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: screenSize.screenHeight * 41,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenSize.screenHeight * 2),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: screenSize.screenHeight * 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 5),
                                      child: Text(
                                        "GEN ID: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenSize.screenHeight * 2,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 5),
                                      child: Text(
                                        genId,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenSize.screenHeight * 2,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.screenHeight * 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 5),
                                      child: Text(
                                        "Department: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenSize.screenHeight * 2,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 5),
                                      child: Text(
                                        department,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenSize.screenHeight * 2,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.screenHeight * 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 5),
                                      child: Text(
                                        "Account Type: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenSize.screenHeight * 2,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 5),
                                      child: Text(
                                        accountType,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenSize.screenHeight * 2,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.screenHeight * 1,
                                ),
                                SizedBox(
                                  height: screenSize.screenHeight * 1,
                                ),
                                SizedBox(
                                  height: screenSize.screenHeight * 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenSize.screenHeight * 5),
                                  child: Center(
                                    child: ReusableButton(
                                      onPress: () {
                                        SavedData.setLoggedIn(false);
                                        SavedData.setUserName(null);
                                        SavedData.setAccountType(null);
                                        SavedData.setDepartment(null);
                                        SavedData.setGenId(null);
                                        SavedData.setUserId(null);
                                        SavedData.setAddNewUserAccess(null);
                                        SavedData.setFTAEditAccess(null);
                                        SavedData.setFTAAddAccess(null);
                                        SavedData.setFTADeleteAccess(null);
                                        SavedData.setFTAViewAccess(null);
                                        SavedData.setAccessDept(null);
                                        SavedData.setPfuAccess(null);
                                        print(SavedData.getAddNewUserAccess());
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(
                                            context, '/loginScreen');
                                      },
                                      height: screenSize.screenHeight * 5,
                                      width: screenSize.screenWidth * 30,
                                      content: "Log Out",
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: accessDept != null
                                      ? accessDept.length > 1
                                      : false,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenSize.screenHeight * 2,
                                        top: screenSize.screenHeight * 2),
                                    child: Center(
                                      child: ReusableButton(
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangeDepartmentScreen(
                                                          accessDept))).then(
                                              (value) {
                                            if (value != null) {
                                              department = value;
                                              setState(() {});
                                            }
                                          });
                                        },
                                        content: "Change Department",
                                        height: screenSize.screenHeight * 5,
                                        width: screenSize.screenWidth * 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenSize.screenHeight * 2,
                                      top: screenSize.screenHeight * 0),
                                  child: Center(
                                    child: ReusableButton(
                                      onPress: () {
                                        Navigator.pushNamed(
                                            context, '/changePassword');
                                      },
                                      content: "Change Password",
                                      height: screenSize.screenHeight * 5,
                                      width: screenSize.screenWidth * 30,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void getData() {
    name = SavedData.getUserName();
    genId = SavedData.getGenId();
    department = SavedData.getDepartment();
    accountType = SavedData.getAccountType();
    accessDept = SavedData.getAccessDept();
    setState(() {});
  }
}
