import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/pfuListMaker.dart';
import 'package:rane_dms/components/reusableMyPFUCard.dart';

import 'package:rane_dms/components/reusablePFUCard.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/pfu/closePfu/closeSteps/acceptPFUScreen.dart';
import 'package:rane_dms/screens/pfu/closePfu/closeSteps/confirmClosePFU.dart';
import 'package:rane_dms/screens/pfu/closePfu/closeSteps/deletePFUScreen.dart';
import 'package:rane_dms/screens/pfu/closePfu/closeSteps/enterPFUdetails.dart';
import 'package:rane_dms/screens/pfu/closePfu/closeSteps/pfuStandardizedScreen.dart';
import 'package:rane_dms/screens/pfu/closePfu/closeSteps/pfuTakeActionScreen.dart';
import 'package:rane_dms/screens/pfu/closePfu/myPFUStatusScreen.dart';

class MyPFUScreen extends StatefulWidget {
  final String selectedDepartment;
  MyPFUScreen(this.selectedDepartment);
  @override
  _MyPFUScreenState createState() => _MyPFUScreenState();
}

class _MyPFUScreenState extends State<MyPFUScreen> {
  bool isLoaded = false;
  List<PFU> pfuList = [];
  SavedData savedData = SavedData();

  Color getPFUColor(int status) {
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

    var data = await networking.postData('PFU/getPFU', {
      "status": "mineOpen",
      "raisingDepartment": myDept,
      "departmentResponsible": widget.selectedDepartment
    });

    PFUList pfuListMaker = PFUList();
    if (data != null) {
      pfuList = pfuListMaker.getPFUList(data);
    } else {
      //pfuList = pfuListMaker.getPFUList([]);
    }

    isLoaded = true;
    setState(() {});
  }

  Function moveNextPage(int status, PFU pfu) {
    switch (status) {
      case 4:
        return () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ConfirmClosePFUScreen(pfu);
            }));
          });
        };
      case 6:
        return () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DeletePFUScreen(pfu);
            }));
          });
        };
      default:
        return () {
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyPFUStatusScreen(pfu);
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
                        return ReusableMyPFUCard(
                          issueDate: (pfuList[index].raisingDate == null)
                              ? " "
                              : (pfuList[index].raisingDate.day.toString() +
                                  "/" +
                                  pfuList[index].raisingDate.month.toString() +
                                  "/" +
                                  pfuList[index].raisingDate.year.toString()),
                          status: pfuList[index].status,
                          color: getPFUColor(pfuList[index].status),
                          respDept: pfuList[index].deptResponsible,
                          problem: pfuList[index].problem,
                          machineCode: pfuList[index].machine.machineCode,
                          lineName: pfuList[index].lineName,
                          onTap: moveNextPage(
                              pfuList[index].status, pfuList[index]),
                        );
                      },
                      itemCount: pfuList.length,
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
