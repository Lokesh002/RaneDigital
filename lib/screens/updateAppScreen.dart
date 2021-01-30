import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class UpdateAppScreen extends StatefulWidget {
  @override
  _UpdateAppScreenState createState() => _UpdateAppScreenState();
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _UpdateAppScreenState extends State<UpdateAppScreen> {
  bool isReady = false;
  SavedData savedData = SavedData();
  SizeConfig screenSize;
  bool downloadComplete = false;
  String downloadMessage = 'Initializing...';
  bool isDownloading = false;
  bool downloadStart = false;
  String accessTKN;
  Future getPermission() async {
    print("permission");

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future download(String url, String name) async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    String fullPath = "$path/$name";

    try {
      Dio dio = Dio();
      showAlertDialog(context);
      Response response =
          await dio.get(url, onReceiveProgress: (actualbytes, totalbytes) {
        print("yoyo");
        print(actualbytes);
        var percentage = (actualbytes / totalbytes) * 100;

        setState(() {
          downloadStart = true;
          downloadMessage = 'Downloading....  ${percentage.floor()}%';
          if (percentage == 100) {
            downloadComplete = true;
            Navigator.pop(context);
            setState(() {
              Fluttertoast.showToast(
                  msg: "Go to Internal Storage/Downloads to check the file.");
            });
          }
        });
      },
              options: Options(
                  responseType: ResponseType.bytes,
                  followRedirects: false,
                  validateStatus: (status) {
                    return status < 500;
                  }));
      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }

    downloadComplete = true;
  }

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
            child: Container(
          child: Column(children: <Widget>[
            Container(
                width: screenSize.screenWidth * 80,
                height: screenSize.screenHeight * 25,
                child: Hero(
                  child: Image.asset(
                    "images/logo.png",
                    fit: BoxFit.fitWidth,
                  ),
                  tag: "logo",
                )),
            SizedBox(
              height: screenSize.screenHeight * 4,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.screenWidth * 10),
              child: Text(
                "App is Updated. \n\nPlease download the updated app first.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenSize.screenHeight * 2,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              height: screenSize.screenHeight * 30,
            ),
            Visibility(
              visible: downloadStart,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.screenWidth * 10),
                child: Text(
                  downloadMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenSize.screenHeight * 2,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.screenWidth * 10),
              child: MaterialButton(
                onPressed: () async {
                  await download(ipAddress + "apk", "RaneDigital.apk");
                },
                height: screenSize.screenHeight * 5,
                minWidth: screenSize.screenWidth * 30,
                elevation: 5,
                color: Colors.blue,
                child: Text(
                  "Download",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        )));
  }
}
