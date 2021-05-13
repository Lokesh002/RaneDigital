import 'package:flutter/material.dart';
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

  final _formKey = GlobalKey<FormState>();

  bool isReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pmOutflowController.text =
        globalQpcr.measures[widget.index].preventiveMeasures.pmOutflowMeasure;

    pmOccurrenceController.text = globalQpcr
        .measures[widget.index].preventiveMeasures.pmOccurrenceMeasure;
    cmOccurrenceController.text = globalQpcr
        .measures[widget.index].correctiveMeasures.cmOccurrenceMeasure;
    cmOutflowController.text =
        globalQpcr.measures[widget.index].correctiveMeasures.cmOutflowMeasure;
    isReady = true;
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
        height: screenSize.screenHeight * 75,
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
                        child: Text('Cause ${widget.index + 1}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(widget.qpcr2.measures[widget.index].cause),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.screenWidth * 5,
                            vertical: screenSize.screenWidth * 2),
                        child: Text("Corrective Measures"),
                      ),
                      Container(
                        width: screenSize.screenWidth * 80,
                        child: Row(
                          children: [
                            Container(
                              width: screenSize.screenWidth * 40,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.screenWidth * 5,
                                    vertical: screenSize.screenWidth * 1),
                                child: TextFormField(
                                    validator: (val) => val.length < 1
                                        ? 'Enter Corrective Outflow Measure'
                                        : null,
                                    controller: cmOutflowController,
                                    minLines: 5,
                                    maxLines: 5,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: screenSize.screenHeight * 2),
                                    // focusNode: focusNode,
                                    decoration: InputDecoration(
                                      hintText: 'Corrective Outflow Prevention',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenSize.screenHeight * 2)),
                                    )),
                              ),
                            ),
                            Container(
                              width: screenSize.screenWidth * 40,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.screenWidth * 5,
                                    vertical: screenSize.screenWidth * 1),
                                child: TextFormField(
                                    validator: (val) => val.length < 1
                                        ? 'Enter Corrective Occurrence Measure'
                                        : null,
                                    controller: cmOccurrenceController,
                                    minLines: 5,
                                    maxLines: 5,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: screenSize.screenHeight * 2),
                                    // focusNode: focusNode,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Corrective Occurrence Prevention',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenSize.screenHeight * 2)),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.screenWidth * 5,
                            vertical: screenSize.screenWidth * 2),
                        child: Text("Preventive Measures"),
                      ),
                      Container(
                        width: screenSize.screenWidth * 80,
                        child: Row(
                          children: [
                            Container(
                              width: screenSize.screenWidth * 40,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.screenWidth * 5,
                                    vertical: screenSize.screenWidth * 1),
                                child: TextFormField(
                                  validator: (val) => val.length < 1
                                      ? 'Enter Preventive Outflow Measure'
                                      : null,
                                  controller: pmOutflowController,
                                  textAlign: TextAlign.start,
                                  minLines: 5,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenSize.screenHeight * 2),
                                  // focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Preventive Outflow Prevention',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenSize.screenHeight * 2)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenSize.screenWidth * 40,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.screenWidth * 5,
                                    vertical: screenSize.screenWidth * 1),
                                child: TextFormField(
                                  validator: (val) => val.length < 1
                                      ? 'Enter Preventive Occurrence Measure'
                                      : null,
                                  minLines: 5,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenSize.screenHeight * 2),
                                  // focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Preventive Occurrence Prevention',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenSize.screenHeight * 2)),
                                  ),
                                  controller: pmOccurrenceController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.screenWidth * 1),
                          child: ReusableButton(
                            onPress: () async {
                              if (_formKey.currentState.validate()) {
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
                                Networking networking = Networking();
                                QPCRList qpcrList = QPCRList();
                                var data = qpcrList.QpcrToMap(globalQpcr);

                                var d = await networking.postData(
                                    'QPCR/QPCRSave', {"newQPCR": data});
                                globalQpcr = qpcrList.getQPCR(d);
                                isReady = true;
                                setState(() {});
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
