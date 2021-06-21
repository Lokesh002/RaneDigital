import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/authentication/adminPasswordScreen.dart';
import 'package:rane_dms/screens/homeScreen.dart';

class ChildPartRejQPCRScreen extends StatefulWidget {
  @override
  _ChildPartRejQPCRScreenState createState() => _ChildPartRejQPCRScreenState();
}

class _ChildPartRejQPCRScreenState extends State<ChildPartRejQPCRScreen> {
  SizeConfig screenSize;
  final _formKey = GlobalKey<FormState>();
  List<Line> lineList;
  String partName;
  String partNumber;
  String responsibleDept;
  String lotCode;
  int totalLotQty;
//DETECTION STAGE VARIABLES
  bool receiptStageDet = false;
  bool customerEndDet = false;
  bool othersDet = false;
  String otherDet;
  bool lineMachine = false;
  bool pdiDet = false;
  String selectedLine;
  String selectedMachine;
  String supplierInvoiceNo;
  //COMPLAINT IMPACT AREAS
  bool safetyImpact = false;
  bool fitmentImpact = false;
  bool functionalImpact = false;
  bool visualImpact = false;
  bool othersImpact = false;
  String otherImpact;
  //DEFECT DETAILS
  String model;
  // DateTime manufacturingDate;
  String concernType;
  String okImageURL;
  String ngImageURL;
  String problem;
  String problemDescription;
  int defectiveQty;
  // int productionOrderQty;

  LineDataStructure lineDataStructure = LineDataStructure();

  String defectRank;

  List<DropdownMenuItem> getLineList() {
    List<DropdownMenuItem> lineDropDownList = [];
    if (lineList != null) {
      for (int i = 0; i < lineList.length; i++) {
        var item = DropdownMenuItem(
          child: Text(lineList[i].lineName),
          value: lineList[i].lineId,
        );
        lineDropDownList.add(item);
      }
      return lineDropDownList;
    } else {
      return null;
    }
  }

  List<DropdownMenuItem> getMachines() {
    setState(() {});

    if (selectedLine != null) {
      isLoaded = false;
      int index;
      List<DropdownMenuItem> machineDropDownList = [];
      for (int i = 0; i < lineList.length; i++) {
        if (lineList[i].lineId == selectedLine) {
          index = i;
        }
      }

      List<Machines> machineList = lineList[index].machines;
      for (int i = 0; i < machineList.length; i++) {
        var item = DropdownMenuItem(
          child: Text(machineList[i].machineCode),
          value: machineList[i].machineId,
        );
        machineDropDownList.add(item);
      }
      isLoaded = true;
      return machineDropDownList;
    } else {
      return null;
    }
  }

  String accountType;

  String dept;
  bool isLoaded = false;
  String raisingDepartment;
  getLine() async {
    lineList = await lineDataStructure.getLines();
    raisingDepartment = SavedData.getDepartment();
    this.isLoaded = true;
    dept = SavedData.getDepartment();
    setState(() {});
    accountType = SavedData.getAccountType();
  }

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

  Widget getTextField(
      String name, Function onChanged, SizeConfig screenSize, var type) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.screenWidth * 5,
          vertical: screenSize.screenHeight * 2),
      child: TextFormField(
        validator: (val) => val.length < 1 ? 'Enter $name' : null,

        //controller: passwordController,
        keyboardType: type,
        textAlign: TextAlign.start,
        onChanged: onChanged,
        style: TextStyle(
            color: Colors.black87, fontSize: screenSize.screenHeight * 2),
        // focusNode: focusNode,
        decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenSize.screenHeight * 2)),
        ),
      ),
    );
  }

  Widget getFilterChip(String name, bool b, Function onSelected) {
    return FilterChip(
      label: Text(
        name,
        style: TextStyle(color: b ? Colors.black : Colors.white),
      ),
      pressElevation: 5,
      backgroundColor: Theme.of(context).primaryColor,
      selectedColor: Colors.yellow,
      checkmarkColor: Theme.of(context).primaryColor,
      selected: b,
      onSelected: onSelected,
    );
  }

  ///////////////////////////////////////////////////////////////////////
