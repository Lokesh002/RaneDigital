import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/pfuDataStructure.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class EnterPFUDetails extends StatefulWidget {
  final PFU pfu;
  EnterPFUDetails(this.pfu);
  @override
  _EnterPFUDetailsState createState() => _EnterPFUDetailsState();
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 10,
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _EnterPFUDetailsState extends State<EnterPFUDetails> {
  TextEditingController rootCauseController = TextEditingController();
  DateTime _dateTime;
  String rootCause;
  String action;
  SizeConfig screenSize;
  Widget getElement(String about, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.screenHeight * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: screenSize.screenWidth * 5,
              ),
              Text(
                about,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenSize.screenHeight * 2,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenSize.screenHeight * 2,
                  fontFamily: "Roboto",
                ),
              ),
              SizedBox(
                width: screenSize.screenWidth * 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String photo = ipAddress + 'PFUpics/logo.png';
  final _formKey = GlobalKey<FormState>();
  TextEditingController actionController = TextEditingController();

  @override
  void dispose() {
    actionController.dispose();
    rootCauseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        height: double.infinity,
        width: screenSize.screenWidth * 100,
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.only(
              top: screenSize.screenHeight, bottom: screenSize.screenHeight),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.screenHeight * 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.screenHeight * 2.5),
                  child: Text(
                    widget.pfu.lineName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.screenHeight * 3.5,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.screenHeight * 2.5),
                  child: Column(
                    children: [
                      Text(
                        widget.pfu.machine.machineCode,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenSize.screenHeight * 3,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 2,
                      ),
                      Text(
                        widget.pfu.machine.machineName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenSize.screenHeight * 3,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: screenSize.screenWidth * 5),
                      child: Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Problem: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.screenHeight * 2,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 60,
                      height: screenSize.screenHeight * 10,
                      child: ListView(
                        padding:
                            EdgeInsets.only(right: screenSize.screenWidth * 5),
                        children: [
                          Text(
                            widget.pfu.problem,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.screenHeight * 2,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: screenSize.screenWidth * 5),
                      child: Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Description: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.screenHeight * 2,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 60,
                      height: screenSize.screenHeight * 10,
                      child: ListView(
                        padding:
                            EdgeInsets.only(right: screenSize.screenWidth * 5),
                        children: [
                          Text(
                            widget.pfu.problemDescription,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.screenHeight * 2,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                getElement("Raising Department", widget.pfu.raisingDept),
                getElement(
                    "Responsible Department", widget.pfu.deptResponsible),
                getElement("Raising Date", widget.pfu.raisingDate.toString()),
                getElement(
                    "Raising Person",
                    widget.pfu.raisingPerson != null &&
                            widget.pfu.raisingPerson != ''
                        ? widget.pfu.raisingPerson
                        : ""),
                getElement(
                    "PFU Accepted By:",
                    widget.pfu.acceptingPerson != null &&
                            widget.pfu.acceptingPerson != ''
                        ? widget.pfu.acceptingPerson
                        : ""),
                SizedBox(
                  height: screenSize.screenHeight * 50,
                  width: screenSize.screenWidth * 100,
                  child:
                      (widget.pfu.photoURL == null || widget.pfu.photoURL == "")
                          ? Image.network(
                              photo,
                              fit: BoxFit.contain,
                            )
                          : Image.network(widget.pfu.photoURL),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.screenHeight * 2),
                        child: Text(
                          "Enter below details:",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: screenSize.screenHeight * 2.5,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenSize.screenHeight * 5,
                          right: screenSize.screenHeight * 5,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: screenSize.screenHeight * 1,
                              bottom: screenSize.screenHeight * 1),
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Root Cause Details' : null,
                            controller: rootCauseController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start,
                            onChanged: (name) {
                              this.rootCause = name;
                              print(this.rootCause);
                            },

                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: screenSize.screenHeight * 2),
                            // focusNode: focusNode,
                            decoration: InputDecoration(
                              hintText: "Root Cause",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenSize.screenHeight * 2)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenSize.screenHeight * 5,
                          right: screenSize.screenHeight * 5,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  top: screenSize.screenHeight * 1,
                                  bottom: screenSize.screenHeight * 1),
                              child: TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? 'Enter Action Details' : null,
                                controller: actionController,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.start,
                                onChanged: (name) {
                                  this.action = name;
                                  print(this.action);
                                },

                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenSize.screenHeight * 2),
                                // focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: "Action",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.screenHeight * 2)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: screenSize.screenHeight * 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              color: Colors.blueGrey,
                              child: Text(
                                "Target date",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.screenHeight * 2,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              height: screenSize.screenHeight * 5,
                              minWidth: screenSize.screenWidth * 30,
                              onPressed: () async {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2222))
                                    .then((date) {
                                  setState(() {
                                    _dateTime = date;
                                    print(_dateTime.toString());
                                  });
                                });
                              },
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 1,
                            ),
                            Text(_dateTime.toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: screenSize.screenHeight * 1),
                        child: MaterialButton(
                          color: Colors.green,
                          child: Text(
                            "Proceed",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenSize.screenHeight * 2,
                              fontFamily: "Roboto",
                            ),
                          ),
                          height: screenSize.screenHeight * 5,
                          minWidth: screenSize.screenWidth * 30,
                          onPressed: () async {
                            if (_formKey.currentState.validate() &&
                                _dateTime != null) {
                              showAlertDialog(context);
                              Networking networking = Networking();
                              await networking.postData('PFU/PFUActionDecide', {
                                'pfuId': widget.pfu.id,
                                'rootCause': rootCause,
                                'action': action,
                                'targetDate':
                                    _dateTime.toString().substring(0, 10)
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please enter all the fields.");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenSize.screenHeight * 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
