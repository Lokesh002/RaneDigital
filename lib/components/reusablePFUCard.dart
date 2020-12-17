import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rane_dms/components/ReusableCard.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class ReusablePFUCard extends StatelessWidget {
  final String problem;
  final String lastUpdate;
  final String lineName;
  final Function onTap;
  final Function onChangeTap;
  final Color color;
  final String machineCode;
  final int status;
  final String issueDate;
  ReusablePFUCard(
      {this.problem,
      this.status,
      this.lastUpdate,
      this.lineName,
      this.issueDate,
      this.onTap,
      this.onChangeTap,
      this.color,
      this.machineCode});
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
        return Image.asset("images/4.png");
      case 5:
        return Image.asset("images/4.png");
      case 6:
        return Image.asset("images/rejected.png");
      default:
        return Image.asset("images/logo.png");
    }
  }

  Color getColor(int status) {
    switch (status) {
      case 0:
        return Colors.white;

      case 1:
        return Colors.black54;

      case 2:
        return Colors.black54;

      case 3:
        return Colors.black54;

      case 4:
        return Colors.white;
      case 5:
        return Colors.white;
      case 6:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.screenWidth * 2,
          vertical: screenSize.screenHeight * 2),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.screenWidth * 2.5),
              child: Column(
                children: <Widget>[
                  CourseCard(
                    color: this.color,
                    width: screenSize.screenWidth * 90,
                    // height: screenSize.screenHeight * 10,
                    cardChild: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.screenWidth * 2.5),
                          child: SizedBox(
                            width: screenSize.screenWidth * 15,
                            height: screenSize.screenWidth * 15,
                            child: Material(
                              color: Theme.of(context).primaryColor,
                              elevation: 5.0,
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenSize.screenHeight * 1),
                              ),
                              child: Center(child: getImage(status)),
                            ),
                          ),
                        ),
//                    Icon(
//                      Icons.library_books,
//                      size: screenSize.screenHeight * 5,
//                      color: Colors.white, // Theme.of(context).primaryColor,
//                    ),
                        SizedBox(
                          width: screenSize.screenWidth * 3,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: screenSize.screenHeight * 2.3,
                            ),
                            Container(
                              width: screenSize.screenWidth * 60,
                              child: Text(
                                '$problem',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenSize.screenHeight * 3,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 1,
                            ),
                            Text(
                              '$lineName',
                              style: TextStyle(
                                fontSize: screenSize.screenHeight * 2,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Machine: $machineCode',
                                  style: TextStyle(
                                    fontSize: screenSize.screenHeight * 1.5,
                                    color: getColor(status),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.screenWidth * 5,
                                ),
                                Text(
                                  'Issued: $issueDate',
                                  style: TextStyle(
                                    fontSize: screenSize.screenHeight * 1.5,
                                    color: getColor(status),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 2,
                            ),
                          ],
                        ),
                      ],
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
}
