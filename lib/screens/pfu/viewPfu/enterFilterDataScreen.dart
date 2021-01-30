import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/pfu/generatePfu/addLineAndMachine/addMachineScreen.dart';
import 'package:rane_dms/screens/pfu/viewPfu/pfuListScreen.dart';

class EnterFilterDataScreen extends StatefulWidget {
  @override
  _EnterFilterDataScreenState createState() => _EnterFilterDataScreenState();
}

class _EnterFilterDataScreenState extends State<EnterFilterDataScreen> {
  SizeConfig screenSize;
  DateTime fromDate;
  String status;
  DateTime toDate;
  String raisingDepartment;
  String responsibleDepartment;
  List departments = ["MED", "MFG", "PLE", "Store", "PPC", "QAD", "CorpMED"];
  String selectedLine;
  String selectedMachine;
  final _formKey = GlobalKey<FormState>();
  List<Line> lineList;

  LineDataStructure lineDataStructure = LineDataStructure();

  List<DropdownMenuItem> getLineList() {
    List<DropdownMenuItem> lineDropDownList = [];
    if (lineList != null) {
      for (int i = 0; i < lineList.length; i++) {
        var item = DropdownMenuItem(
          child: Text(lineList[i].lineName),
          value: lineList[i].lineId,
        );
        lineDropDownList.add(item);
      }
      return lineDropDownList;
    } else {
      return null;
    }
  }

  List<DropdownMenuItem> getMachines() {
    setState(() {});

    if (selectedLine != null) {
      isLoaded = false;
      int index;
      List<DropdownMenuItem> machineDropDownList = [];
      for (int i = 0; i < lineList.length; i++) {
        if (lineList[i].lineId == selectedLine) {
          index = i;
        }
      }

      List<Machines> machineList = lineList[index].machines;
      for (int i = 0; i < machineList.length; i++) {
        var item = DropdownMenuItem(
          child: Text(machineList[i].machineCode),
          value: machineList[i].machineId,
        );
        machineDropDownList.add(item);
      }
      isLoaded = true;
      return machineDropDownList;
    } else {
      return null;
    }
  }

  bool isLoaded = false;
  getLine() async {
    lineList = await lineDataStructure.getLines();

    this.isLoaded = true;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLine();
  }

//  setOrientation(BuildContext context) {
//    if (MediaQuery.of(context).orientation == Orientation.landscape) {
//      SystemChrome.setPreferredOrientations(
//          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
//    }
//  }

  List<DropdownMenuItem> getDepartmentList() {
    List<DropdownMenuItem> departmentList = [];
    for (int i = 0; i < departments.length; i++) {
      if (responsibleDepartment != departments[i]) {
        var item = DropdownMenuItem(
          child: Text(departments[i]),
          value: departments[i],
        );
        departmentList.add(item);
      }
    }

    return departmentList;
  }

  List<DropdownMenuItem> getRespDept() {
    List<DropdownMenuItem> respDepartmentList = [];
    for (int i = 0; i < departments.length; i++) {
      if (raisingDepartment != departments[i]) {
        var item = DropdownMenuItem(
          child: Text(departments[i]),
          value: departments[i],
        );
        respDepartmentList.add(item);
      }
    }

    return respDepartmentList;
  }

  List statuses = ["open", "closed"];
  List<DropdownMenuItem> getStatusList() {
    List<DropdownMenuItem> statusList = [];
    for (int i = 0; i < statuses.length; i++) {
      var item = DropdownMenuItem(
        child: Text(statuses[i]),
        value: statuses[i],
      );
      statusList.add(item);
    }

    return statusList;
  }

