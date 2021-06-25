import 'dart:developer';
import 'dart:typed_data';
import 'package:universal_io/io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io' as io;
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/acceptQPCRScreen.dart';

import 'package:universal_io/prefer_universal/io.dart';

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

class _FTAGenerateScreenState extends State<FTAGenerateScreen> {
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

  void getdata() async {
    raisingPerson = SavedData.getUserId();
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
    // TODO: implement dispose
    ftaDescController.dispose();
    super.dispose();
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
                              vertical: screenSize.screenWidth * 5),
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
                                    child: _selectedFile != null
                                        ? Image.memory(
                                            _selectedFile,
                                            height:
                                                screenSize.screenHeight * 30,
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
                        if (_selectedFile != null) {
                          FTA f = await uploadImage(context, d['_id']);

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
