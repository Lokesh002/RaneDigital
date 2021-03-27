import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/reusableQPCRListCard.dart';
import 'package:rane_dms/components/reusableQPCRListCard.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/components/changeRotation.dart';
import 'package:auto_orientation/auto_orientation.dart';

class QPCRListScreen extends StatefulWidget {
  final DateTime fromDate;
  final DateTime toDate;
  final String raisingDepartment;
  final String responsibleDepartment;
  final String status;
  final String line;
  final String machine;
  final bool impactProd;
  final bool impactQual;
  final bool impactCost;
  final bool impactDisp;
  final bool impactSafe;
  final bool impactMora;
  final bool impactEnvi;

  QPCRListScreen(
      {this.fromDate,
      this.toDate,
      this.raisingDepartment,
      this.status,
      this.machine,
      this.line,
      this.responsibleDepartment,
      this.impactCost,
      this.impactDisp,
      this.impactEnvi,
      this.impactMora,
      this.impactProd,
      this.impactQual,
      this.impactSafe});

  @override
  _QPCRListScreenState createState() => _QPCRListScreenState();
}

class _QPCRListScreenState extends State<QPCRListScreen> {
  SizeConfig screenSize;

  List<QPCR> qpcrList = [];
  Map<String, dynamic> body = Map<String, dynamic>();
  getBody() {
    body["fromDate"] = widget.fromDate.toString().substring(0, 10);
    body["toDate"] = widget.toDate.toString().substring(0, 10);

    if (widget.raisingDepartment != null) {
      body["raisingDepartment"] = widget.raisingDepartment;
      print(widget.raisingDepartment);
    }
    if (widget.responsibleDepartment != null) {
      body["departmentResponsible"] = widget.responsibleDepartment;
      print(widget.responsibleDepartment);
    }
    if (widget.status != null) {
      body["status"] = widget.status;
      print(widget.status);
    }
    if (widget.machine != null) {
      body["machineId"] = widget.machine;
      print(widget.machine);
    }
    if (widget.line != null) {
      body["lineId"] = widget.line;
      print(widget.line);
    }
    body['impactProd'] = widget.impactProd;
    body['impactQual'] = widget.impactQual;
    body['impactCost'] = widget.impactCost;
    body['impactDisp'] = widget.impactDisp;
    body['impactSafe'] = widget.impactSafe;
    body['impactMora'] = widget.impactMora;
    body['impactEnvi'] = widget.impactEnvi;
  }

  bool isLoaded = false;
  getData() async {
    Networking networking = Networking();
    getBody();
    QPCRList qpcrList = QPCRList();
    var data = await networking.postData('qpcr/getqpcr', body);
    if (data != "Cannot get qpcrs" && data != null) {
      this.qpcrList = qpcrList.getQPCRList(data);
      print("hahaha" + data.toString());

      isLoaded = true;

      setState(() {});
    } else {
      print(data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  setOrientation(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //setOrientation(context);
    AutoOrientation.landscapeRightMode();
    SizeConfig screenSize = SizeConfig(context);
    if (!isLoaded) {
      return WillPopScope(
        onWillPop: () async {
          setState(() {});
          return true;
        },
        child: Scaffold(
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
                  width: double.infinity,
                  child: Center(
                      child: Text("qpcr List",
                          style: TextStyle(
                              fontSize: screenSize.screenHeight * 5))),
                  height: screenSize.screenHeight * 7,
                ),
                SizedBox(
                  height: screenSize.screenHeight * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.screenWidth * 2.5),
                  child: Container(
                    width: screenSize.screenWidth * 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenSize.screenWidth * 10,
                        ),
                        Container(
                          width: screenSize.screenWidth * 10,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              children: [
                                Text(
                                  "Line",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                                Text(
                                  "Machine\n",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                                Text(
                                  "Raising Person",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.screenWidth * 10,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Problem",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                                Text(
                                  "Effecting\nAreas",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.screenWidth * 15,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Problem Description",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.screenWidth * 10,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Root Cause",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.screenWidth * 10,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Action",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.screenWidth * 10,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Responsiblity",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 2.3),
                                ),
                                SizedBox(
                                  height: screenSize.screenHeight * 2,
                                ),
                                Text(
                                  "Target Date",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.screenWidth * 10,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Status",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.screenWidth * 10,
                          height: screenSize.screenHeight * 20,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.blueGrey,
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Actual Closing Date",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.screenHeight * 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: screenSize.screenHeight * 80,
                  //width: screenSize.screenWidth * 80,
                  child: ListView.builder(
                      itemBuilder: (BuildContext cntxt, int index) {
                        return ReusableQPCRListCard(
                            index: index,
                            rootCause: qpcrList[index].rootCause,
                            description: qpcrList[index].problemDescription,
                            status: qpcrList[index].status,
                            effectingAreas: qpcrList[index].effectingAreas,
                            deptResponsible: qpcrList[index].deptResponsible,
                            raisingDepartment: qpcrList[index].raisingDept,
                            raisingPerson: qpcrList[index].raisingPerson,
                            acceptingPerson: qpcrList[index].acceptingPerson,
                            date: (qpcrList[index].raisingDate == null)
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
                            color: Colors.white,
                            action: qpcrList[index].action,
                            targetDate: (qpcrList[index].targetDate == null ||
                                    qpcrList[index].targetDate == "")
                                ? " "
                                : (qpcrList[index].targetDate.substring(8, 10) +
                                    "/" +
                                    qpcrList[index].targetDate.substring(5, 7) +
                                    "/" +
                                    qpcrList[index].targetDate.substring(0, 4)),
                            problem: qpcrList[index].problem,
                            machine: qpcrList[index].machine.machineCode,
                            line: qpcrList[index].lineName,
                            actualClosingTime:
                                (qpcrList[index].actualClosingTime == null ||
                                        qpcrList[index].actualClosingTime == "")
                                    ? " "
                                    : (qpcrList[index]
                                            .actualClosingTime
                                            .substring(8, 10) +
                                        "/" +
                                        qpcrList[index]
                                            .actualClosingTime
                                            .substring(5, 7) +
                                        "/" +
                                        qpcrList[index]
                                            .actualClosingTime
                                            .substring(0, 4)),
                            onChangeTap: () {},
                            onTap: () {});
                      },
                      itemCount: qpcrList.length,
                      padding: EdgeInsets.fromLTRB(
                          0,
                          screenSize.screenHeight * 2.5,
                          0,
                          screenSize.screenHeight * 2.5)),
                ),
                SizedBox(
                  height: screenSize.screenHeight * 10,
                )
              ]),
            ),
          ],
        ),
      );
    }
  }
}
