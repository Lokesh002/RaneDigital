import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class AddLineScreen extends StatefulWidget {
  @override
  _AddLineScreenState createState() => _AddLineScreenState();
}

class _AddLineScreenState extends State<AddLineScreen> {
  TextEditingController nameController = TextEditingController();
  SizeConfig screenSize;
  String name;
  @override
  void dispose() {
    nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  cleartext() {
    nameController.clear();
    name = null;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(children: [
                    Container(
                      width: screenSize.screenWidth * 80,
                      height: screenSize.screenHeight * 15,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 5,
                    ),
                    Text(
                      "Enter Line Name",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: screenSize.screenHeight * 2.5,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenSize.screenHeight * 5,
                          right: screenSize.screenHeight * 5,
                          top: screenSize.screenHeight * 2),
                      child: Stack(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: screenSize.screenHeight * 2),
                              child: TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? 'Enter line name' : null,
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.start,
                                onChanged: (name) {
                                  this.name = name;
                                  print(this.name);
                                },

                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenSize.screenHeight * 2),
                                // focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: "Line Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.screenHeight * 2)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.screenHeight * 10),
                  child: ReusableButton(
                    height: screenSize.screenHeight * 10,
                    onPress: () async {
                      if (_formKey.currentState.validate()) {
                        Networking networking = Networking();
                        var data = await networking
                            .postData('Line/addLine', {'lineName': name});
                        if (data != null) {
                          var otherMachine = await networking.postData(
                              'Line/addMachine', {
                            'machineName': "Others",
                            "machineCode": "Others",
                            "lineId": data["_id"]
                          });
                          if (otherMachine != null) {
                            Fluttertoast.showToast(msg: "Successfully added.");

                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/generatePFUScreen');
                          } else {
                            Fluttertoast.showToast(msg: "Error in adding Line");
                            Navigator.pop(context);
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Error in adding Line");
                          Navigator.pop(context);
                        }
                      }
                    },
                    content: "Proceed",
                    width: screenSize.screenWidth * 40,
                  ),
                )
              ]),
        ),
      ]),
    );
  }
}
