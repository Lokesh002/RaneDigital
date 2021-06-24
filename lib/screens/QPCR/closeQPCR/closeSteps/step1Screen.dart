import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';
//import 'file:///D:/Projects/Flutter/rane_dms/rane_dms/lib/screens/QPCR/closeQPCR/closeSteps/FishBone/manFishBone.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/FishBone/FishBoneTabScreen.dart';

class Step1Screen extends StatefulWidget {
  final QPCR qpcr;
  Step1Screen(this.qpcr);
  @override
  _Step1ScreenState createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  SizeConfig screenSize;
  String temporaryAction;
  QPCR qpcr1;
  List partsCheckedAt = ['Rane NSK', 'Supplier', 'Others(Transit/Warehouse)'];
  List selectedPartsCheckedAt = [];

  DateTime _dateTime;

  DateTime _segDateTime;
  final _formKey = GlobalKey<FormState>();
  var parts;

  List<DropdownMenuItem> getNameList() {
    List<DropdownMenuItem> nameList = [];

    for (int i = 0; i < partsCheckedAt.length; i++) {
      var item = DropdownMenuItem(
        child: Text(partsCheckedAt[i]),
        value: partsCheckedAt[i],
      );
      nameList.add(item);
    }

    return nameList;
  }

  // CourseCard createCard(int index, BuildContext context) {
  var okQtyController = TextEditingController();
  var rejQtyBefReworkController = TextEditingController();
  var sapQtyCheckController = TextEditingController();
  var rewQtyController = TextEditingController();
  var rewOkQtyController = TextEditingController();
  var remarksController = TextEditingController();
  //
  //   rejQtyBefReworkTECs.add(rejQtyBefReworkController);
  //   sapQtyCheckTECs.add(sapQtyCheckController);
  //   rewQtyTECs.add(rewQtyController);
  //   rewOkQtyTECs.add(rewOkQtyController);
  //   remarksTECs.add(remarksController);
  //
  //   return CourseCard(
  //     cardChild: Padding(
  //       padding: const EdgeInsets.all(15),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('Detail ${index + 1}'),
  //           ),
  //           DropdownButtonFormField(
  //             decoration: InputDecoration(
  //                 fillColor: Colors.white,
  //                 filled: true,
  //                 labelText: 'Parts checked At'),
  //             items: getNameList(),
  //             onChanged: (v) {
  //               selectedPartsCheckedAt.add(v);
  //               if (v != "Others(Transit/Warehouse)") {
  //                 partsCheckedAt.remove(v);
  //               }
  //             },
  //             value: selectedPartsCheckedAt.length > index
  //                 ? selectedPartsCheckedAt[index]
  //                 : null,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               MaterialButton(
  //                 color: Colors.blueGrey,
  //                 child: Text(
  //                   "Occurring date",
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 12,
  //                     fontFamily: "Roboto",
  //                   ),
  //                 ),
  //                 height: 30,
  //                 minWidth: 100,
  //                 onPressed: () async {
  //                   showDatePicker(
  //                           context: context,
  //                           initialDate: DateTime.now(),
  //                           firstDate: DateTime(0),
  //                           lastDate: DateTime.now())
  //                       .then((date) {
  //                     setState(() {
  //                       _dateTime = date;
  //                       print(_dateTime.toString());
  //                     });
  //                   });
  //                 },
  //               ),
  //               SizedBox(
  //                 height: 6,
  //               ),
  //               Text(_dateTime != null
  //                   ? _dateTime
  //                       .subtract(Duration(days: 1))
  //                       .toString()
  //                       .substring(0, 10)
  //                   : " Please select a Date"),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               MaterialButton(
  //                 color: Colors.blueGrey,
  //                 child: Text(
  //                   "Segregation date",
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 12,
  //                     fontFamily: "Roboto",
  //                   ),
  //                 ),
  //                 height: 30,
  //                 minWidth: 100,
  //                 onPressed: () async {
  //                   showDatePicker(
  //                           context: context,
  //                           initialDate: DateTime.now(),
  //                           firstDate: DateTime(0),
  //                           lastDate: DateTime.now())
  //                       .then((date) {
  //                     setState(() {
  //                       _segDateTime = date;
  //                       print(_segDateTime.toString());
  //                     });
  //                   });
  //                 },
  //               ),
  //               SizedBox(
  //                 height: 6,
  //               ),
  //               Text(_segDateTime != null
  //                   ? _segDateTime
  //                       .subtract(Duration(days: 1))
  //                       .toString()
  //                       .substring(0, 10)
  //                   : " Please select a Date"),
  //             ],
  //           ),
  //           TextFormField(
  //               initialValue: qpcr1.segregationDetails.length != 0
  //                   ? qpcr1.segregationDetails[index].rejectedQtyBeforeRework
  //                       .toString()
  //                   : null,
  //               controller: rejQtyBefReworkController,
  //               decoration: InputDecoration(
  //                   labelText: 'Rejected Qty before Rework',
  //                   fillColor: Colors.white,
  //                   filled: true)),
  //           TextFormField(
  //               initialValue: qpcr1.segregationDetails.length != 0
  //                   ? qpcr1.segregationDetails[index].remarks
  //                   : null,
  //               controller: sapQtyCheckController,
  //               decoration: InputDecoration(
  //                   labelText: 'SAP Qty to be Checked',
  //                   fillColor: Colors.white,
  //                   filled: true)),
  //           TextFormField(
  //               initialValue: qpcr1.segregationDetails.length != 0
  //                   ? qpcr1.segregationDetails[index].remarks
  //                   : null,
  //               controller: rewQtyController,
  //               decoration: InputDecoration(
  //                   labelText: 'Rework Qty',
  //                   fillColor: Colors.white,
  //                   filled: true)),
  //           TextFormField(
  //               initialValue: qpcr1.segregationDetails.length != 0
  //                   ? qpcr1.segregationDetails[index].remarks
  //                   : null,
  //               controller: rewOkQtyController,
  //               decoration: InputDecoration(
  //                   labelText: 'Rework OK Qty',
  //                   fillColor: Colors.white,
  //                   filled: true)),
  //           TextFormField(
  //               initialValue: qpcr1.segregationDetails.length != 0
  //                   ? qpcr1.segregationDetails[index].remarks
  //                   : null,
  //               controller: remarksController,
  //               decoration: InputDecoration(
  //                   labelText: 'Remarks',
  //                   fillColor: Colors.white,
  //                   filled: true)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget getTextField(String name, Function onChanged, SizeConfig screenSize,
      String initValue, var type) {
    print(qpcr1.id);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.screenWidth * 5,
          vertical: screenSize.screenHeight * 2),
      child: TextFormField(
        validator: (val) => val.length < 1 ? 'Enter $name' : null,
        initialValue: initValue,
        //controller: passwordController,
        keyboardType: type,
        textAlign: TextAlign.start,
        onChanged: onChanged,
        style: TextStyle(
            color: Colors.black87, fontSize: screenSize.screenHeight * 2),
        // focusNode: focusNode,
        decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenSize.screenHeight * 2)),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qpcr1 = globalQpcr;
    setDropDown();
  }

  setDropDown() {
    for (int i = 0; i < qpcr1.segregationDetails.length; i++) {
      if (partsCheckedAt.contains(qpcr1.segregationDetails[i].partsCheckedAt)) {
        partsCheckedAt.remove(qpcr1.segregationDetails[i].partsCheckedAt);
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //cards.add(createCard(0, context));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(qpcr1.segregationDetails.length);
    screenSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Enter Details"),
      ),
      body: Container(
        height: screenSize.screenHeight * 100,
        width: screenSize.screenWidth * 100,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.screenHeight * 2,
                  horizontal: screenSize.screenWidth * 5),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Temporary Action: ',
                    style: TextStyle(fontSize: screenSize.screenHeight * 3),
                  )),
            ),
            getTextField("Temporary Action", (v) {
              qpcr1.interimContainmentAction = v;
            }, screenSize, qpcr1.interimContainmentAction, TextInputType.text),
            Container(
              //height: screenSize.screenHeight * 40,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.screenHeight * 2,
                        horizontal: screenSize.screenWidth * 5),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Segregation Details: ',
                          style:
                              TextStyle(fontSize: screenSize.screenHeight * 3),
                        )),
                  ),
                  // Container(
                  //   child: ListView.builder(
                  //     itemCount: cards.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return cards[index];
                  //     },
                  //   ),
                  //   height: screenSize.screenHeight * 50,
                  //   width: screenSize.screenWidth * 80,
                  // ),
                  CourseCard(
                    cardChild: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Detail'),
                            ),
                            Container(
                              width: screenSize.screenWidth * 80,
                              child: DropdownButtonFormField(
                                validator: (val) =>
                                    val.length < 1 ? 'Select one option' : null,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Parts checked At'),
                                items: getNameList(),
                                onChanged: (v) {
                                  selectedPartsCheckedAt.add(v);
                                  parts = v;
                                },
                                value: parts,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  color: Colors.blueGrey,
                                  child: Text(
                                    "Occurring date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  height: 30,
                                  minWidth: 100,
                                  onPressed: () async {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(0),
                                            lastDate: DateTime.now())
                                        .then((date) {
                                      setState(() {
                                        _dateTime = date;
                                        print(_dateTime.toString());
                                      });
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(_dateTime != null
                                    ? _dateTime.toString().substring(0, 10)
                                    : " Please select a Date"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  color: Colors.blueGrey,
                                  child: Text(
                                    "Segregation date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  height: 30,
                                  minWidth: 100,
                                  onPressed: () async {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(0),
                                            lastDate: DateTime.now())
                                        .then((date) {
                                      setState(() {
                                        _segDateTime = date;
                                        print(_segDateTime.toString());
                                      });
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(_segDateTime != null
                                    ? _segDateTime.toString().substring(0, 10)
                                    : " Please select a Date"),
                              ],
                            ),
                            TextFormField(
                                validator: (val) =>
                                    val.length < 1 ? 'Enter OK Qty' : null,
                                keyboardType: TextInputType.number,
                                controller: okQtyController,
                                decoration: InputDecoration(
                                    labelText: 'OK Qty before Rework',
                                    fillColor: Colors.white,
                                    filled: true)),
                            TextFormField(
                                validator: (val) => val.length < 1
                                    ? 'Enter Rejected Qty'
                                    : null,
                                keyboardType: TextInputType.number,
                                controller: rejQtyBefReworkController,
                                decoration: InputDecoration(
                                    labelText: 'Rejected Qty before Rework',
                                    fillColor: Colors.white,
                                    filled: true)),
                            TextFormField(
                                validator: (val) =>
                                    val.length < 1 ? 'Enter SAP Qty' : null,
                                controller: sapQtyCheckController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'SAP Qty to be Checked',
                                    fillColor: Colors.white,
                                    filled: true)),
                            TextFormField(
                                validator: (val) =>
                                    val.length < 1 ? 'Enter Rework Qty' : null,
                                keyboardType: TextInputType.number,
                                controller: rewQtyController,
                                decoration: InputDecoration(
                                    labelText: 'Rework Qty',
                                    fillColor: Colors.white,
                                    filled: true)),
                            TextFormField(
                                validator: (val) => val.length < 1
                                    ? 'Enter Rework OK Qty'
                                    : null,
                                keyboardType: TextInputType.number,
                                controller: rewOkQtyController,
                                decoration: InputDecoration(
                                    labelText: 'Rework OK Qty',
                                    fillColor: Colors.white,
                                    filled: true)),
                            TextFormField(
                                validator: (val) =>
                                    val.length < 1 ? 'Enter Remarks' : null,
                                keyboardType: TextInputType.text,
                                controller: remarksController,
                                decoration: InputDecoration(
                                    labelText: 'Remarks',
                                    fillColor: Colors.white,
                                    filled: true)),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButton(
                                  color: Colors.green,
                                  child: Text(
                                    '+ Add New',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      if (_dateTime != null &&
                                          _segDateTime != null) {
                                        if (qpcr1.segregationDetails.length <
                                            3) {
                                          SegregationDetails seg =
                                              SegregationDetails();
                                          try {
                                            seg.rejectedQtyBeforeRework =
                                                int.parse(
                                                    rejQtyBefReworkController
                                                        .text);
                                            seg.segregationDate = _segDateTime;
                                            seg.occurringDate = _dateTime;
                                            seg.remarks =
                                                remarksController.text;
                                            seg.partsCheckedAt = parts;
                                            seg.okQty =
                                                int.parse(okQtyController.text);
                                            seg.reworkQty = int.parse(
                                                rewQtyController.text);
                                            seg.reworkOKQty = int.parse(
                                                rewOkQtyController.text);
                                            seg.sapQtyToBeChecked = int.parse(
                                                sapQtyCheckController.text);

                                            partsCheckedAt.remove(parts);

                                            qpcr1.segregationDetails.add(seg);
                                            clearData();
                                            setState(() {});
                                          } catch (e) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please enter required data properly");
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the earlier details first.");
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please enter both dates.");
                                      }
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(border: TableBorder.all(width: 1), children: [
                      TableRow(children: [
                        Text('Parts Checked At'),
                        Text('Occurring Date'),
                        Text('Segregation Date'),
                        Text('OK Qty'),
                        Text('Rejected Qty before Rework'),
                        Text('SAP Qty to be checked'),
                        Text('Rework Qty'),
                        Text('Rework OK Qty'),
                        Text('Remarks')
                      ]),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(width: 1),
                      children:
                          qpcr1.segregationDetails.map(_buildItem).toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: screenSize.screenHeight * 2,
                          right: screenSize.screenWidth * 5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Save & Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenSize.screenHeight * 2.5,
                              fontFamily: "Roboto",
                            ),
                          ),
                          height: screenSize.screenHeight * 7,
                          minWidth: screenSize.screenWidth * 30,
                          onPressed: () async {
                            Networking networking = Networking();
                            QPCRList qpcrList = QPCRList();
                            var data = qpcrList.QpcrToMap(qpcr1);
                            print(data);
                            var d = await networking
                                .postData('QPCR/QPCRSave', {"newQPCR": data});
                            // log(d['fishBoneAnalysis']['man'].toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FishBoneTabScreen(
                                        qpcrList.getQPCR(d))));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearData() {
    _dateTime = null;
    _segDateTime = null;
    parts = null;
    okQtyController.clear();
    rewOkQtyController.clear();
    rewQtyController.clear();
    remarksController.clear();
    rejQtyBefReworkController.clear();
    sapQtyCheckController.clear();
    setState(() {});
  }

  TableRow _buildItem(SegregationDetails segregationDetails) {
    return TableRow(children: [
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.partsCheckedAt,
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.occurringDate.toString().substring(0, 10),
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.segregationDate.toString().substring(0, 10),
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.okQty.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.rejectedQtyBeforeRework.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.sapQtyToBeChecked.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.reworkQty.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          parts = segregationDetails.partsCheckedAt;
          partsCheckedAt.add(parts);
          _dateTime = segregationDetails.occurringDate;
          _segDateTime = segregationDetails.segregationDate;
          okQtyController.text = segregationDetails.okQty.toString();
          rejQtyBefReworkController.text =
              segregationDetails.rejectedQtyBeforeRework.toString();
          sapQtyCheckController.text =
              segregationDetails.sapQtyToBeChecked.toString();
          rewQtyController.text = segregationDetails.reworkQty.toString();
          rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
          remarksController.text = segregationDetails.remarks.toString();
          qpcr1.segregationDetails.remove(segregationDetails);
          setState(() {});
        },
        child: Text(
          segregationDetails.reworkOKQty.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
          onTap: () {
            parts = segregationDetails.partsCheckedAt;
            partsCheckedAt.add(parts);
            _dateTime = segregationDetails.occurringDate;
            _segDateTime = segregationDetails.segregationDate;
            okQtyController.text = segregationDetails.okQty.toString();
            rejQtyBefReworkController.text =
                segregationDetails.rejectedQtyBeforeRework.toString();
            sapQtyCheckController.text =
                segregationDetails.sapQtyToBeChecked.toString();
            rewQtyController.text = segregationDetails.reworkQty.toString();
            rewOkQtyController.text = segregationDetails.reworkOKQty.toString();
            remarksController.text = segregationDetails.remarks.toString();
            qpcr1.segregationDetails.remove(segregationDetails);
            setState(() {});
          },
          child: Text(
            segregationDetails.remarks,
            textAlign: TextAlign.center,
          )),
    ]);
  }
}
