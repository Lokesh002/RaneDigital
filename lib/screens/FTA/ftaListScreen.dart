import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/FTA/ftaGenerateScreen.dart';

class FTAListScreen extends StatefulWidget {
  final String machineID;
  final String parentId;
  final String parentDesc;
  final String lineID;
  FTAListScreen(this.parentId, this.machineID, this.parentDesc, this.lineID);
  @override
  _FTAListScreenState createState() => _FTAListScreenState();
}

class _FTAListScreenState extends State<FTAListScreen> {
  List<FTA> ftaList = [];
  bool isLoaded = false;
  getData() async {
    Networking networking = Networking();
    var d = await networking.postData(
        "FTA/getFTA", {"parent": widget.parentId, "machine": widget.machineID});
    log(d.toString());
    FTAList ftaList = FTAList();
    this.ftaList = ftaList.getFTAList(d);

    // log(this.ftaList[0].parentId.toString());
    this.isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  SizeConfig screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      floatingActionButton: isLoaded
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FTAGenerateScreen(
                            widget.parentId,
                            widget.parentDesc,
                            widget.machineID,
                            widget.lineID,
                            ftaList))).then((value) {
                  this.ftaList = value;
                  setState(() {});
                });
              },
              child: Icon(
                Icons.add_rounded,
                size: screenSize.screenHeight * 5,
                color: Colors.white,
              ),
            )
          : null,
      body: !isLoaded
          ? Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: screenSize.screenHeight * 5),
              child: Container(
                height: screenSize.screenHeight * 95,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: screenSize.screenWidth * 100,
                      height: screenSize.screenHeight * 95,
                      child: ListView.builder(
                        itemBuilder: (context, index) => index == 0
                            ? Text(
                                widget.parentDesc,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: screenSize.screenHeight * 3,
                                    fontWeight: FontWeight.bold),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.screenWidth * 5,
                                    vertical: screenSize.screenHeight * 3),
                                child: Container(
                                  // height: screenSize.screenHeight * 15,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FTAListScreen(
                                                      ftaList[index - 1].id,
                                                      ftaList[index - 1]
                                                          .machineId,
                                                      ftaList[index - 1]
                                                          .description,
                                                      ftaList[index - 1]
                                                          .lineId)));
                                    },
                                    child: Material(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          screenSize.screenHeight * 2),
                                      elevation: 5,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.screenWidth * 5,
                                            vertical:
                                                screenSize.screenHeight * 2),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.screenWidth * 5,
                                              vertical:
                                                  screenSize.screenHeight * 3),
                                          child: Center(
                                            child: Text(
                                              ftaList[index - 1].description,
                                              style: TextStyle(
                                                  fontSize:
                                                      screenSize.screenHeight *
                                                          3,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        itemCount: ftaList.length + 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
