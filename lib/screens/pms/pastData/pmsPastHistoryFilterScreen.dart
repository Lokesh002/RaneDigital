import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/homeScreen.dart';
import 'package:rane_dms/screens/pfu/generatePfu/addLineAndMachine/addMachineScreen.dart';
import 'package:rane_dms/screens/pfu/generatePfu/enterPfuDataScreen.dart';

class PMSPastDataFilterScreen extends StatefulWidget {
  @override
  _PMSPastDataFilterScreenState createState() =>
      _PMSPastDataFilterScreenState();
}

class _PMSPastDataFilterScreenState extends State<PMSPastDataFilterScreen> {
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

  String accountType;

  String dept;
  bool isLoaded = false;
  getLine() async {
    lineList = await lineDataStructure.getLines();

    this.isLoaded = true;
    dept = await savedData.getDepartment();
    setState(() {});
    accountType = await savedData.getAccountType();
  }

  @override
  void initState() {
    super.initState();
    getLine();
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
          children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Container(
                  width: screenSize.screenWidth * 80,
                  height: screenSize.screenHeight * 15,
                  child: Image.asset(
                    "images/logo.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: screenSize.screenHeight * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: screenSize.screenHeight * 2,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[]),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: screenSize.screenHeight * 6,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 10),
                            child: Text(
                              "Choose Line",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: screenSize.screenHeight * 2.5,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.screenHeight * 4,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenSize.screenWidth * 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: screenSize.screenWidth * 65,
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
                                                    screenSize.screenWidth * 3),
                                            child: DropdownButtonFormField(
                                              disabledHint: Text("Choose Line"),
                                              validator: (val) => val == null
                                                  ? 'Choose a Line'
                                                  : null,
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
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.screenWidth * 5),
                                  child: MaterialButton(
                                      onPressed: () {
                                        if (accountType == 'admin') {
                                          Navigator.pushNamed(
                                              context, '/addLineScreen');
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Only Admins can add Line.");
                                        }
                                      },
                                      elevation: 5.0,
                                      color: Colors.green,
                                      height: screenSize.screenHeight * 5,
                                      minWidth: screenSize.screenWidth * 5,
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .backgroundColor),
                                      )),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.screenHeight * 6,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.screenWidth * 10),
                            child: Text(
                              "Choose Machine",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: screenSize.screenHeight * 2.5,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.screenHeight * 6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenSize.screenWidth * 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: screenSize.screenWidth * 65,
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
                                                    screenSize.screenWidth * 3),
                                            child: DropdownButtonFormField(
                                              disabledHint:
                                                  Text("Choose Line First"),
                                              validator: (val) => val == null
                                                  ? 'Choose a Machine'
                                                  : null,
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
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.screenWidth * 5),
                                  child: MaterialButton(
                                      onPressed: () {
                                        if (accountType == 'admin') {
                                          if (this.selectedLine != null &&
                                              lineList != null) {
                                            Line line;
                                            for (int i = 0;
                                                i < lineList.length;
                                                i++) {
                                              if (lineList[i].lineId ==
                                                  selectedLine)
                                                line = lineList[i];
                                            }

                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return AddMachineScreen(line);
                                            }));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please select a line first.");
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Only Admins can add Machine.");
                                        }
                                      },
                                      elevation: 5.0,
                                      color: Colors.green,
                                      height: screenSize.screenHeight * 5,
                                      minWidth: screenSize.screenWidth * 5,
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .backgroundColor),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 6,
                    ),
                    Center(
                      child: ReusableButton(
                          height: screenSize.screenHeight * 8,
                          width: screenSize.screenWidth * 50,
                          content: "Proceed",
                          onPress: () {
                            if (lineList != null &&
                                _formKey.currentState.validate()) {
                              Line line;
                              Machines machine;
                              for (int i = 0; i < lineList.length; i++) {
                                if (lineList[i].lineId == selectedLine) {
                                  line = lineList[i];
                                  for (int j = 0;
                                      j < line.machines.length;
                                      j++) {
                                    if (line.machines[j].machineId ==
                                        selectedMachine) {
                                      machine = line.machines[j];
                                      break;
                                    }
                                  }
                                  break;
                                }
                              }

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EnterPFUDataScreen(line, machine, dept);
                              }));
                            } else {}
                          }),
                    ),
                    SizedBox(
                      height: screenSize.screenWidth * 5,
                    ),
                  ],
                )
              ]),
            ),
          ],
        ),
      );
    }
  }
}
