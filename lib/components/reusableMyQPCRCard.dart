import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class ReusableMyQPCRCard extends StatelessWidget {
  final String problem;
  final String lastUpdate;
  final String partName;
  final Function onTap;
  final Function onChangeTap;
  final Color color;
  final String conernType;
  final int status;
  final String issueDate;
  final String defectRank;
  final String respDept;
  final String qpcrNo;
  ReusableMyQPCRCard(
      {this.problem,
      this.respDept,
      this.status,
      this.qpcrNo,
      this.defectRank,
      this.lastUpdate,
      this.partName,
      this.issueDate,
      this.onTap,
      this.onChangeTap,
      this.color,
      this.conernType});
  String getInitials(String name) {
    String a = name.trim();
    return a.substring(0, 1).toUpperCase();
  }

  Widget getImage(String defectRank) {
    switch (defectRank) {
      case "A":
        return Image.asset("images/A.png");

      case "B":
        return Image.asset("images/B.png");

      case "C":
        return Image.asset("images/C.png");

      case "D":
        return Image.asset("images/D.png");

      default:
        return Image.asset("images/D.png");
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
                          child: CircleAvatar(
                            radius: screenSize.screenWidth * 8.5,
                            backgroundColor: Colors.white,
                            child: SizedBox(
                              width: screenSize.screenWidth * 15,
                              height: screenSize.screenWidth * 15,
                              child: Center(child: getImage(defectRank)),
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
                                '$qpcrNo',
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
                              '$partName',
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
                                  'Concern Type: $conernType',
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
                              height: screenSize.screenHeight * 1,
                            ),
                            Text(
                              'Responsible Dept: $respDept',
                              style: TextStyle(
                                fontSize: screenSize.screenHeight * 2,
                                color: Colors.black,
                              ),
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
