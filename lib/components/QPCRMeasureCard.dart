import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';

import 'QPCRDataStructure.dart';

class QPCRMeasureCard extends StatefulWidget {
  final QPCR qpcr2;
  final int index;
  QPCRMeasureCard({this.qpcr2, this.index});
  @override
  _QPCRMeasureCardState createState() => _QPCRMeasureCardState();
}

class _QPCRMeasureCardState extends State<QPCRMeasureCard> {
  var pmOutflowController = TextEditingController();
  var pmOccurrenceController = TextEditingController();
  var cmOutflowController = TextEditingController();
  var cmOccurrenceController = TextEditingController();
  TextEditingController cmOutflowResp = TextEditingController();
  TextEditingController cmOccurrenceResp = TextEditingController();
  TextEditingController pmOutflowResp = TextEditingController();
  TextEditingController pmOccurrenceResp = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isReady = false;

  DateTime cmOutflowTargetDate;
  DateTime cmOccurrenceTargetDate;
  DateTime pmOutflowTargetDate;
  DateTime pmOccurrenceTargetDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pmOutflowController.text =
        globalQpcr.measures[widget.index].preventiveMeasures.pmOutflowMeasure;

    pmOccurrenceController.text = globalQpcr
        .measures[widget.index].preventiveMeasures.pmOccurrenceMeasure;
    pmOutflowResp.text =
        globalQpcr.measures[widget.index].preventiveMeasures.pmOutflowResp;
    pmOutflowTargetDate = globalQpcr
        .measures[widget.index].preventiveMeasures.pmOutflowTargetDate;
    pmOccurrenceResp.text =
        globalQpcr.measures[widget.index].preventiveMeasures.pmOccurrenceResp;
    pmOccurrenceTargetDate = globalQpcr
        .measures[widget.index].preventiveMeasures.pmOccurrenceTargetDate;
    cmOccurrenceController.text = globalQpcr
        .measures[widget.index].correctiveMeasures.cmOccurrenceMeasure;
    cmOutflowController.text =
        globalQpcr.measures[widget.index].correctiveMeasures.cmOutflowMeasure;
    cmOutflowResp.text =
        globalQpcr.measures[widget.index].correctiveMeasures.cmOutflowResp;

    cmOutflowTargetDate = globalQpcr
        .measures[widget.index].correctiveMeasures.cmOutflowTargetDate;
    cmOccurrenceResp.text =
        globalQpcr.measures[widget.index].correctiveMeasures.cmOccurrenceResp;
    cmOccurrenceTargetDate = globalQpcr
        .measures[widget.index].correctiveMeasures.cmOccurrenceTargetDate;