  @override
  Widget build(BuildContext context) {
    //setOrientation(context);
    screenSize = SizeConfig(context);
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
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 0),
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.screenHeight * 5),
                    child: Container(
                      child: Container(
                        width: screenSize.screenWidth * 80,
                        height: screenSize.screenHeight * 15,
                        child: Image.asset(
                          "images/logo.png",
                          fit: screenSize.screenWidth < screenSize.screenHeight
                              ? BoxFit.fitWidth
                              : BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.screenHeight * 2),
                    child: Container(
                      width: screenSize.screenWidth * 80,
                      height: screenSize.screenHeight * 25,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(
                              screenSize.screenHeight * 1)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.screenHeight,
                            horizontal: screenSize.screenWidth * 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableButton(
                                    onPress: () async {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now())
                                          .then((date) {
                                        fromDate = date;
                                        setState(() {});
                                      });
                                    },
                                    content: "From",
                                    height: screenSize.screenHeight * 7,
                                    width: screenSize.screenWidth * 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.screenWidth * 2),
                                  child: Container(
                                    width: screenSize.screenWidth * 50,
                                    height: screenSize.screenHeight * 8,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(
                                            screenSize.screenHeight * 1)),
                                    child: fromDate != null
                                        ? Center(
                                            child: Text(
                                                fromDate.day.toString() +
                                                    " / " +
                                                    fromDate.month.toString() +
                                                    " / " +
                                                    fromDate.year.toString()),
                                          )
                                        : Center(child: Text("")),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableButton(
                                    onPress: () async {
                                      if (fromDate != null) {
                                        showDatePicker(
                                                context: context,
                                                initialDate: fromDate,
                                                firstDate: fromDate,
                                                lastDate: DateTime.now()
                                                            .compareTo(fromDate
                                                                .add(Duration(
                                                                    days:
                                                                        30))) >
                                                        0
                                                    ? fromDate
                                                        .add(Duration(days: 30))
                                                    : DateTime.now())
                                            .then((date) {
                                          toDate = date.add(Duration(days: 1));
                                          setState(() {});
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please enter from date first.");
                                      }
                                    },
                                    content: "To",
                                    height: screenSize.screenHeight * 7,
                                    width: screenSize.screenWidth * 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.screenWidth * 2),
                                  child: Container(
                                    width: screenSize.screenWidth * 50,
                                    height: screenSize.screenHeight * 8,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(
                                            screenSize.screenHeight * 1)),
                                    child: toDate != null
                                        ? Center(
                                            child: Text(toDate
                                                    .subtract(Duration(days: 1))
                                                    .day
                                                    .toString() +
                                                " / " +
                                                toDate.month.toString() +
                                                " / " +
                                                toDate.year.toString()),
                                          )
                                        : Center(child: Text("")),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.screenWidth * 2),
                    child: Container(
                      width: screenSize.screenWidth * 80,
                      height: screenSize.screenHeight * 15,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(
                              screenSize.screenHeight * 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Raising \nDepartment:  "),
                          Container(
                              width: screenSize.screenWidth * 50,
                              height: screenSize.screenHeight * 11,
                              child: Material(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(screenSize.screenHeight * 1),
                                ),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 3),
                                      child: DropdownButton(
                                        disabledHint:
                                            Text("Choose Raising Department"),
//                          validator: (val) => val == null
////                              ? 'Select Raising Department'
////                              : null,
                                        elevation: 7,
                                        isExpanded: false,
                                        hint: Text('Choose',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor)),
                                        value: raisingDepartment,
                                        items: getDepartmentList(),
                                        onChanged: (value) {
                                          raisingDepartment = value;
                                          print(
                                              'selected1: $raisingDepartment');

                                          setState(() {});
                                        },
                                      )),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.screenWidth * 2),
                    child: Container(
                      width: screenSize.screenWidth * 80,
                      height: screenSize.screenHeight * 15,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(
                              screenSize.screenHeight * 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Responsible \nDepartment:  "),
                          Container(
                              width: screenSize.screenWidth * 50,
                              height: screenSize.screenHeight * 11,
                              child: Material(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(screenSize.screenHeight * 1),
                                ),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 3),
                                      child: DropdownButton(
                                        disabledHint: Text(
                                            "Choose Responsible Department"),
//                          validator: (val) => val == null
////                              ? 'Select Raising Department'
////                              : null,
                                        elevation: 7,
                                        isExpanded: false,
                                        hint: Text('Choose',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor)),
                                        value: responsibleDepartment,
                                        items: getRespDept(),
                                        onChanged: (value) {
                                          responsibleDepartment = value;
                                          print(
                                              'selected1: $responsibleDepartment');

                                          setState(() {});
                                        },
                                      )),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.screenWidth * 2),
                    child: Container(
                      width: screenSize.screenWidth * 80,
                      height: screenSize.screenHeight * 15,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(
                              screenSize.screenHeight * 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Status:   "),
                          Container(
                              width: screenSize.screenWidth * 50,
                              height: screenSize.screenHeight * 11,
                              child: Material(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(screenSize.screenHeight * 1),
                                ),
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screenSize.screenWidth * 3),
                                      child: DropdownButton(
                                        disabledHint: Text("Choose Status"),
//                          validator: (val) => val == null
////                              ? 'Select Raising Department'
////                              : null,
                                        elevation: 7,
                                        isExpanded: false,
                                        hint: Text('Choose',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor)),
                                        value: status,
                                        items: getStatusList(),
                                        onChanged: (value) {
                                          status = value;
                                          print('selected1: $status');

                                          setState(() {});
                                        },
                                      )),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 2,
                  ),
                  //Choose Line
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenSize.screenWidth * 80,
                        height: screenSize.screenHeight * 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(
                                screenSize.screenHeight * 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.screenWidth * 2),
                              child: Text(
                                "Choose Line: ",
//                            style: TextStyle(
//                              color: Theme.of(context).primaryColor,
//                              fontSize: screenSize.screenHeight * 2.5,
//                              fontFamily: "Montserrat",
//                              fontWeight: FontWeight.normal,
//                            ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.screenWidth * 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: screenSize.screenWidth * 50,
                                      height: screenSize.screenHeight * 11,
                                      child: Material(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              screenSize.screenHeight * 1),
                                        ),
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.screenWidth *
                                                          3),
                                              child: DropdownButton(
                                                disabledHint:
                                                    Text("Choose Line"),
//                                            validator: (val) => val == null
//                                                ? 'Choose a Line'
//                                                : null,
                                                elevation: 7,
                                                isExpanded: false,
                                                hint: Text('Choose',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor)),
                                                value: selectedLine,
                                                items: getLineList(),
                                                onChanged: (value) {
                                                  selectedLine = value;

//                                                    'selected1: $selectedLine');

                                                  setState(() {});
                                                },
                                              )),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 2,
                      ),
                      Container(
                        width: screenSize.screenWidth * 80,
                        height: screenSize.screenHeight * 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(
                                screenSize.screenHeight * 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.screenWidth * 2),
                              child: Text(
                                "Choose \nMachine: ",
//                            style: TextStyle(
//                              color: Theme.of(context).primaryColor,
//                              fontSize: screenSize.screenHeight * 2.5,
//                              fontFamily: "Montserrat",
//                              fontWeight: FontWeight.normal,
//                            ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.screenWidth * 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: screenSize.screenWidth * 50,
                                      height: screenSize.screenHeight * 11,
                                      child: Material(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              screenSize.screenHeight * 1),
                                        ),
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.screenWidth *
                                                          3),
                                              child: DropdownButton(
                                                disabledHint:
                                                    Text("Choose Line First"),
//                                            validator: (val) => val == null
//                                                ? 'Choose a Machine'
//                                                : null,
                                                elevation: 7,
                                                isExpanded: false,
                                                items: getMachines(),
                                                hint: Text('Choose',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor)),
                                                value: selectedMachine,
                                                onChanged: (value) {
                                                  selectedMachine = value;
                                                  print(
                                                      'selected1: $selectedMachine');

                                                  setState(() {});
                                                },
                                              )),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.screenHeight * 3,
                  ),
                  MaterialButton(
                      onPressed: () {
                        raisingDepartment = null;
                        responsibleDepartment = null;
                        status = null;
                        selectedLine = null;
                        selectedMachine = null;
                        setState(() {});
                        //if (fromDate != null && toDate != null) {}
                      },
                      child: Text(
                        "Reset All",
                        style:
                            TextStyle(color: Theme.of(context).backgroundColor),
                      ),
                      color: Colors.redAccent,
                      height: screenSize.screenHeight * 5,
                      minWidth: screenSize.screenWidth * 40),
                  SizedBox(
                    height: screenSize.screenHeight * 3,
                  ),
                  MaterialButton(
                      onPressed: () async {
                        raisingDepartment = null;
                        setState(() {});
                        if (fromDate != null && toDate != null) {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PFUListScreen(
                              fromDate: fromDate,
                              line: selectedLine,
                              machine: selectedMachine,
                              raisingDepartment: raisingDepartment,
                              responsibleDepartment: responsibleDepartment,
                              status: status,
                              toDate: toDate,
                            );
                          }));
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Please select 'From Date' and 'To Date' first.");
                        }
                      },
                      child: Text(
                        "Proceed",
                        style:
                            TextStyle(color: Theme.of(context).backgroundColor),
                      ),
                      color: Theme.of(context).primaryColor,
                      height: screenSize.screenHeight * 10,
                      minWidth: screenSize.screenWidth * 100),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
