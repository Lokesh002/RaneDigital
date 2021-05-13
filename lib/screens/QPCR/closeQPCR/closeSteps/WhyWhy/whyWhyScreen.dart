import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/WhyWhy/occurenceWhyWhy.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/WhyWhy/whyWhytabBarScreen.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/measures/measuresFormScreen.dart';

class WhyWhyScreen extends StatefulWidget {
  @override
  _WhyWhyScreenState createState() => _WhyWhyScreenState();
}

class _WhyWhyScreenState extends State<WhyWhyScreen> {
  SizeConfig screenSize;

  Future _onDone() async {
    bool flag = false;

    for (int i = 0; i < globalQpcr.whyWhyAnalysis.length; i++) {
      log(globalQpcr.whyWhyAnalysis.length.toString() + 'ot sdasod');
      if (globalQpcr.whyWhyAnalysis[i].occurrenceWhyWhy == null ||
          globalQpcr.whyWhyAnalysis[i].occurrenceWhyWhy.length == 0) {
        flag = true;
      }

      if (globalQpcr.whyWhyAnalysis[i].detectionWhyWhy == null ||
          globalQpcr.whyWhyAnalysis[i].detectionWhyWhy.length == 0) {
        flag = true;
      }
    }
    log(flag.toString() + "hehh");
    if (flag) {
      Fluttertoast.showToast(
          msg: "please fill all Why Why data before proceeding.");
    } else {
      List<String> newMeasures = [];
      for (WhyWhyAnalysis w in globalQpcr.whyWhyAnalysis) {
        newMeasures.add(w.problem);
      }

      List<Measures> oldMeasures = [];
      oldMeasures.addAll(globalQpcr.measures);

      int oldIndex = 0;
      List<Measures> res = [];
      if (oldMeasures != null && oldMeasures.length != 0) {
        for (int i = 0; i < newMeasures.length; i++) {
          if (oldIndex < oldMeasures.length) {
            if (newMeasures[i] == oldMeasures[oldIndex].cause) {
              res.add(oldMeasures[oldIndex]);
              oldIndex++;
              print("true1");
            } else {
              bool flag = false;
              print(i);
              for (int j = oldIndex; j < oldMeasures.length; j++) {
                print("__$j");
                if (newMeasures[i] == oldMeasures[j].cause) {
                  print("true");
                  res.add(oldMeasures[j]);
                  oldMeasures.removeRange(oldIndex, j);
                  print("old: " + oldMeasures.toString());
                  flag = true;
                  oldIndex = oldIndex + 1;
                  break;
                }
              }

              if (!flag) {
                print(false);
                Measures measures = Measures();
                measures.cause = newMeasures[i];
                PreventiveMeasures preventiveMeasures = PreventiveMeasures();
                preventiveMeasures.pmOutflowMeasure = null;
                preventiveMeasures.pmOccurrencePhotoURL = null;
                preventiveMeasures.pmOccurrenceMeasure = null;
                preventiveMeasures.pmOutflowPhotoURL = null;

                measures.preventiveMeasures = preventiveMeasures;

                res.add(measures);
              }
            }
          } else {
            Measures measures = Measures();
            measures.cause = newMeasures[i];
            PreventiveMeasures preventiveMeasures = PreventiveMeasures();
            preventiveMeasures.pmOutflowMeasure = null;
            preventiveMeasures.pmOccurrencePhotoURL = null;
            preventiveMeasures.pmOccurrenceMeasure = null;
            preventiveMeasures.pmOutflowPhotoURL = null;

            measures.preventiveMeasures = preventiveMeasures;

            res.add(measures);
          }
        }
      } else {
        for (int i = 0; i < newMeasures.length; i++) {
          Measures measures = Measures();
          measures.cause = newMeasures[i];
          PreventiveMeasures preventiveMeasures = PreventiveMeasures();
          preventiveMeasures.pmOutflowMeasure = null;
          preventiveMeasures.pmOccurrencePhotoURL = null;
          preventiveMeasures.pmOccurrenceMeasure = null;
          preventiveMeasures.pmOutflowPhotoURL = null;

          measures.preventiveMeasures = preventiveMeasures;

          res.add(measures);
        }
      }

      globalQpcr.measures = res;
      log(globalQpcr.whyWhyAnalysis.length.toString() + "length of measures");
      Networking networking = Networking();
      QPCRList qpcrList = QPCRList();
      var data = qpcrList.QpcrToMap(globalQpcr);

      var d = await networking.postData('QPCR/QPCRSave', {"newQPCR": data});
      globalQpcr = qpcrList.getQPCR(d);
      // JsonEncoder encoder = JsonEncoder.withIndent("  ");
      // String pretty = encoder.convert(d);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MeasuresScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("WhyWhyAnalysis"),
      ),
      body: Container(
        width: screenSize.screenWidth * 100,
        height: screenSize.screenHeight * 100,
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: ReusableButton(
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WhyWhyTabBarScreen(index)));
                },
                content: globalQpcr.whyWhyAnalysis[index].problem,
                height: screenSize.screenHeight * 10,
                width: screenSize.screenWidth * 80),
          ),
          itemCount: globalQpcr.whyWhyAnalysis.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: screenSize.screenHeight * 4.2,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: screenSize.screenHeight * 3.8,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        onPressed: () async {
          _onDone();
        },
      ),
    );
  }
}
