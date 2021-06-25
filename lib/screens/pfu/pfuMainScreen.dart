import 'package:flutter/material.dart';
import 'package:rane_dms/components/ReusableBorderButton.dart';
import 'package:rane_dms/components/ReusableButton.dart';
import 'package:rane_dms/components/courseCard.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class PFUMainScreen extends StatefulWidget {
  @override
  _PFUMainScreenState createState() => _PFUMainScreenState();
}

SavedData savedData = SavedData();

class _PFUMainScreenState extends State<PFUMainScreen> {
  SizeConfig screenSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  String accountType;

  getData() async {
    accountType = SavedData.getAccountType();
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
              Text("PFU"),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.screenWidth * 5),
                child: Visibility(
                  visible: accountType == 'admin',
                  child: MaterialButton(
                    onPressed: () async {
                      Networking networking = Networking();
                      var data = await networking.getData('PFU/makeBackup');
                      if (data != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(data['msg'])));
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
                ReusableBorderButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/generatePFUScreen');
                  },
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "Generate PFU",
                ),
                SizedBox(height: screenSize.screenHeight * 5),
                ReusableBorderButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/viewPFUScreen');
                  },
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "View PFU History",
                ),
                SizedBox(height: screenSize.screenHeight * 5),
                ReusableBorderButton(
                  onPress: () {
                    Navigator.pushNamed(context, '/closePFUScreen');
                  },
                  height: screenSize.screenHeight * 10,
                  width: screenSize.screenWidth * 80,
                  content: "Close PFU",
                )
              ],
            ),
          )),
    );
  }
}
