import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/QPCRMeasureCard.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/teamInvolved/TeamInvolvedScreen.dart';

class MeasuresScreen extends StatefulWidget {
  @override
  _MeasuresScreenState createState() => _MeasuresScreenState();
}

class _MeasuresScreenState extends State<MeasuresScreen> {
  SizeConfig screenSize;
  StandardizationDetails standardizationDetails = StandardizationDetails();
  TextEditingController drawingController = TextEditingController();
  TextEditingController pfdController = TextEditingController();
  TextEditingController fmeaController = TextEditingController();
  TextEditingController cpController = TextEditingController();
  TextEditingController pisController = TextEditingController();
  TextEditingController sopController = TextEditingController();
  TextEditingController fipController = TextEditingController();
  TextEditingController fdController = TextEditingController();
  TextEditingController psController = TextEditingController();
  TextEditingController otherStandardController = TextEditingController();

  bool isReady = false;

  Widget getTextField(TextEditingController controller, String name,
      SizeConfig screenSize, var type) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.screenWidth * 5,
          vertical: screenSize.screenHeight * 2),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        textAlign: TextAlign.start,
        // onChanged: onChanged,
        style: TextStyle(
            color: Colors.black87, fontSize: screenSize.screenHeight * 2),
        // focusNode: focusNode,
        decoration: InputDecoration(
          labelText: name,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenSize.screenHeight * 2)),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    if (globalQpcr.standardization != null) {
      drawingController.text = globalQpcr.standardization.drawingDocNumber;
      pfdController.text = globalQpcr.standardization.pfdDocNumber;
      fmeaController.text = globalQpcr.standardization.fmeaDocNumber;
      cpController.text = globalQpcr.standardization.cpDocNumber;
      pisController.text = globalQpcr.standardization.pisDocNumber;

      sopController.text = globalQpcr.standardization.sopDocNumber;
      fipController.text = globalQpcr.standardization.fipDocNumber;
      fdController.text = globalQpcr.standardization.fdDocNumber;
      psController.text = globalQpcr.standardization.psDocNumber;
      otherStandardController.text =
          globalQpcr.standardization.otherStandardization;
    }
    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
        appBar: AppBar(),
        body: !isReady
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  children: [
                    Container(
                      height: screenSize.screenHeight * 140,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) => QPCRMeasureCard(
                          qpcr2: globalQpcr,
                          index: index,
                        ),
                        itemCount: globalQpcr.measures.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenSize.screenWidth * 5,
                          top: screenSize.screenHeight * 2),
                      child: Text("Standardization Details",
                          style:
                              TextStyle(fontSize: screenSize.screenHeight * 3)),
                    ),
                    getTextField(drawingController, "Drawing Number",
                        screenSize, TextInputType.text),
                    getTextField(pfdController, "PFD Doc Number", screenSize,
                        TextInputType.text),
                    getTextField(fmeaController, "FMEA Doc Number", screenSize,
                        TextInputType.text),
                    getTextField(cpController, "Control Plan Number",
                        screenSize, TextInputType.text),
                    getTextField(pisController, "PIS Doc Number", screenSize,
                        TextInputType.text),
                    getTextField(sopController, "SOP Doc Number", screenSize,
                        TextInputType.text),
                    getTextField(fipController, "FIP Doc Number", screenSize,
                        TextInputType.text),
                    getTextField(fdController, "FD Doc Number", screenSize,
                        TextInputType.text),
                    getTextField(psController, "PS Doc Number", screenSize,
                        TextInputType.text),
                    getTextField(
                        otherStandardController,
                        "Other Standardization (if any)",
                        screenSize,
                        TextInputType.text),
                    Padding(
                      padding:
                          EdgeInsets.only(top: screenSize.screenHeight * 2),
                      child: GestureDetector(
                        onTap: () async {
                          isReady = false;
                          setState(() {});

                          this.standardizationDetails.drawingDocNumber =
                              drawingController.text;
                          this.standardizationDetails.pfdDocNumber =
                              pfdController.text;
                          this.standardizationDetails.fmeaDocNumber =
                              fmeaController.text;
                          this.standardizationDetails.cpDocNumber =
                              cpController.text;
                          this.standardizationDetails.pisDocNumber =
                              pisController.text;
                          this.standardizationDetails.sopDocNumber =
                              sopController.text;
                          this.standardizationDetails.fipDocNumber =
                              fipController.text;
                          this.standardizationDetails.fdDocNumber =
                              fdController.text;
                          this.standardizationDetails.psDocNumber =
                              psController.text;
                          this.standardizationDetails.otherStandardization =
                              otherStandardController.text;

                          globalQpcr.standardization = standardizationDetails;

                          if (globalQpcr.standardization != null) {
                            print("step");
                            if ((globalQpcr.standardization.drawingDocNumber !=
                                        null &&
                                    globalQpcr
                                            .standardization.drawingDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.pfdDocNumber !=
                                        null &&
                                    globalQpcr.standardization.pfdDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.fmeaDocNumber !=
                                        null &&
                                    globalQpcr.standardization.fmeaDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.cpDocNumber !=
                                        null &&
                                    globalQpcr.standardization.cpDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.pisDocNumber !=
                                        null &&
                                    globalQpcr.standardization.pisDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.sopDocNumber !=
                                        null &&
                                    globalQpcr.standardization.sopDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.psDocNumber !=
                                        null &&
                                    globalQpcr.standardization.psDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.fipDocNumber !=
                                        null &&
                                    globalQpcr.standardization.fipDocNumber !=
                                        "") ||
                                (globalQpcr.standardization.fdDocNumber !=
                                        null &&
                                    globalQpcr.standardization.fdDocNumber !=
                                        "") ||
                                (globalQpcr.standardization
                                            .otherStandardization !=
                                        null &&
                                    globalQpcr.standardization
                                            .otherStandardization !=
                                        "")) {
                              print("step 2");
                              bool flag = true;
                              for (int i = 0;
                                  i < globalQpcr.measures.length;
                                  i++) {
                                if ((globalQpcr.measures[i].correctiveMeasures
                                                .cmOccurrenceMeasure ==
                                            null ||
                                        globalQpcr
                                                .measures[i]
                                                .correctiveMeasures
                                                .cmOccurrenceMeasure ==
                                            "") ||
                                    (globalQpcr.measures[i].correctiveMeasures
                                                .cmOutflowMeasure ==
                                            null ||
                                        globalQpcr
                                                .measures[i]
                                                .correctiveMeasures
                                                .cmOutflowMeasure ==
                                            "") ||
                                    (globalQpcr.measures[i].preventiveMeasures
                                                .pmOccurrenceMeasure ==
                                            null ||
                                        globalQpcr
                                                .measures[i]
                                                .preventiveMeasures
                                                .pmOccurrenceMeasure ==
                                            "") ||
                                    (globalQpcr.measures[i].preventiveMeasures
                                                .pmOutflowMeasure ==
                                            null ||
                                        globalQpcr
                                                .measures[i]
                                                .preventiveMeasures
                                                .pmOutflowMeasure ==
                                            "")) {
                                  flag = false;

                                  break;
                                }
                              }

                              if (flag) {
                                print("Done");
                                Networking networking = Networking();
                                QPCRList qpcrList = QPCRList();
                                var data = qpcrList.QpcrToMap(globalQpcr);

                                var d = await networking.postData(
                                    'QPCR/QPCRSave', {"newQPCR": data});
                                globalQpcr = qpcrList.getQPCR(d);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TeamInvolvedScreen()));
                                isReady = true;
                                setState(() {});
                              }
                              if (!flag) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please Enter all the measures for all causes.");
                                isReady = true;
                                setState(() {});
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please enter atleast one Standardization detail.1");
                              isReady = true;
                              setState(() {});
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Please enter atleast one Standardization detail.2");
                            isReady = true;
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: screenSize.screenWidth * 100,
                          height: screenSize.screenHeight * 10,
                          color: Colors.lightGreen,
                          child: Center(
                            child: Text(
                              "Proceed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.screenHeight * 3),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )));
  }
}