//PICKING & UPLOADING IMAGES TO SERVER
  File _okImage;
  File _ngImage;

  final ImagePicker _picker = ImagePicker();
  getOKImageFromGallery(BuildContext cntext) async {
    try {
      var image = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: screenSize.screenHeight * 50,
        maxWidth: screenSize.screenWidth * 100,
      );
      setState(() {
        _okImage = File(image.path);
        print("image path: $image");
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  getNGImageFromGallery(BuildContext cntext) async {
    try {
      var image = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: screenSize.screenHeight * 50,
        maxWidth: screenSize.screenWidth * 100,
      );
      setState(() {
        _ngImage = File(image.path);
        print("image path: $image");
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  Future<int> uploadImage(
      File file, String type, BuildContext context, String qpcrID) async {
    showAlertDialog(context);

    Dio dio = Dio();
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "myQPCR${type}Photo":
          await MultipartFile.fromFile(file.path, filename: fileName),
      "QPCRId": qpcrID,
    });

    Response response = await dio.post(
      ipAddress + 'QPCR/uploadQpcr${type}Photo',
      data: formData,
    );

    print(response.data);

    Navigator.pop(context);
    return (response.statusCode);
  }

/////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    getLine();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    if (!isLoaded) {
      return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Center(
          child: Container(
            child: SpinKitWanderingCubes(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              size: 100.0,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
                  height: screenSize.screenHeight * 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: screenSize.screenHeight * 2,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[]),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: screenSize.screenWidth * 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenSize.screenHeight * 3,
                                ),
                                getTextField("Problem", (v) {
                                  problem = v;
                                }, screenSize, TextInputType.text),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.screenWidth * 5,
                                      vertical: screenSize.screenHeight * 2),
                                  child: TextFormField(
                                    minLines: 2,
                                    maxLines: 4,
                                    onChanged: (v) {
                                      problemDescription = v;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Problem Description",
                                      hintStyle: TextStyle(
                                          fontSize:
                                              screenSize.screenHeight * 2),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenSize.screenHeight * 2)),
                                    ),
                                  ),
                                ),
                                getTextField("Defective Quantity", (v) {
                                  defectiveQty = int.parse(v);
                                }, screenSize, TextInputType.number),
                                getTextField('Part Name', (v) {
                                  this.partName = v;
                                }, screenSize, TextInputType.text),
                                getTextField('Part Number', (v) {
                                  this.partNumber = v;
                                }, screenSize, TextInputType.text),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenSize.screenHeight * 2),
                                  child: Container(
                                      width: screenSize.screenWidth * 90,
                                      height: screenSize.screenHeight * 10,
                                      child: Material(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              screenSize.screenHeight * 2),
                                        ),
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.screenWidth *
                                                          3),
                                              child: DropdownButtonFormField(
                                                disabledHint: Text(
                                                    "Choose Responsible Department"),
                                                validator: (val) => val == null
                                                    ? 'Select a Department'
                                                    : null,
                                                elevation: 7,
                                                isExpanded: false,
                                                hint: Text(
                                                    'Choose Responsible Department',
                                                    style: TextStyle(
                                                        color: Colors.black45)),
                                                value: responsibleDept,
                                                items: getDepartmentList(),
                                                onChanged: (value) {
                                                  responsibleDept = value;

                                                  setState(() {});
                                                },
                                              )),
                                        ),
                                      )),
                                ),
                                getTextField('Lot Code', (v) {
                                  this.lotCode = v;
                                }, screenSize, TextInputType.text),
                                getTextField('Total Lot Quantity', (v) {
                                  this.totalLotQty = int.parse(v);
                                }, screenSize, TextInputType.number),
                                getTextField('Supplier Invoice Number', (v) {
                                  this.supplierInvoiceNo = v;
                                }, screenSize, TextInputType.text),
                                getTextField('Model', (v) {
                                  this.model = v;
                                }, screenSize, TextInputType.text),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenSize.screenHeight * 2),
                                  child: Container(
                                      width: screenSize.screenWidth * 90,
                                      height: screenSize.screenHeight * 10,
                                      child: Material(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              screenSize.screenHeight * 2),
                                        ),
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.screenWidth *
                                                          3),
                                              child: DropdownButtonFormField(
                                                disabledHint:
                                                    Text("Choose Concern Type"),
                                                validator: (val) => val == null
                                                    ? 'Select a concern type'
                                                    : null,
                                                elevation: 7,
                                                isExpanded: false,
                                                hint: Text(
                                                    'Choose Concern Type',
                                                    style: TextStyle(
                                                        color: Colors.black45)),
                                                value: concernType,
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text('New'),
                                                    value: "New",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text("Repeated"),
                                                    value: "Repeated",
                                                  )
                                                ],
                                                onChanged: (value) {
                                                  concernType = value;

                                                  setState(() {});
                                                },
                                              )),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenSize.screenHeight * 2),
                                  child: Container(
                                    width: screenSize.screenWidth * 90,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  screenSize.screenHeight * 2),
                                          child: Text(
                                            'Detection Stage',
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.screenHeight *
                                                        3),
                                          ),
                                        ),
                                        getFilterChip(
                                          "Receipt Stage",
                                          receiptStageDet == true,
                                          (v) {
                                            receiptStageDet = v;
                                            setState(() {});
                                          },
                                        ),
                                        getFilterChip(
                                          "Customer End",
                                          customerEndDet == true,
                                          (v) {
                                            customerEndDet = v;
                                            setState(() {});
                                          },
                                        ),
                                        getFilterChip(
                                          "PDI",
                                          pdiDet == true,
                                          (v) {
                                            pdiDet = v;
                                            setState(() {});
                                          },
                                        ),
                                        getFilterChip(
                                          "Line & Machine",
                                          lineMachine == true,
                                          (v) {
                                            lineMachine = v;
                                            setState(() {});
                                          },
                                        ),
                                        Visibility(
                                          visible: lineMachine,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: screenSize
                                                            .screenHeight *
                                                        2),
                                                child: Container(
                                                    width:
                                                        screenSize.screenWidth *
                                                            70,
                                                    height: screenSize
                                                            .screenHeight *
                                                        10,
                                                    child: Material(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(screenSize
                                                                .screenHeight *
                                                            1),
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        screenSize.screenWidth *
                                                                            3),
                                                            child:
                                                                DropdownButtonFormField(
                                                              disabledHint: Text(
                                                                  "Choose Line"),
                                                              validator: (val) =>
                                                                  val == null
                                                                      ? 'Choose a Line'
                                                                      : null,
                                                              elevation: 5,
                                                              isExpanded: false,
                                                              hint: Text(
                                                                  'Choose Line',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black45)),
                                                              value:
                                                                  selectedLine,
                                                              items:
                                                                  getLineList(),
                                                              onChanged:
                                                                  (value) {
                                                                selectedLine =
                                                                    value;

//                                                    'selected1: $selectedLine');

                                                                setState(() {});
                                                              },
                                                            )),
                                                      ),
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: screenSize
                                                            .screenHeight *
                                                        2),
                                                child: Container(
                                                    width:
                                                        screenSize.screenWidth *
                                                            70,
                                                    height: screenSize
                                                            .screenHeight *
                                                        10,
                                                    child: Material(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(screenSize
                                                                .screenHeight *
                                                            1),
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        screenSize.screenWidth *
                                                                            3),
                                                            child:
                                                                DropdownButtonFormField(
                                                              disabledHint: Text(
                                                                  "Choose Line First"),
                                                              validator: (val) =>
                                                                  val == null
                                                                      ? 'Choose a Machine'
                                                                      : null,
                                                              elevation: 7,
                                                              isExpanded: false,
                                                              items:
                                                                  getMachines(),
                                                              hint: Text(
                                                                  'Choose Machine',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black45)),
                                                              value:
                                                                  selectedMachine,
                                                              onChanged:
                                                                  (value) {
                                                                selectedMachine =
                                                                    value;

                                                                setState(() {});
                                                              },
                                                            )),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        getFilterChip(
                                          "Others",
                                          othersDet == true,
                                          (v) {
                                            othersDet = v;
                                            setState(() {});
                                          },
                                        ),
                                        Visibility(
                                          visible: othersDet,
                                          child: getTextField('Specify Others',
                                              (v) {
                                            this.otherDet = v;
                                          }, screenSize, TextInputType.text),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).accentColor),
                                        borderRadius: BorderRadius.circular(
                                            screenSize.screenHeight * 2)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenSize.screenHeight * 2),
                                  child: Container(
                                    width: screenSize.screenWidth * 90,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  screenSize.screenHeight * 2),
                                          child: Text(
                                            'Impact Areas',
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.screenHeight *
                                                        3),
                                          ),
                                        ),
                                        getFilterChip(
                                          "Safety",
                                          safetyImpact == true,
                                          (v) {
                                            safetyImpact = v;
                                            setState(() {});
                                          },
                                        ),
                                        getFilterChip(
                                          "Functional",
                                          functionalImpact == true,
                                          (v) {
                                            functionalImpact = v;
                                            setState(() {});
                                          },
                                        ),
                                        getFilterChip(
                                          "Fitment",
                                          fitmentImpact == true,
                                          (v) {
                                            fitmentImpact = v;
                                            setState(() {});
                                          },
                                        ),
                                        getFilterChip(
                                          "Visual",
                                          visualImpact == true,
                                          (v) {
                                            visualImpact = v;
                                            setState(() {});
                                          },
                                        ),
                                        getFilterChip(
                                          "Others",
                                          othersImpact == true,
                                          (v) {
                                            othersImpact = v;
                                            setState(() {});
                                          },
                                        ),
                                        Visibility(
                                          visible: othersImpact,
                                          child: Row(
                                            children: [
                                              Container(
                                                width:
                                                    screenSize.screenWidth * 65,
                                                child: getTextField(
                                                    'Specify Other Areas', (v) {
                                                  this.otherImpact = v;
                                                }, screenSize,
                                                    TextInputType.text),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: screenSize
                                                            .screenHeight *
                                                        2),
                                                child: Container(
                                                    width:
                                                        screenSize.screenWidth *
                                                            20,
                                                    height: screenSize
                                                            .screenHeight *
                                                        10,
                                                    child: Material(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(screenSize
                                                                .screenHeight *
                                                            2),
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        screenSize.screenWidth *
                                                                            2),
                                                            child:
                                                                DropdownButtonFormField(
                                                              disabledHint:
                                                                  Text("DR"),
                                                              validator: (val) =>
                                                                  val == null
                                                                      ? 'Select a concern type'
                                                                      : null,
                                                              elevation: 7,
                                                              isExpanded: false,
                                                              hint: Text('Rank',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black45)),
                                                              value: defectRank,
                                                              items: [
                                                                DropdownMenuItem(
                                                                  child:
                                                                      Text('A'),
                                                                  value: "A",
                                                                ),
                                                                DropdownMenuItem(
                                                                  child:
                                                                      Text("B"),
                                                                  value: "B",
                                                                ),
                                                                DropdownMenuItem(
                                                                  child:
                                                                      Text("C"),
                                                                  value: "C",
                                                                ),
                                                                DropdownMenuItem(
                                                                  child:
                                                                      Text("D"),
                                                                  value: "D",
                                                                )
                                                              ],
                                                              onChanged:
                                                                  (value) {
                                                                defectRank =
                                                                    value;

                                                                setState(() {});
                                                              },
                                                            )),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).accentColor),
                                        borderRadius: BorderRadius.circular(
                                            screenSize.screenHeight * 2)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.screenWidth * 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                screenSize.screenHeight * 2),
                                        child: Container(
                                          width: screenSize.screenWidth * 43,
                                          height: screenSize.screenHeight * 20,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenSize.screenWidth *
                                                            2,
                                                    vertical: screenSize
                                                            .screenHeight *
                                                        2),
                                                child: Text(_okImage != null
                                                    ? 'Img' +
                                                        _okImage.path
                                                            .split('/')
                                                            .last
                                                            .split('picker')
                                                            .last
                                                    : 'Please Add OK Photo'),
                                              ),
                                              ReusableButton(
                                                  onPress: () {
                                                    getOKImageFromGallery(
                                                        context);
                                                  },
                                                  content: "OK Image",
                                                  height:
                                                      screenSize.screenHeight *
                                                          7,
                                                  width:
                                                      screenSize.screenWidth *
                                                          10)
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .accentColor),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenSize.screenHeight *
                                                          2)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                screenSize.screenHeight * 2),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenSize.screenWidth *
                                                            2,
                                                    vertical: screenSize
                                                            .screenHeight *
                                                        2),
                                                child: Text(_ngImage != null
                                                    ? 'Img' +
                                                        _ngImage.path
                                                            .split('/')
                                                            .last
                                                            .split('picker')
                                                            .last
                                                    : 'Please Add NG Photo'),
                                              ),
                                              ReusableButton(
                                                  onPress: () {
                                                    getNGImageFromGallery(
                                                        context);
                                                  },
                                                  content: "NG Image",
                                                  height:
                                                      screenSize.screenHeight *
                                                          7,
                                                  width:
                                                      screenSize.screenWidth *
                                                          10)
                                            ],
                                          ),
                                          width: screenSize.screenWidth * 43,
                                          height: screenSize.screenHeight * 20,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .accentColor),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenSize.screenHeight *
                                                          2)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
                          content: "Proceed",
                          onPress: () async {
                            if (_formKey.currentState.validate()) {
                              if (receiptStageDet == true ||
                                  customerEndDet == true ||
                                  pdiDet == true ||
                                  lineMachine == true ||
                                  othersDet == true) {
                                if (visualImpact == true ||
                                    safetyImpact == true ||
                                    functionalImpact == true ||
                                    fitmentImpact == true ||
                                    othersImpact == true) {
                                  if (_okImage != null && _ngImage != null) {
                                    Networking networking = Networking();
                                    var data = await networking
                                        .postData('QPCR/generate', {
                                      "partName": partName,
                                      "partNumber": partNumber,
                                      "lotCode": lotCode,
                                      "totalLotQty": totalLotQty,
                                      "problem": problem,
                                      "productionOrderNumber": null,
                                      "productionOrderQty": null,
                                      "manufacturingDate": null,
                                      "supplierInvoiceNumber":
                                          supplierInvoiceNo,
                                      "model": model,
                                      "concernType": concernType,
                                      "recieptStage": receiptStageDet,
                                      "customerEnd": customerEndDet,
                                      "otherDet": othersDet ? otherDet : null,
                                      "PDI": pdiDet,
                                      "detectionMachine":
                                          lineMachine ? selectedMachine : null,
                                      "detectionLine":
                                          lineMachine ? selectedLine : null,
                                      "complaintImpactAreas": {
                                        "Safety": safetyImpact,
                                        "Fitment": fitmentImpact,
                                        "Functional": functionalImpact,
                                        "Visual": visualImpact,
                                        "Others":
                                            othersImpact ? otherImpact : null
                                      },
                                      "problemDescription": problemDescription,
                                      "defectRank":
                                          defectRank.compareTo(safetyImpact
                                                      ? "A"
                                                      : functionalImpact
                                                          ? "B"
                                                          : fitmentImpact
                                                              ? "C"
                                                              : visualImpact
                                                                  ? "D"
                                                                  : defectRank) <
                                                  1
                                              ? defectRank
                                              : (safetyImpact
                                                  ? "A"
                                                  : functionalImpact
                                                      ? "B"
                                                      : fitmentImpact
                                                          ? "C"
                                                          : visualImpact
                                                              ? "D"
                                                              : defectRank),
                                      "defectiveQuantity": defectiveQty,
                                      "raisingDepartment": dept,
                                      "raisingPerson": SavedData.getUserId(),
                                      "raisingDate": DateTime.now()
                                          .toString()
                                          .substring(0, 10),
                                      "OKPhotoURL": "",
                                      "NGPhotoURL": "",
                                      "departmentResponsible": responsibleDept
                                    });
                                    log(data.toString());
                                    await uploadImage(_okImage, "OK", context,
                                        data['_id'].toString());
                                    var d = await uploadImage(_ngImage, "NG",
                                        context, data['_id'].toString());

                                    log(d.toString());
                                    Fluttertoast.showToast(
                                        msg: "QPCR Generated");
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(msg: "Add Photos");
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please select an Impact Area");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please select a detection stage");
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
}
