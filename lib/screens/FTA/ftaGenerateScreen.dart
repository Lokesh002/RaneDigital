import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rane_dms/components/ftaDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class FTAGenerateScreen extends StatefulWidget {
  final String parentId;
  final String parentDesc;
  final String machineId;
  final String lineId;
  final List<FTA> ftaList;
  FTAGenerateScreen(this.parentId, this.parentDesc, this.machineId, this.lineId,
      this.ftaList);
  @override
  _FTAGenerateScreenState createState() => _FTAGenerateScreenState();
}

class _FTAGenerateScreenState extends State<FTAGenerateScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, widget.ftaList);
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
                GestureDetector(
                  onTap: () async {
                    Networking networking = Networking();
                    var d = await networking.postData("FTA/generate", {
                      "parent": widget.parentId,
                      "machine": widget.machineId,
                      "description": ftaDescController.text,
                      "photoURL": null,
                      "raisingPerson": raisingPerson,
                      "line": widget.lineId,
                    });
                    log(d.toString());
                    FTAList ftaList = FTAList();
                    List<dynamic> a = [];

                    a.add(d);
                    var list = ftaList.getFTAList(a);
                    List<FTA> f = widget.ftaList;
                    f.addAll(list);
                    Navigator.pop(context, f);
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
