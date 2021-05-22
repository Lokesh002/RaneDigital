import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class FTAEditScreen extends StatefulWidget {
  final String ftaId;
  final String earlierDescription;
  final String oldPhoto;

  FTAEditScreen(this.ftaId, this.earlierDescription, this.oldPhoto);
  @override
  _FTAEditScreenState createState() => _FTAEditScreenState();
}

class _FTAEditScreenState extends State<FTAEditScreen> {
  String raisingPerson;
  SizeConfig screenSize;
  TextEditingController ftaDescController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    SavedData savedData = SavedData();
    raisingPerson = await savedData.getUserId();
    ftaDescController.text = widget.earlierDescription;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, widget.earlierDescription);
        return;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: screenSize.screenWidth * 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.screenWidth * 5,
                          vertical: screenSize.screenWidth * 10),
                      child: TextFormField(
                          validator: (val) =>
                              val.length < 1 ? 'Enter Description' : null,
                          controller: ftaDescController,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: screenSize.screenHeight * 3),
                          // focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: "FTA Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.screenHeight * 2)),
                          )),
                    )),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: screenSize.screenHeight * 5),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              Networking networking = Networking();
                              var d =
                                  await networking.postData("FTA/deleteFTA", {
                                "id": widget.ftaId,
                              });
                              log(d.toString());

                              Navigator.pop(context, ftaDescController.text);
                              if (d['ancestors'] != null) {
                                for (int i = 0;
                                    i < d['ancestors'].length;
                                    i++) {
                                  Navigator.pop(
                                    context,
                                  );
                                }
                              }
                            } catch (e) {
                              FlutterError.onError(e);
                            }
                          }

                          // log(this.ftaList[0].parentId.toString());
                        },
                        child: Container(
                          height: screenSize.screenHeight * 10,
                          width: screenSize.screenWidth * 90,
                          color: Colors.redAccent,
                          child: Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.screenHeight * 3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            Networking networking = Networking();
                            var d = await networking.postData("FTA/edit", {
                              "description": ftaDescController.text,
                              "photoURL": null,
                              "id": widget.ftaId,
                            });
                            log(d.toString());

                            Navigator.pop(context, ftaDescController.text);
                          } catch (e) {
                            FlutterError.onError(e);
                          }
                        }

                        // log(this.ftaList[0].parentId.toString());
                      },
                      child: Container(
                        height: screenSize.screenHeight * 10,
                        width: screenSize.screenWidth * 100,
                        color: Colors.lightGreen,
                        child: Center(
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.screenHeight * 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
