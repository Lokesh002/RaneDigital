import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class ReusableCourseCard extends StatelessWidget {
  final String name;
  final String lastUpdate;
  final String dept;
  final Function onTap;
  final Function onChangeTap;
  final Color color;
  final String image;
  final String size;
  final isFolder;
  ReusableCourseCard(
      {this.name,
      this.lastUpdate,
      this.dept,
      this.onTap,
      this.onChangeTap,
      this.color,
      this.image,
      this.size,
      this.isFolder});
  String getInitials(String name) {
    String a = name.trim();
    return a.substring(0, 1).toUpperCase();
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
                    color: Theme.of(context).backgroundColor,
                    width: screenSize.screenWidth * 90,
                    // height: screenSize.screenHeight * 10,
                    cardChild: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.screenWidth * 4),
                          child: SizedBox(
                            width: screenSize.screenWidth * 10,
                            height: screenSize.screenWidth * 10,
                            child: isFolder
                                ? Icon(
                                    Icons.folder,
                                    size: screenSize.screenHeight * 7,
                                    color: Colors.orangeAccent,
                                  )
                                : Material(
                                    color: Theme.of(context).primaryColor,
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          screenSize.screenHeight * 1),
                                    ),
                                    child: Center(
                                        child: Text(
                                      getInitials(this.name),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize:
                                              screenSize.screenHeight * 4),
                                    )),
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
                                '$name',
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
                              '$lastUpdate',
                              style: TextStyle(
                                fontSize: screenSize.screenHeight * 1.5,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.screenHeight * 1,
                            ),
                            Text(
                              '$size',
                              style: TextStyle(
                                fontSize: screenSize.screenHeight * 2,
                                color: Colors.black26,
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
