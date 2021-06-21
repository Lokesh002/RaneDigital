import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

import '../updateAppScreen.dart';

class FTAEditScreen extends StatefulWidget {
  final String ftaId;
  final String earlierDescription;
  final String oldPhoto;

  FTAEditScreen(this.ftaId, this.earlierDescription, this.oldPhoto);
  @override
  _FTAEditScreenState createState() => _FTAEditScreenState();
}

class _FTAEditScreenState extends State<FTAEditScreen> {
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

  bool deleteAccess = false;
  void getdata() async {
    deleteAccess = SavedData.getFTADeleteAccess();
    raisingPerson = SavedData.getUserId();
    ftaDescController.text = widget.earlierDescription;
  }

  File _ftaImage;

  // final ImagePicker _picker = ImagePicker();
  // getFTAImage(BuildContext cntext) async {
  //   try {
  //     var image = await _picker.getImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 50,
  //       maxHeight: screenSize.screenHeight * 50,
  //       maxWidth: screenSize.screenWidth * 100,
  //     );
  //     setState(() {
  //       _ftaImage = File(image.path);
  //       print("image path: $image");
  //     });
  //   } catch (e) {
  //     setState(() {
  //       print(e);
  //     });
  //   }
  // }
  void _openImageFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: ['jpg', 'jpeg', 'bmp', 'png'],
    );
    final List<XFile> files = await openFiles(acceptedTypeGroups: [typeGroup]);
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return;
    }
    final XFile file = files[0];
    final String fileName = file.name;
    final String filePath = file.path;

    await showDialog(
      context: context,
      builder: (context) => imageDisplay(fileName, filePath),
    );
  }

  imageDisplay(String fileName, String filePath) {
    return AlertDialog(
      title: Text(fileName),
      // On web the filePath is a blob url
      // while on other platforms it is a system path.
      content: kIsWeb ? Image.network(filePath) : Image.file(File(filePath)),
      actions: [
        TextButton(
          child: const Text('Done'),
          onPressed: () {
            _ftaImage = File(filePath);
            setState(() {});
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
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
  void dispose() {
    ftaDescController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context,
            {"desc": widget.earlierDescription, "photo": widget.oldPhoto});
        return;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                width: screenSize.screenWidth * 100,
                height: screenSize.screenHeight * 92,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                            width: screenSize.screenWidth * 100,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.screenWidth * 5,
                                  vertical: screenSize.screenWidth * 5),
                              child: TextFormField(
                                  validator: (val) => val.length < 1
                                      ? 'Enter Description'
                                      : null,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: screenSize.screenHeight * 2),
                                child: Container(
                                  width: screenSize.screenHeight * 50,
                                  //height: screenSize.screenHeight * 20,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.screenWidth * 2,
                                            vertical:
                                                screenSize.screenHeight * 2),
                                        child: _ftaImage != null
                                            ? Image.memory(
                                                _ftaImage.readAsBytesSync(),
                                                height:
                                                    screenSize.screenHeight *
                                                        30,
                                                fit: BoxFit.contain,
                                              )
                                            : widget.oldPhoto != null
                                                ? Image.network(
                                                    widget.oldPhoto,
                                                    height: screenSize
                                                            .screenHeight *
                                                        30,
                                                    fit: BoxFit.contain,
                                                  )
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
                                            _openImageFile(context);
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
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: screenSize.screenHeight * 3),
                          child: GestureDetector(
                            onTap: () async {
                              if (deleteAccess) {
                                try {
                                  Networking networking = Networking();
                                  var d = await networking
                                      .postData("FTA/deleteFTA", {
                                    "id": widget.ftaId,
                                  });
                                  log(d.toString());

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } catch (e) {
                                  FlutterError.onError(e);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "You are not authorized to delete FTA.")));
                              }
                              // log(this.ftaList[0].parentId.toString());
                            },
                            child: Container(
                              height: screenSize.screenHeight * 10,
                              width: screenSize.screenWidth * 90,
                              color: Colors.redAccent,
                              child: Center(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                if (_ftaImage != null) {
                                  FTA newFTA = await uploadImage(
                                      _ftaImage, context, widget.ftaId);

                                  Networking networking = Networking();
                                  var d =
                                      await networking.postData("FTA/edit", {
                                    "description": ftaDescController.text,
                                    "photoURL": newFTA.photo,
                                    "id": widget.ftaId,
                                  });
                                  log(d.toString());

                                  Navigator.pop(context, {
                                    "desc": ftaDescController.text,
                                    "photo": newFTA.photo
                                  });
                                } else {
                                  Networking networking = Networking();
                                  var d =
                                      await networking.postData("FTA/edit", {
                                    "description": ftaDescController.text,
                                    "photoURL": widget.oldPhoto,
                                    "id": widget.ftaId,
                                  });
                                  log(d.toString());

                                  Navigator.pop(context, {
                                    "desc": ftaDescController.text,
                                    "photo": widget.oldPhoto
                                  });
                                }
                              } catch (e) {
                                FlutterError.onError(e);
                              }
                            }

                            // log(this.ftaList[0].parentId.toString());
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
