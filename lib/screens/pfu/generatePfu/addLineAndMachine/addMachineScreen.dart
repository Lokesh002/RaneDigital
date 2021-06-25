import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class AddMachineScreen extends StatefulWidget {
  Line selectedLine;
  AddMachineScreen(this.selectedLine);

  @override
  _AddMachineScreenState createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  SizeConfig screenSize;
  String machineName;
  String machineCode;
  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
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
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 5,
                    ),
                    Text(
                      widget.selectedLine.lineName,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: screenSize.screenHeight * 3.5,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.screenHeight * 5,
                    ),
                    Text(
                      "Enter Machine Details",
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
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: screenSize.screenHeight * 2),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty
                                        ? 'Enter machine name'
                                        : null,
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.start,
                                    onChanged: (name) {
                                      this.machineName = name;
                                      print(this.machineName);
                                    },

                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: screenSize.screenHeight * 2),
                                    // focusNode: focusNode,
                                    decoration: InputDecoration(
                                      hintText: "Machine Name",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenSize.screenHeight * 2)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: screenSize.screenHeight * 2),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty
                                        ? 'Enter machine code'
                                        : null,
                                    controller: codeController,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.start,
                                    onChanged: (code) {
                                      this.machineCode = code;
                                      print(this.machineCode);
                                    },

                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: screenSize.screenHeight * 2),
                                    // focusNode: focusNode,
                                    decoration: InputDecoration(
                                      hintText: "Machine Code",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenSize.screenHeight * 2)),
                                    ),
                                  ),
                                ),
                              ],
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
                        var data =
                            await networking.postData('Line/addMachine', {
                          'machineName': machineName,
                          'machineCode': machineCode,
                          'lineId': widget.selectedLine.lineId
                        });
                        if (data != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Successfully added.")));
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/generatePFUScreen');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error in adding Line")));
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
