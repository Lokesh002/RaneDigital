import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/constants.dart';

import 'package:rane_dms/components/sizeConfig.dart';

import '../../../components/QPCRDataStructure.dart';
import '../../../components/networking.dart';

class MyQPCRStatusScreen extends StatefulWidget {
  final QPCR qpcr;
  MyQPCRStatusScreen(this.qpcr);
  @override
  _MyQPCRStatusScreenState createState() => _MyQPCRStatusScreenState();
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

class _MyQPCRStatusScreenState extends State<MyQPCRStatusScreen> {
  QPCR qpcr = QPCR();
  SizeConfig screenSize;
  Widget getElement(String about, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.screenWidth * 5,
          vertical: screenSize.screenHeight * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: screenSize.screenWidth * 25,
            child: Text(
              about,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: screenSize.screenHeight * 2.5,
                fontFamily: "Roboto",
              ),
            ),
          ),
          Container(
            width: screenSize.screenWidth * 65,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenSize.screenHeight * 2.5,
                fontFamily: "Roboto",
              ),
            ),
          ),
        ],
      ),
    );
  }

  String photo = ipAddress + 'QPCRpics/logo.png';
  bool isReady = false;
  void getData() async {
    Networking networking = Networking();
    var data =
        await networking.postData('QPCR/getQPCR', {"qpcrId": widget.qpcr.id});

    QPCRList qpcrList = QPCRList();
    qpcr = qpcrList.getQPCR(data);
    isReady = true;
    setState(() {});
  }

  TableRow getTableRow(String name, String value) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Center(
            child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: screenSize.screenHeight * 2.5,
              color: Theme.of(context).primaryColor),
        )),
      ),
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Center(
            child: Text(
          value,
          style: TextStyle(fontSize: screenSize.screenHeight * 2.5),
        )),
      )
    ]);
  }

  TableRow getFourColTableRow(
      String name1, String value1, String name2, String value2) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Center(
            child: Text(
          name1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: screenSize.screenHeight * 2.5,
              color: Theme.of(context).primaryColor),
        )),
      ),
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Center(
            child: (value1 != 'true' && value1 != 'false')
                ? Text(
                    value1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenSize.screenHeight * 2.5,
                    ),
                  )
                : SizedBox(
                    width: screenSize.screenWidth * 10,
                    child: Image.asset(
                      'images/$value1.png',
                      fit: BoxFit.contain,
                    ))),
      ),
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Center(
            child: Text(
          name2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: screenSize.screenHeight * 2.5,
              color: Theme.of(context).primaryColor),
        )),
      ),
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Center(
          child: (value2 != 'true' && value2 != 'false')
              ? Text(
                  value2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.screenHeight * 2.5,
                  ),
                )
              : SizedBox(
                  width: screenSize.screenWidth * 10,
                  child: Image.asset(
                    'images/$value2.png',
                    fit: BoxFit.contain,
                  )),
        ),
      ),
    ]);
  }

  dynamic getOperator(String key) {
    switch (key) {
      case 'receiptStage':
        return qpcr.detectionStage.receiptStage;
      case 'customerEnd':
        return qpcr.detectionStage.customerEnd;
      case 'pdi':
        return qpcr.detectionStage.pdi;
      case 'others':
        return qpcr.detectionStage.others;
      case 'machineName':
        return qpcr.detectionStage.detectionMachine.machineName;
    }
  }

  List a = ['receiptStage', 'customerEnd', 'pdi', 'others', 'machineName'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return !isReady
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black87,
              ),
            ),
          )
        : Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.screenHeight * 2.5),
                        child: Text(
                          'Quality Problem Report (QPCR)',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.screenHeight * 3.5,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.screenHeight * 2.5),
                        child: Column(
                          children: [
                            Text(
                              qpcr.qpcrNo,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenSize.screenHeight * 3,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 2,
                            ),
                            Text(
                              '${qpcr.defectRank} Rank Defect',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenSize.screenHeight * 3,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 3,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.screenWidth * 5),
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(3)
                                },
                                border: TableBorder.symmetric(
                                    outside: BorderSide(width: 3),
                                    inside: BorderSide(width: 1)),
                                children: [
                                  getTableRow(
                                      'QPCR Raised Date',
                                      qpcr.raisingDate
                                          .toString()
                                          .substring(0, 10)),
                                  getTableRow('Part Name', qpcr.partName),
                                  getTableRow('Part Number', qpcr.partNumber),
                                  getTableRow('Supplier', qpcr.deptResponsible),
                                  getTableRow(
                                      qpcr.lotCode == null
                                          ? 'Production Order Number'
                                          : 'Lot Code',
                                      qpcr.lotCode == null
                                          ? qpcr.productionOrderNumber
                                          : qpcr.lotCode),
                                  getTableRow(
                                      qpcr.supplierInvoiceNumber == null
                                          ? 'Production Order Quantity'
                                          : 'Supplier Invoice Number',
                                      qpcr.supplierInvoiceNumber == null
                                          ? qpcr.productionOrderQty.toString()
                                          : qpcr.supplierInvoiceNumber),
                                  getTableRow('Model', qpcr.model),
                                  if (qpcr.manufacturingDate
                                          .millisecondsSinceEpoch !=
                                      0)
                                    getTableRow(
                                        'Mfg. Date',
                                        qpcr.manufacturingDate
                                            .toString()
                                            .substring(0, 10)),
                                  getTableRow('Concern Type', qpcr.concernType),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Detection Stage",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.screenHeight * 3,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.screenWidth * 5),
                          child: Table(
                              columnWidths: {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(2),
                                3: (qpcr.detectionStage.detectionLine
                                                .lineName !=
                                            null &&
                                        qpcr.detectionStage.others != null)
                                    ? FlexColumnWidth(2)
                                    : FlexColumnWidth(1)
                              },
                              border: TableBorder.symmetric(
                                  outside: BorderSide(width: 3),
                                  inside: BorderSide(width: 1)),
                              children: [
                                getFourColTableRow(
                                    'Receipt Stage',
                                    qpcr.detectionStage.receiptStage != null
                                        ? qpcr.detectionStage.receiptStage
                                            .toString()
                                        : 'false',
                                    "Line Name",
                                    qpcr.detectionStage.detectionLine
                                                .lineName !=
                                            null
                                        ? qpcr.detectionStage.detectionLine
                                            .lineName
                                        : "false"),
                                getFourColTableRow(
                                    'Customer End',
                                    qpcr.detectionStage.customerEnd != null
                                        ? qpcr.detectionStage.customerEnd
                                            .toString()
                                        : 'false',
                                    "Machine Name",
                                    qpcr.detectionStage.detectionMachine
                                                .machineName !=
                                            null
                                        ? qpcr.detectionStage.detectionMachine
                                            .machineName
                                        : "false"),
                                getFourColTableRow(
                                    "PDI (Pre Dispatch Inspection)",
                                    qpcr.detectionStage.pdi != null
                                        ? qpcr.detectionStage.pdi.toString()
                                        : "false",
                                    'Others',
                                    qpcr.detectionStage.others != null
                                        ? qpcr.detectionStage.others.toString()
                                        : 'false')
                              ])),
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Complaint Details",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.screenHeight * 3,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.screenWidth * 5),
                          child: Table(
                              columnWidths: {
                                0: FlexColumnWidth(2),
                                1: qpcr.complaintImpactAreas.otherImpact != null
                                    ? FlexColumnWidth(2)
                                    : FlexColumnWidth(1),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(1)
                              },
                              border: TableBorder.symmetric(
                                  outside: BorderSide(width: 3),
                                  inside: BorderSide(width: 1)),
                              children: [
                                getFourColTableRow(
                                    "Safety",
                                    qpcr.complaintImpactAreas.safetyImpact !=
                                            null
                                        ? qpcr.complaintImpactAreas.safetyImpact
                                            .toString()
                                        : "false",
                                    "Functional",
                                    qpcr.complaintImpactAreas
                                                .functionalImpact !=
                                            null
                                        ? qpcr.complaintImpactAreas
                                            .functionalImpact
                                            .toString()
                                        : "false"),
                                getFourColTableRow(
                                    "Fitment",
                                    qpcr.complaintImpactAreas.fitmentImpact !=
                                            null
                                        ? qpcr
                                            .complaintImpactAreas.fitmentImpact
                                            .toString()
                                        : "false",
                                    "Visual",
                                    qpcr.complaintImpactAreas.visualImpact !=
                                            null
                                        ? qpcr.complaintImpactAreas.visualImpact
                                            .toString()
                                        : "false"),
                                getFourColTableRow(
                                    "Others",
                                    qpcr.complaintImpactAreas.otherImpact !=
                                            null
                                        ? qpcr.complaintImpactAreas.otherImpact
                                        : 'false',
                                    "",
                                    "")
                              ])),
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      ),
                      getElement("Problem", qpcr.problem),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.screenWidth * 5),
                          child: Table(
                              columnWidths: {
                                0: FlexColumnWidth(2.5),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1)
                              },
                              border: TableBorder.symmetric(
                                  outside: BorderSide(width: 3),
                                  inside: BorderSide(width: 1)),
                              children: [
                                getFourColTableRow('Problem Description',
                                    'Defect Rank', 'Defective Qty', '% Defect'),
                                getFourColTableRow(
                                    qpcr.problemDescription,
                                    qpcr.defectRank,
                                    qpcr.defectiveQuantity.toString(),
                                    qpcr.totalLotQty != null
                                        ? ((qpcr.defectiveQuantity * 100) /
                                                    qpcr.totalLotQty)
                                                .toStringAsFixed(2)
                                                .toString() +
                                            ' %'
                                        : ((qpcr.defectiveQuantity * 100) /
                                                    (qpcr.productionOrderQty +
                                                        qpcr.defectiveQuantity))
                                                .toStringAsFixed(2)
                                                .toString() +
                                            ' %')
                              ])),
                      getElement("Raising Department", qpcr.raisingDept),
                      getElement("Raising Person", qpcr.raisingPerson.username),
                      getElement("QPCR Accepted By:",
                          (qpcr.status >= 1) ? qpcr.acceptingPerson : "-"),
                      getElement(
                          "Target Submitting Date",
                          (qpcr.status >= 1)
                              ? qpcr.targetSubmittingDate
                                  .toString()
                                  .substring(0, 10)
                              : "-"),
                      Text(
                        "OK Image",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenSize.screenHeight * 3,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 50,
                        width: screenSize.screenWidth * 100,
                        child:
                            (qpcr.okPhotoURL == null || qpcr.okPhotoURL == "")
                                ? Image.network(
                                    photo,
                                    fit: BoxFit.contain,
                                  )
                                : Image.network(qpcr.okPhotoURL),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: screenSize.screenHeight * 3),
                        child: Text(
                          "NG Image",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.screenHeight * 3,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 50,
                        width: screenSize.screenWidth * 100,
                        child:
                            (qpcr.ngPhotoURL == null || qpcr.ngPhotoURL == "")
                                ? Image.network(
                                    photo,
                                    fit: BoxFit.contain,
                                  )
                                : Image.network(qpcr.ngPhotoURL),
                      ),
                      getElement(
                          'Status',
                          qpcr.status <= 0
                              ? "Not yet Accepted"
                              : "QPCR Accepted"),
                      SizedBox(
                        height: screenSize.screenHeight * 3,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
