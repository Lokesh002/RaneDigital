import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io' as io;
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class FTAEditScreen extends StatefulWidget {
  final String ftaId;
  final String earlierDescription;
  final String oldPhoto;

  FTAEditScreen(this.ftaId, this.earlierDescription, this.oldPhoto);
  @override
  _FTAEditScreenState createState() => _FTAEditScreenState();
}

showAlertDiaprint(BuildContext context) {
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

class _FTAEditScreenState extends State<FTAEditScreen> {
  String raisingPerson;
  SizeConfig screenSize;
  TextEditingController ftaDescController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<int> _selectedFile;
  Uint8List _bytesData;
  String filename;

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

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();
      filename = file.name;

      void _handleResult(Object result) {
        setState(() {
          _bytesData =
              Base64Decoder().convert(result.toString().split(",").last);
          _selectedFile = _bytesData;
        });
      }

      reader.onLoadEnd.listen((e) {
        log(file.type);
        if ((file.type.contains('jpeg') &&
                (file.name.split('.').last == 'jpg' ||
                    file.name.split('.').last == 'jpeg')) ||
            file.type.contains('png'))
          _handleResult(reader.result);
        else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please add a JPG/JPEG/PNG file only.")));
        }
      });
      reader.readAsDataUrl(file);
    });
  }

  Future<FTA> uploadImage(BuildContext context, String id) async {
    showAlertDiaprint(context);
    log("id: " + id);

    var request = new http.MultipartRequest(
        "POST", Uri.parse(ipAddress + "FTA/uploadFTApic"));
    request.fields['id'] = '$id';
    request.files.add(http.MultipartFile.fromBytes(
      'myFTApic',
      _selectedFile,
      filename: filename,
      contentType: new MediaType('application', 'octet-stream'),
    ));
    var response = await request.send();

    Navigator.pop(context);

    log('code:' + response.statusCode.toString());
    FTAList f = FTAList();

    var a = convert.jsonDecode((await http.Response.fromStream(response)).body);
    print(a.toString());

    List<FTA> fList = f.getFTAList([a]);
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
                                        child: _selectedFile != null
                                            ? Image.memory(
                                                _selectedFile,
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
                                                : Text(_selectedFile != null
                                                    ? filename
                                                    : 'Please Add FTA Photo'),
                                      ),
                                      ReusableButton(
                                          onPress: () {
                                            startWebFilePicker();
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
                                if (_selectedFile != null) {
                                  FTA newFTA =
                                      await uploadImage(context, widget.ftaId);

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
