import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/reusableValidationCard.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/WhyWhy/whyWhyScreen.dart';

class CauseValidationScreen extends StatefulWidget {
  final QPCR qpcr;
  CauseValidationScreen(this.qpcr);
  @override
  _CauseValidationScreenState createState() => _CauseValidationScreenState();
}

class _CauseValidationScreenState extends State<CauseValidationScreen> {
  QPCR qpcr2 = null;
  var specTECs = <TextEditingController>[];
  var isValidTECs = [];
  var remarksTECs = <TextEditingController>[];
  List<String> causes = [];
  List<bool> isValidList = [];
  List<String> remarksList = [];
  List<String> SpecificationList = [];

  var cards = <Card>[];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future _onDone() async {
    bool flag = false;
    bool allInvalid = true;
    for (int i = 0; i < globalQpcr.validationReports.length; i++) {
      if (globalQpcr.validationReports[i].cause == null ||
          globalQpcr.validationReports[i].cause == "") {
        flag = true;
      }

      if (globalQpcr.validationReports[i].specification == null ||
          globalQpcr.validationReports[i].specification == "") {
        flag = true;
      }
      if (globalQpcr.validationReports[i].isValid == null) {
        flag = true;
      }
      if (globalQpcr.validationReports[i].isValid == true) {
        allInvalid = false;
      }
      if (globalQpcr.validationReports[i].remarks == null ||
          globalQpcr.validationReports[i].remarks == "") {
        flag = true;
      }
    }
    if (flag) {
      Fluttertoast.showToast(
          msg: "please fill validation report and save before proceeding.");
    } else {
      if (allInvalid) {
        Fluttertoast.showToast(msg: "All causes cannot be Invalid");
      } else {
        List<String> newWhyWhy = [];
        for (ValidationReport v in globalQpcr.validationReports) {
          if (v.isValid) {
            newWhyWhy.add(v.cause);
          }
        }

        List<WhyWhyAnalysis> oldWhyWhy = [];
        oldWhyWhy.addAll(globalQpcr.whyWhyAnalysis);

        int oldIndex = 0;
        List<WhyWhyAnalysis> res = [];
        if (oldWhyWhy != null && oldWhyWhy.length != 0) {
          for (int i = 0; i < newWhyWhy.length; i++) {
            if (oldIndex < oldWhyWhy.length) {
              if (newWhyWhy[i] == oldWhyWhy[oldIndex].problem) {
                res.add(oldWhyWhy[oldIndex]);
                oldIndex++;
                print("true1");
              } else {
                bool flag = false;
                print(i);
                for (int j = oldIndex; j < oldWhyWhy.length; j++) {
                  print("__$j");
                  if (newWhyWhy[i] == oldWhyWhy[j].problem) {
                    print("true");
                    res.add(oldWhyWhy[j]);
                    oldWhyWhy.removeRange(oldIndex, j);
                    print("old: " + oldWhyWhy.toString());
                    flag = true;
                    oldIndex = oldIndex + 1;
                    break;
                  }
                }

                if (!flag) {
                  print(false);
                  WhyWhyAnalysis whyWhyAnalysis = WhyWhyAnalysis();
                  whyWhyAnalysis.problem = newWhyWhy[i];
                  whyWhyAnalysis.id = null;
                  whyWhyAnalysis.detectionWhyWhy = null;
                  whyWhyAnalysis.detectionWhyWhy = null;
                  res.add(whyWhyAnalysis);
                }
              }
            } else {
              WhyWhyAnalysis whyWhyAnalysis = WhyWhyAnalysis();
              whyWhyAnalysis.problem = newWhyWhy[i];
              whyWhyAnalysis.id = null;
              whyWhyAnalysis.detectionWhyWhy = null;
              whyWhyAnalysis.detectionWhyWhy = null;
              res.add(whyWhyAnalysis);
            }
          }
        } else {
          for (int i = 0; i < newWhyWhy.length; i++) {
            WhyWhyAnalysis whyWhyAnalysis = WhyWhyAnalysis();
            whyWhyAnalysis.problem = newWhyWhy[i];
            whyWhyAnalysis.id = i;
            whyWhyAnalysis.detectionWhyWhy = null;
            whyWhyAnalysis.detectionWhyWhy = null;
            res.add(whyWhyAnalysis);
          }
        }

        globalQpcr.whyWhyAnalysis = res;

        Networking networking = Networking();
        QPCRList qpcrList = QPCRList();
        var data = qpcrList.QpcrToMap(globalQpcr);

        var d = await networking.postData('QPCR/QPCRSave', {"newQPCR": data});
        globalQpcr = qpcrList.getQPCR(d);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WhyWhyScreen()));
      }
    }
  }

  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cause Validation'),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: screenSize.screenHeight * 1,
                bottom: screenSize.screenHeight * 1,
                right: screenSize.screenWidth * 5),
            child: MaterialButton(
              onPressed: () async {
                await _onDone();
              },
              color: Colors.white,
              elevation: 5,
              height: screenSize.screenHeight * 5,
              minWidth: screenSize.screenWidth * 20,
              child: Text(
                'Next',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: globalQpcr.validationReports.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.screenHeight * 1,
                        horizontal: screenSize.screenWidth * 2),
                    child: ValidationCard(
                      index: index,
                      qpcr2: globalQpcr,
                    ),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: RaisedButton(
            //       color: Colors.green,
            //       child: Text(
            //         'add new',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       onPressed: () => createCard()),
            // ),
          ],
        ),
      ),
    );
  }
}
