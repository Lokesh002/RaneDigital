import 'package:flutter/material.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/constants.dart';

import 'package:rane_dms/components/sizeConfig.dart';

class MyQPCRStatusScreen extends StatefulWidget {
  final QPCR qpcr;
  MyQPCRStatusScreen(this.qpcr);
  @override
  _MyQPCRStatusScreenState createState() => _MyQPCRStatusScreenState();
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

class _MyQPCRStatusScreenState extends State<MyQPCRStatusScreen> {
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

  Widget getImage(int status) {
    switch (status) {
      case 0:
        return Image.asset("images/0.png");

      case 1:
        return Image.asset("images/1.png");

      case 2:
        return Image.asset("images/2.png");

      case 3:
        return Image.asset("images/3.png");

      case 4:
        return Image.asset("images/4.png");

      default:
        return Image.asset("images/logo.png");
    }
  }

  String photo = ipAddress + 'QPCRpics/logo.png';
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.screenHeight * 3,
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
                getElement("Raising Date",
                    widget.qpcr.raisingDate.toString().substring(0, 10)),
                getElement("Raising Person", widget.qpcr.raisingPerson),
                getElement(
                    "QPCR Accepted By:",
                    (widget.qpcr.status >= 1)
                        ? widget.qpcr.acceptingPerson
                        : "-"),
                getElement("Root Cause",
                    (widget.qpcr.status >= 2) ? widget.qpcr.rootCause : '-'),
                getElement("Action Decided",
                    (widget.qpcr.status >= 2) ? widget.qpcr.action : "-"),
                getElement(
                    "Target Date",
                    (widget.qpcr.status >= 2)
                        ? widget.qpcr.targetDate.substring(0, 10)
                        : "-"),
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
                    "Status:",
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
                    child: Container(
                        height: screenSize.screenHeight * 15,
                        child: getImage(widget.qpcr.status))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
