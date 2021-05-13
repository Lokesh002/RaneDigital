import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/pms/dataEntry/pmsDataEntry.dart';

class PMSMainScreen extends StatefulWidget {
  @override
  _PMSMainScreenState createState() => _PMSMainScreenState();
}

SavedData savedData = SavedData();

class _PMSMainScreenState extends State<PMSMainScreen> {
  SizeConfig screenSize;
  SavedData savedData = SavedData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  String accountType;

  getData() async {
    accountType = await savedData.getAccountType();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.screenHeight * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PMS"),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.screenWidth * 5),
                child: Visibility(
                  visible: accountType == 'admin',
                  child: MaterialButton(
                    onPressed: () async {
                      Networking networking = Networking();
                      var data =
                          await networking.getData('ShiftPlan/makeBackup');
                      if (data != null) {
                        Fluttertoast.showToast(msg: data['msg']);
                      }
                    },
                    height: screenSize.screenHeight * 5,
                    minWidth: screenSize.screenWidth * 20,
                    color: Colors.redAccent,
                    elevation: 5.0,
                    child: Text(
                      "Generate Backup",
                      style: TextStyle(fontSize: screenSize.screenHeight * 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.screenHeight * 10),
          child: Container(
            width: screenSize.screenWidth * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableButton(
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PMSDataEntry()));
                  },
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "Data Entry",
                ),
                SizedBox(height: screenSize.screenHeight * 5),
                ReusableButton(
                  onPress: () {},
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "View Past Data",
                ),
                SizedBox(height: screenSize.screenHeight * 5),
              ],
            ),
          )),
    );
  }
}
