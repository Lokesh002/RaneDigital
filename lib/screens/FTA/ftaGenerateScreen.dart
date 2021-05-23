import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/acceptQPCRScreen.dart';
import 'dart:convert' as convert;

class FTAGenerateScreen extends StatefulWidget {
  final String parentId;
  final String parentDesc;
  final String machineId;
  final String lineId;
  final List<FTA> ftaList;
  FTAGenerateScreen(this.parentId, this.parentDesc, this.machineId, this.lineId,
      this.ftaList);
  @override
  _FTAGenerateScreenState createState() => _FTAGenerateScreenState();
}

class _FTAGenerateScreenState extends State<FTAGenerateScreen> {
  String raisingPerson;
  SizeConfig screenSize;
  TextEditingController ftaDescController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    SavedData savedData = SavedData();
    raisingPerson = await savedData.getUserId();
  }

  File _ftaImage;

  final ImagePicker _picker = ImagePicker();
  getFTAImage(BuildContext cntext) async {
    try {
      var image = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: screenSize.screenHeight * 50,
        maxWidth: screenSize.screenWidth * 100,
      );
      setState(() {
        _ftaImage = File(image.path);
        print("image path: $image");
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  Future<FTA> uploadImage(File file, BuildContext context, String id) async {
    showAlertDialog(context);

    Dio dio = Dio();
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "myFTApic": await MultipartFile.fromFile(file.path, filename: fileName),
      "id": id,
    });

    Response response = await dio.post(
      ipAddress + 'FTA/uploadFTApic',
      data: formData,
    );

    log(response.data.toString());

    Navigator.pop(context);

    FTAList f = FTAList();
    List<FTA> fList = f.getFTAList([(response.data)]);
    return (fList[0]);
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, widget.ftaList);
        return;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: screenSize.screenWidth * 100,
              height: screenSize.screenHeight * 92,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Container(
                        width: screenSize.screenWidth * 100,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.screenWidth * 5,
                              vertical: screenSize.screenWidth * 10),
                          child: TextFormField(
                              validator: (val) =>
                                  val.length < 1 ? 'Enter Description' : null,
                              controller: ftaDescController,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: screenSize.screenHeight * 3),
                              // focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: "FTA Description",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.screenHeight * 2)),
                              )),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenSize.screenHeight * 2),
                            child: Container(
                              width: screenSize.screenWidth * 90,
                              //height: screenSize.screenHeight * 20,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.screenWidth * 2,
                                        vertical: screenSize.screenHeight * 2),
                                    child: _ftaImage != null
                                        ? Image.memory(
                                            _ftaImage.readAsBytesSync())
                                        : Text(_ftaImage != null
                                            ? 'Img' +
                                                _ftaImage.path
                                                    .split('/')
                                                    .last
                                                    .split('picker')
                                                    .last
                                            : 'Please Add FTA Photo'),
                                  ),
                                  ReusableButton(
                                      onPress: () {
                                        getFTAImage(context);
                                      },
                                      content: "Upload Image",
                                      height: screenSize.screenHeight * 7,
                                      width: screenSize.screenWidth * 10)
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(
                                      screenSize.screenHeight * 2)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        Networking networking = Networking();
                        var d = await networking.postData("FTA/generate", {
                          "parent": widget.parentId,
                          "machine": widget.machineId,
                          "description": ftaDescController.text,
                          "photoURL": null,
                          "raisingPerson": raisingPerson,
                          "line": widget.lineId,
                        });
                        List<FTA> fList = widget.ftaList;
                        if (_ftaImage != null) {
                          FTA f =
                              await uploadImage(_ftaImage, context, d['_id']);

                          fList.add(f);
                        } else {
                          FTAList ftaList = FTAList();
                          List<dynamic> a = [];
                          a.add(d);
                          var list = ftaList.getFTAList(a);

                          fList.addAll(list);
                        }

                        Navigator.pop(context, fList);
                      }
                    },
                    child: Container(
                      height: screenSize.screenHeight * 10,
                      width: screenSize.screenWidth * 100,
                      color: Colors.lightGreen,
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenSize.screenHeight * 3),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