    isReady = true;
  }

  getTextField(
      String name, var controller, String validator, int minLine, int maxLine) {
    return Container(
      width: screenSize.screenWidth * 40,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.screenWidth * 5,
            vertical: screenSize.screenWidth * 1),
        child: TextFormField(
            validator: (val) => val.length < 1 ? validator : null,
            controller: controller,
            minLines: minLine,
            maxLines: maxLine,
            style: TextStyle(
                color: Colors.black87, fontSize: screenSize.screenHeight * 2),
            // focusNode: focusNode,
            decoration: InputDecoration(
              hintText: name,
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(screenSize.screenHeight * 2)),
            )),
      ),
    );
  }

  getDatePicker(DateTime targetDate) {
    return Container(
        width: screenSize.screenWidth * 30,
        //height: screenSize.screenHeight * 10,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(screenSize.screenHeight * 1)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenSize.screenHeight,
              horizontal: screenSize.screenWidth * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableButton(
                  onPress: () async {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 730)),
                    ).then((date) {
                      targetDate = date;
                      setState(() {});
                    });
                  },
                  content: "Target Date",
                  height: screenSize.screenHeight * 5,
                  width: screenSize.screenWidth * 15),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.screenWidth * 2),
                child: Container(
                  width: screenSize.screenWidth * 50,
                  height: screenSize.screenHeight * 8,
                  child: targetDate != null
                      ? Center(
                          child: Text(targetDate.day.toString() +
                              " / " +
                              targetDate.month.toString() +
                              " / " +
                              targetDate.year.toString()),
                        )
                      : Center(child: Text("Please select a date")),
                ),
              ),
            ],
          ),
        ));
  }

  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Form(
      key: _formKey,
      child: Container(
        width: globalQpcr.measures.length > 1
            ? screenSize.screenWidth * 90
            : screenSize.screenWidth * 100,
        //height: screenSize.screenHeight * 100,
        child: isReady
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.screenWidth * 5,
                    vertical: screenSize.screenWidth * 2),
                child: Material(
                  borderRadius:
                      BorderRadius.circular(screenSize.screenHeight * 2),
                  color: Color(0x11000000),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text('Cause ${widget.index + 1}',
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 3)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(widget.qpcr2.measures[widget.index].cause),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.screenWidth * 5,
                            vertical: screenSize.screenWidth * 2),
                        child: Text(
                          "Corrective Measures",
                          style:
                              TextStyle(fontSize: screenSize.screenHeight * 3),
                        ),
                      ),
                      Container(
                        width: screenSize.screenWidth * 80,
                        child: Row(
                          children: [
                            Column(children: [
                              getTextField(
                                  "Corrective Outflow Prevention",
                                  cmOutflowController,
                                  "Enter Corrective Outflow Measure",
                                  5,
                                  5),
                              Container(
                                  width: screenSize.screenWidth * 30,
                                  //height: screenSize.screenHeight * 10,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(
                                          screenSize.screenHeight * 1)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.screenHeight,
                                        horizontal: screenSize.screenWidth * 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReusableButton(
                                            onPress: () async {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 730)),
                                              ).then((date) {
                                                cmOutflowTargetDate = date;
                                                setState(() {});
                                              });
                                            },
                                            content: "Target Date",
                                            height: screenSize.screenHeight * 5,
                                            width: screenSize.screenWidth * 15),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.screenWidth * 2),
                                          child: Container(
                                            width: screenSize.screenWidth * 50,
                                            height: screenSize.screenHeight * 8,
                                            child: cmOutflowTargetDate != null
                                                ? Center(
                                                    child: Text(
                                                        cmOutflowTargetDate.day
                                                                .toString() +
                                                            " / " +
                                                            cmOutflowTargetDate
                                                                .month
                                                                .toString() +
                                                            " / " +
                                                            cmOutflowTargetDate
                                                                .year
                                                                .toString()),
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "Please select a date")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              //  getDatePicker(cmOutflowTargetDate),
                              getTextField('Responsibility', cmOutflowResp,
                                  'Enter Responsible Person', 1, 1),
                            ]),
                            Column(children: [
                              getTextField(
                                  "Corrective Occurrence Prevention",
                                  cmOccurrenceController,
                                  "Enter Corrective Occurrence Measure",
                                  5,
                                  5),
                              Container(
                                  width: screenSize.screenWidth * 30,
                                  //height: screenSize.screenHeight * 10,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(
                                          screenSize.screenHeight * 1)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.screenHeight,
                                        horizontal: screenSize.screenWidth * 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReusableButton(
                                            onPress: () async {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 730)),
                                              ).then((date) {
                                                cmOccurrenceTargetDate = date;
                                                setState(() {});
                                              });
                                            },
                                            content: "Target Date",
                                            height: screenSize.screenHeight * 5,
                                            width: screenSize.screenWidth * 15),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.screenWidth * 2),
                                          child: Container(
                                            width: screenSize.screenWidth * 50,
                                            height: screenSize.screenHeight * 8,
                                            child: cmOccurrenceTargetDate !=
                                                    null
                                                ? Center(
                                                    child: Text(
                                                        cmOccurrenceTargetDate
                                                                .day
                                                                .toString() +
                                                            " / " +
                                                            cmOccurrenceTargetDate
                                                                .month
                                                                .toString() +
                                                            " / " +
                                                            cmOccurrenceTargetDate
                                                                .year
                                                                .toString()),
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "Please select a date")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              //  getDatePicker(cmOccurrenceTargetDate),
                              getTextField('Responsibility', cmOccurrenceResp,
                                  'Enter Responsible Person', 1, 1),
                            ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.screenWidth * 5,
                            vertical: screenSize.screenWidth * 2),
                        child: Text("Preventive Measures",
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 3)),
                      ),
                      Container(
                        width: screenSize.screenWidth * 80,
                        child: Row(
                          children: [
                            Column(children: [
                              getTextField(
                                  "Preventive Outflow Prevention",
                                  pmOutflowController,
                                  "Enter Preventive Outflow Measure",
                                  5,
                                  5),
                              Container(
                                  width: screenSize.screenWidth * 30,
                                  //height: screenSize.screenHeight * 10,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(
                                          screenSize.screenHeight * 1)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.screenHeight,
                                        horizontal: screenSize.screenWidth * 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReusableButton(
                                            onPress: () async {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 730)),
                                              ).then((date) {
                                                pmOutflowTargetDate = date;
                                                setState(() {});
                                              });
                                            },
                                            content: "Target Date",
                                            height: screenSize.screenHeight * 5,
                                            width: screenSize.screenWidth * 15),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.screenWidth * 2),
                                          child: Container(
                                            width: screenSize.screenWidth * 50,
                                            height: screenSize.screenHeight * 8,
                                            child: pmOutflowTargetDate != null
                                                ? Center(
                                                    child: Text(
                                                        pmOutflowTargetDate.day
                                                                .toString() +
                                                            " / " +
                                                            pmOutflowTargetDate
                                                                .month
                                                                .toString() +
                                                            " / " +
                                                            pmOutflowTargetDate
                                                                .year
                                                                .toString()),
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "Please select a date")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              //getDatePicker(pmOutflowTargetDate),
                              getTextField('Responsibility', pmOutflowResp,
                                  'Enter Responsible Person', 1, 1),
                            ]),
                            Column(children: [
                              getTextField(
                                  "Preventive Occurrence Prevention",
                                  pmOccurrenceController,
                                  "Enter Preventive Occurrence Measure",
                                  5,
                                  5),
                              Container(
                                  width: screenSize.screenWidth * 30,
                                  //height: screenSize.screenHeight * 10,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(
                                          screenSize.screenHeight * 1)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.screenHeight,
                                        horizontal: screenSize.screenWidth * 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReusableButton(
                                            onPress: () async {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 730)),
                                              ).then((date) {
                                                pmOccurrenceTargetDate = date;
                                                setState(() {});
                                              });
                                            },
                                            content: "Target Date",
                                            height: screenSize.screenHeight * 5,
                                            width: screenSize.screenWidth * 15),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.screenWidth * 2),
                                          child: Container(
                                            width: screenSize.screenWidth * 50,
                                            height: screenSize.screenHeight * 8,
                                            child: pmOccurrenceTargetDate !=
                                                    null
                                                ? Center(
                                                    child: Text(
                                                        pmOccurrenceTargetDate
                                                                .day
                                                                .toString() +
                                                            " / " +
                                                            pmOccurrenceTargetDate
                                                                .month
                                                                .toString() +
                                                            " / " +
                                                            pmOccurrenceTargetDate
                                                                .year
                                                                .toString()),
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "Please select a date")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )), //getDatePicker(pmOccurrenceTargetDate),
                              getTextField('Responsibility', pmOccurrenceResp,
                                  'Enter Responsible Person', 1, 1),
                            ]),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.screenWidth * 1),
                          child: ReusableButton(
                            onPress: () async {
                              if (_formKey.currentState.validate()) {
                                if (cmOccurrenceTargetDate != null &&
                                    pmOccurrenceTargetDate != null &&
                                    cmOutflowTargetDate != null &&
                                    pmOutflowTargetDate != null) {
                                  isReady = false;
                                  setState(() {});
                                  globalQpcr.measures[widget.index]
                                          .correctiveMeasures.cmOutflowMeasure =
                                      cmOutflowController.text;
                                  globalQpcr
                                          .measures[widget.index]
                                          .correctiveMeasures
                                          .cmOccurrenceMeasure =
                                      cmOccurrenceController.text;
                                  globalQpcr.measures[widget.index]
                                          .preventiveMeasures.pmOutflowMeasure =
                                      pmOutflowController.text;
                                  globalQpcr
                                          .measures[widget.index]
                                          .preventiveMeasures
                                          .pmOccurrenceMeasure =
                                      pmOccurrenceController.text;

                                  globalQpcr
                                      .measures[widget.index]
                                      .correctiveMeasures
                                      .cmOutflowResp = cmOutflowResp.text;
                                  globalQpcr
                                      .measures[widget.index]
                                      .correctiveMeasures
                                      .cmOccurrenceResp = cmOccurrenceResp.text;
                                  globalQpcr
                                      .measures[widget.index]
                                      .preventiveMeasures
                                      .pmOccurrenceResp = pmOccurrenceResp.text;

                                  globalQpcr
                                      .measures[widget.index]
                                      .preventiveMeasures
                                      .pmOutflowResp = pmOutflowResp.text;

                                  globalQpcr
                                          .measures[widget.index]
                                          .correctiveMeasures
                                          .cmOutflowTargetDate =
                                      cmOutflowTargetDate;
                                  globalQpcr
                                          .measures[widget.index]
                                          .preventiveMeasures
                                          .pmOutflowTargetDate =
                                      pmOutflowTargetDate;
                                  globalQpcr
                                          .measures[widget.index]
                                          .correctiveMeasures
                                          .cmOccurrenceTargetDate =
                                      cmOccurrenceTargetDate;
                                  globalQpcr
                                          .measures[widget.index]
                                          .preventiveMeasures
                                          .pmOccurrenceTargetDate =
                                      pmOccurrenceTargetDate;
                                  Networking networking = Networking();
                                  QPCRList qpcrList = QPCRList();
                                  var data = qpcrList.QpcrToMap(globalQpcr);

                                  var d = await networking.postData(
                                      'QPCR/QPCRSave', {"newQPCR": data});
                                  globalQpcr = qpcrList.getQPCR(d);
                                  isReady = true;
                                  setState(() {});
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please enter target date");
                                }
                              }
                            },
                            content: "Save",
                          )),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              )),
      ),
    );
  }
}
