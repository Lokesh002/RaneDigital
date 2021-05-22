import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/FTA/ftaEditScreen.dart';
import 'package:rane_dms/screens/FTA/ftaGenerateScreen.dart';

class FTAListScreen extends StatefulWidget {
  final FTA parentFta;
  final String machineID;
  final String parentId;
  final String parentDesc;
  final String lineID;
  final String photo;
  FTAListScreen(this.parentFta, this.parentId, this.machineID, this.parentDesc,
      this.lineID, this.photo);
  @override
  _FTAListScreenState createState() => _FTAListScreenState();
}

class _FTAListScreenState extends State<FTAListScreen> {
  List<FTA> ftaList = [];
  String parentDesc;

  bool isLoaded = false;
  getData() async {
    parentDesc = widget.parentDesc;
    Networking networking = Networking();
    var d = await networking.postData(
        "FTA/getFTA", {"parent": widget.parentId, "machine": widget.machineID});
    log(d.toString());
    FTAList ftaList = FTAList();
    this.ftaList = ftaList.getFTAList(d);

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
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, parentDesc);
        return;
      },
      child: Scaffold(
        floatingActionButton: isLoaded
            ? FloatingActionButton(
                backgroundColor: Colors.teal,
                heroTag: 'add',
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
            : SingleChildScrollView(
                child: Padding(
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
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.screenWidth * 5),

                                    child: widget.parentId != null
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: screenSize
                                                            .screenHeight *
                                                        2),
                                                child: Table(
                                                  defaultVerticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  columnWidths: {
                                                    0: FlexColumnWidth(8),
                                                    1: FlexColumnWidth(2),
                                                  },
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            parentDesc,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.teal,
                                                                fontSize: screenSize
                                                                        .screenHeight *
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Center(
                                                          child:
                                                              FloatingActionButton(
                                                            heroTag: 'edit',
                                                            child: Icon(
                                                                Icons.edit),
                                                            onPressed: () {
                                                              print(
                                                                  widget.photo);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => FTAEditScreen(
                                                                          widget
                                                                              .parentId,
                                                                          widget
                                                                              .parentDesc,
                                                                          null))).then(
                                                                  (value) {
                                                                this.parentDesc =
                                                                    value;
                                                                setState(() {});
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Center(
                                                  child: widget.parentFta
                                                                  .photo !=
                                                              null &&
                                                          widget.parentFta
                                                                  .photo !=
                                                              ""
                                                      ? Image.network(
                                                          widget
                                                              .parentFta.photo,
                                                          fit: BoxFit.contain)
                                                      : SizedBox()),
                                            ],
                                          )
                                        : Center(
                                            child: Text(
                                              parentDesc,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.teal,
                                                  fontSize:
                                                      screenSize.screenHeight *
                                                          3,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                    // ),
                                    //
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
                                                          ftaList[index - 1],
                                                          ftaList[index - 1].id,
                                                          ftaList[index - 1]
                                                              .machineId,
                                                          ftaList[index - 1]
                                                              .description,
                                                          ftaList[index - 1]
                                                              .lineId,
                                                          ftaList[index - 1]
                                                              .photo))).then(
                                              (v) {
                                            ftaList[index - 1].description = v;
                                            setState(() {});
                                          });
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
                                                    screenSize.screenHeight *
                                                        2),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.screenWidth *
                                                          5,
                                                  vertical:
                                                      screenSize.screenHeight *
                                                          3),
                                              child: Center(
                                                child: Text(
                                                  ftaList[index - 1]
                                                      .description,
                                                  style: TextStyle(
                                                      fontSize: screenSize
                                                              .screenHeight *
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
              ),
      ),
    );
  }
}
