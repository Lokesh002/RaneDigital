import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableCard.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:flutter/services.dart';

class ReusablePFUListCard extends StatelessWidget {
  final int index;
  final String problem;
  final String date;
  final String description;
  final String raisingDepartment;
  final String deptResponsible;
  final String rootCause;
  final int status;
  final String targetDate;
  final String machine;
  final String action;
  final String line;
  final String raisingPerson;
  final String effectingAreas;
  final Function onTap;
  final String actualClosingTime;
  final Function onChangeTap;
  final String acceptingPerson;
  final Color color;

  ReusablePFUListCard(
      {this.problem,
      this.effectingAreas,
      this.targetDate,
      this.date,
      this.index,
      this.action,
      this.actualClosingTime,
      this.deptResponsible,
      this.description,
      this.rootCause,
      this.raisingDepartment,
      this.raisingPerson,
      this.acceptingPerson,
      this.onTap,
      this.onChangeTap,
      this.color,
      this.status,
      this.machine,
      this.line});
  String getInitials(String name) {
    String a = name.trim();
    return a.substring(0, 1).toUpperCase();
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
        return Image.asset("images/3.png");
      case 5:
        return Image.asset("images/4.png");
      case 6:
        return Image.asset("images/rejected.png");
      default:
        return Image.asset("images/4.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: screenSize.screenWidth * 2.50,
              top: screenSize.screenHeight * 2,
              bottom: screenSize.screenHeight * 2),
          child: Column(
            children: <Widget>[
              Container(
                width: screenSize.screenWidth * 96,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blueGrey,
                )),
                // height: screenSize.screenHeight * 10,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: screenSize.screenWidth * 10,
                        height: screenSize.screenHeight * 30,
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "No.",
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 4),
                                  ),
                                  SizedBox(
                                    height: screenSize.screenHeight,
                                  ),
                                  Text(
                                    (this.index + 1).toString(),
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 3),
                                  )
                                ],
                              ),
                              height: screenSize.screenHeight * 15,
                              width: screenSize.screenWidth * 10,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.blueGrey,
                              )),
                            ),
                            Container(
                              height: screenSize.screenHeight * 15,
                              width: screenSize.screenWidth * 10,
                              child: Column(
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 4),
                                  ),
                                  SizedBox(
                                    height: screenSize.screenHeight,
                                  ),
                                  Text(
                                    date,
                                    style: TextStyle(
                                        fontSize: screenSize.screenHeight * 3),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.blueGrey,
                              )),
                            ),
                          ],
                        )),
                    Container(
                      width: screenSize.screenWidth * 10,
                      height: screenSize.screenHeight * 30,
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
                              line,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.screenHeight * 3),
                            ),
                            Text(
                              machine + "\n",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.screenHeight * 3),
                            ),
                            Text(
                              raisingPerson != null && raisingPerson != ""
                                  ? raisingPerson
                                  : "",
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
                      height: screenSize.screenHeight * 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.blueGrey,
                      )),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.screenHeight * 1,
                              horizontal: screenSize.screenWidth * 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                problem,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: screenSize.screenHeight * 3),
                              ),
                              Text(
                                effectingAreas != null &&
                                        effectingAreas.isNotEmpty
                                    ? effectingAreas
                                    : "",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenSize.screenHeight * 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 15,
                      height: screenSize.screenHeight * 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.blueGrey,
                      )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.screenWidth * 1),
                        child: Center(
                          child: Text(
                            description,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 10,
                      height: screenSize.screenHeight * 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.blueGrey,
                      )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.screenWidth * 1),
                        child: Center(
                          child: Text(
                            rootCause,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: screenSize.screenHeight * 3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 10,
                      height: screenSize.screenHeight * 30,
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
                            Center(
                              child: Text(
                                action,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: screenSize.screenHeight * 3),
                              ),
                            ),
//                            Text(
//                              "Machine\n",
//                              softWrap: true,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: screenSize.screenHeight * 3),
//                            ),
//                            Text(
//                              "Raising Person",
//                              softWrap: true,
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  fontSize: screenSize.screenHeight * 3),
//                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 10,
                      height: screenSize.screenHeight * 30,
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
                              deptResponsible,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.screenHeight * 3),
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 1,
                            ),
                            Text(
                              acceptingPerson != null && acceptingPerson != ""
                                  ? acceptingPerson
                                  : "",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: screenSize.screenHeight * 3),
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 2,
                            ),
                            Text(
                              targetDate,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: screenSize.screenHeight * 3),
                            ),
//                            Text(
//                              "Raising Person",
//                              softWrap: true,
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  fontSize: screenSize.screenHeight * 3),
//                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 10,
                      height: screenSize.screenHeight * 30,
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
                            getImage(status),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.screenWidth * 10,
                      height: screenSize.screenHeight * 30,
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
                              actualClosingTime,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: screenSize.screenHeight * 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
