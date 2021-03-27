import 'package:flutter/material.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class AcceptQPCRScreen extends StatefulWidget {
  final QPCR qpcr;
  AcceptQPCRScreen(this.qpcr);
  @override
  _AcceptQPCRScreenState createState() => _AcceptQPCRScreenState();
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

class _AcceptQPCRScreenState extends State<AcceptQPCRScreen> {
  SizeConfig screenSize;

  String rejectReason;
  final rejectReasonController = TextEditingController();
  showRejectDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          Form(
            key: _formKey,
            child: Container(
              width: screenSize.screenWidth * 64,
              height: screenSize.screenHeight * 20,
              child: TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'Enter Reason for rejecting' : null,
                controller: rejectReasonController,
                maxLines: 8,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                onChanged: (problem) {
                  this.rejectReason = problem;
                  print(this.rejectReason);
                },

                style: TextStyle(
                    color: Colors.black87,
                    fontSize: screenSize.screenHeight * 2),
                // focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: "Reason of Rejecting QPCR",
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(screenSize.screenHeight * 2)),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Container(
            color: Colors.red,
            child: TextButton(
              onPressed: () async {
                showAlertDialog(context);
                Networking networking = Networking();
                await networking.postData('QPCR/rejectQPCR', {
                  'qpcrId': widget.qpcr.id,
                  'rejectingReason': this.rejectReason
                });
                rejectReasonController.clear();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Reject',
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () {
              rejectReasonController.clear();
              Navigator.pop(context);
              return;
            },
            child: alert);
      },
    );
  }

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

  SavedData savedData = SavedData();
  String photo = ipAddress + 'QPCRpics/logo.png';
  @override
  void dispose() {
    rejectReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
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
                    widget.qpcr.lineName,
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
                        widget.qpcr.machine.machineCode,
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
                        widget.qpcr.machine.machineName,
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
                            widget.qpcr.problem,
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
                      height: screenSize.screenHeight * 15,
                      child: ListView(
                        padding:
                            EdgeInsets.only(right: screenSize.screenWidth * 5),
                        children: [
                          Text(
                            widget.qpcr.problemDescription,
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
                getElement("Raising Department", widget.qpcr.raisingDept),
                getElement(
                    "Responsible Department", widget.qpcr.deptResponsible),
                getElement("Raising Date", widget.qpcr.raisingDate.toString()),
                getElement("Raising Person", widget.qpcr.raisingPerson),
                SizedBox(
                  height: screenSize.screenHeight * 50,
                  width: screenSize.screenWidth * 100,
                  child: (widget.qpcr.photoURL == null ||
                          widget.qpcr.photoURL == "")
                      ? Image.network(
                          photo,
                          fit: BoxFit.contain,
                        )
                      : Image.network(widget.qpcr.photoURL),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.screenHeight * 2.5),
                  child: Text(
                    "Do you want to accept the QPCR?",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: screenSize.screenHeight * 2.5,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.screenHeight * 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: screenSize.screenWidth * 5,
                          ),
                          MaterialButton(
                            color: Colors.green,
                            child: Text(
                              "Accept",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.screenHeight * 2,
                                fontFamily: "Roboto",
                              ),
                            ),
                            height: screenSize.screenHeight * 5,
                            minWidth: screenSize.screenWidth * 30,
                            onPressed: () async {
                              showAlertDialog(context);
                              Networking networking = Networking();
                              await networking.postData('QPCR/acceptQPCR', {
                                'QPCRId': widget.qpcr.id,
                                'acceptingPerson': await savedData.getUserName()
                              });

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.red,
                            child: Text(
                              "Reject",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.screenHeight * 2,
                                fontFamily: "Roboto",
                              ),
                            ),
                            height: screenSize.screenHeight * 5,
                            minWidth: screenSize.screenWidth * 30,
                            onPressed: () async {
                              showRejectDialog(context);
                            },
                          ),
                          SizedBox(
                            width: screenSize.screenWidth * 5,
                          ),
                        ],
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
