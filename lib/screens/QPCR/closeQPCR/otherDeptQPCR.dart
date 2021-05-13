import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/reusableCourseCard.dart';
import 'package:rane_dms/components/reusableQPCRCard.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/QPCRStandardizedScreen.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/QPCRTakeActionScreen.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/acceptQPCRScreen.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/enterQPCRdetails.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/myQPCRStatusScreen.dart';

class OtherDeptQPCR extends StatefulWidget {
  final String selectedDepartment;

  OtherDeptQPCR(this.selectedDepartment);
  @override
  _OtherDeptQPCRState createState() => _OtherDeptQPCRState();
}

class _OtherDeptQPCRState extends State<OtherDeptQPCR> {
  bool isLoaded = false;
  List<QPCR> qpcrList = [];
  SavedData savedData = SavedData();

  getData() async {
    String myDept = await savedData.getDepartment();
    Networking networking = Networking();
    print(widget.selectedDepartment);
    print(myDept);

    var data = await networking.postData('QPCR/getQPCRListShort', {
      "status": "open",
      "raisingDepartment": widget.selectedDepartment,
      "departmentResponsible": myDept
    });
    print(data);
    QPCRList qpcrListMaker = QPCRList();
    if (data != null) {
      qpcrList = qpcrListMaker.getQPCRShortList(data);
    } else {
      //QPCRList = QPCRListMaker.getQPCRList([]);
    }

    isLoaded = true;
    setState(() {});
  }

  Function moveNextPage(int status, QPCR qpcr) {
    switch (status) {
      case 0:
        return () {
          setState(() {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return AcceptQPCRScreen(qpcr);
            // }));
          });
        };
      case 1:
        return () {
          setState(() {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return EnterQPCRDetails(qpcr);
            // }));
          });
        };
      case 2:
        return () {
          setState(() {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return QPCRTakeActionScreen(qpcr);
            // }));
          });
        };
      case 3:
        return () {
          setState(() {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return QPCRStandardizeScreen(qpcr);
            // }));
          });
        };
      case 4:
        return () {
          setState(() {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return MyQPCRStatusScreen(qpcr);
            // }));
          });
        };

      default:
        return () {
          setState(() {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return AcceptQPCRScreen(qpcr);
            // }));
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
      case 5:
        return Colors.green;
      case 6:
        return Colors.redAccent;
      default:
        return Colors.white;
    }
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
                        print(qpcrList[index].raisingDate);
                        return ReusableQPCRCard(
                            defectRank: qpcrList[index].defectRank,
                            issueDate: (qpcrList[index].raisingDate == null)
                                ? " "
                                : (qpcrList[index].raisingDate.day.toString() +
                                    "/" +
                                    qpcrList[index]
                                        .raisingDate
                                        .month
                                        .toString() +
                                    "/" +
                                    qpcrList[index]
                                        .raisingDate
                                        .year
                                        .toString()),
                            status: qpcrList[index].status,
                            color: getQPCRColor(qpcrList[index].status),
                            raisingDept: qpcrList[index].raisingDept,
                            qpcrNo: qpcrList[index].qpcrNo,
                            concernType: qpcrList[index].concernType,
                            partName: qpcrList[index].partName,
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AcceptQPCRScreen(qpcrList[index])));
                            });
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
