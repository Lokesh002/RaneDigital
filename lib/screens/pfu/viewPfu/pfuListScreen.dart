import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/pfuDataStructure.dart';
import 'package:rane_dms/components/reusablePfuListCard.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/components/changeRotation.dart';
import 'package:auto_orientation/auto_orientation.dart';

class PFUListScreen extends StatefulWidget {
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

  PFUListScreen(
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
  _PFUListScreenState createState() => _PFUListScreenState();
}

class _PFUListScreenState extends State<PFUListScreen> {
  SizeConfig screenSize;

  List<PFU> pfuList = [];
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
    PFUList pfuList = PFUList();
    var data = await networking.postData('PFU/getPFU', body);
    if (data != "Cannot get PFUs" && data != null) {
      this.pfuList = pfuList.getPFUList(data);
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
    AutoOrientation.landscapeRightMode();
    SizeConfig screenSize = SizeConfig(context);
    if (!isLoaded) {
      return WillPopScope(
        onWillPop: () async {
          setState(() {});
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Loading"),
          ),
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
        appBar: AppBar(
          title: Text("PFU List"),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: [
            Container(
              child: Column(children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Center(
                      child: Text("PFU List",
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
                                  "Machine",
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
                        return ReusablePFUListCard(
                            index: index,
                            rootCause: pfuList[index].rootCause,
                            description: pfuList[index].problemDescription,
                            status: pfuList[index].status,
                            effectingAreas: pfuList[index].effectingAreas,
                            deptResponsible: pfuList[index].deptResponsible,
                            raisingDepartment: pfuList[index].raisingDept,
                            raisingPerson: pfuList[index].raisingPerson,
                            acceptingPerson: pfuList[index].acceptingPerson,
                            date: (pfuList[index].raisingDate == null)
                                ? " "
                                : (pfuList[index].raisingDate.day.toString() +
                                    "/" +
                                    pfuList[index]
                                        .raisingDate
                                        .month
                                        .toString() +
                                    "/" +
                                    pfuList[index].raisingDate.year.toString()),
                            color: Colors.white,
                            action: pfuList[index].action,
                            targetDate: (pfuList[index].targetDate == null ||
                                    pfuList[index].targetDate == "")
                                ? " "
                                : (pfuList[index].targetDate.substring(8, 10) +
                                    "/" +
                                    pfuList[index].targetDate.substring(5, 7) +
                                    "/" +
                                    pfuList[index].targetDate.substring(0, 4)),
                            problem: pfuList[index].problem,
                            machine: pfuList[index].machine.machineCode,
                            line: pfuList[index].lineName,
                            actualClosingTime:
                                (pfuList[index].actualClosingTime == null ||
                                        pfuList[index].actualClosingTime == "")
                                    ? " "
                                    : (pfuList[index]
                                            .actualClosingTime
                                            .substring(8, 10) +
                                        "/" +
                                        pfuList[index]
                                            .actualClosingTime
                                            .substring(5, 7) +
                                        "/" +
                                        pfuList[index]
                                            .actualClosingTime
                                            .substring(0, 4)),
                            onChangeTap: () {},
                            onTap: () {});
                      },
                      itemCount: pfuList.length,
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
