import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/reusableMyQPCRCard.dart';

import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/confirmCloseQPCR.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/deleteQPCRScreen.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/myQPCRStatusScreen.dart';

class MyQPCRScreen extends StatefulWidget {
  final String selectedDepartment;
  MyQPCRScreen(this.selectedDepartment);
  @override
  _MyQPCRScreenState createState() => _MyQPCRScreenState();
}

class _MyQPCRScreenState extends State<MyQPCRScreen> {
  bool isLoaded = false;
  List<QPCR> qpcrList = [];
  SavedData savedData = SavedData();

  Color getQPCRColor(int status) {
    switch (status) {
      case 0:
        return Colors.blueGrey;
      case 1:
        return Color(0xffd1ffe6);
      case 2:
        return Color(0xff75f9b3);
      case 3:
        return Color(0xff0ef77b);
      case 4:
        return Colors.green;
      case 6:
        return Color(0xfffc7474);
      default:
        return Colors.black12;
    }
  }

  getData() async {
    print(widget.selectedDepartment);
    String myDept = await savedData.getDepartment();
    Networking networking = Networking();

    var data = await networking.postData('QPCR/getQPCR', {
      "status": "mineOpen",
      "raisingDepartment": myDept,
      "departmentResponsible": widget.selectedDepartment
    });

    QPCRList qpcrListMaker = QPCRList();
    if (data != null) {
      qpcrList = qpcrListMaker.getQPCRList(data);
    } else {
      //QPCRList = QPCRListMaker.getQPCRList([]);
    }

    isLoaded = true;
    setState(() {});
  }

  Function moveNextPage(int status, QPCR qpcr) {
    switch (status) {
      case 4:
        return () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ConfirmCloseQPCRScreen(qpcr);
            }));
          });
        };
      case 6:
        return () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DeleteQPCRScreen(qpcr);
            }));
          });
        };
      default:
        return () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyQPCRStatusScreen(qpcr);
            }));
          });
        };
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
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
          children: [
            Container(
              child: Column(children: <Widget>[
                Container(
                  height: screenSize.screenHeight * 80,
                  child: ListView.builder(
                      itemBuilder: (BuildContext cntxt, int index) {
                        return ReusableMyQPCRCard(
                          issueDate: (qpcrList[index].raisingDate == null)
                              ? " "
                              : (qpcrList[index].raisingDate.day.toString() +
                                  "/" +
                                  qpcrList[index].raisingDate.month.toString() +
                                  "/" +
                                  qpcrList[index].raisingDate.year.toString()),
                          status: qpcrList[index].status,
                          color: getQPCRColor(qpcrList[index].status),
                          respDept: qpcrList[index].deptResponsible,
                          problem: qpcrList[index].problem,
                          machineCode: qpcrList[index].machine.machineCode,
                          lineName: qpcrList[index].lineName,
                          onTap: moveNextPage(
                              qpcrList[index].status, qpcrList[index]),
                        );
                      },
                      itemCount: qpcrList.length,
                      padding: EdgeInsets.fromLTRB(
                          0,
                          screenSize.screenHeight * 2.5,
                          0,
                          screenSize.screenHeight * 2.5)),
                ),
              ]),
            ),
          ],
        ),
      );
    }
  }
}
