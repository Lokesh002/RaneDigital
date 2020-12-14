import 'package:flutter/material.dart';
import 'package:rane_dms/components/reusableCourseCard.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert' as convert;
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:rane_dms/screens/documentScreens/openPDF.dart';

class DeptInFolder extends StatefulWidget {
  final String id;
  final String folderName;
  final String dept;
  DeptInFolder(this.id, this.folderName, this.dept);
  @override
  _DeptInFolderState createState() => _DeptInFolderState();
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

class _DeptInFolderState extends State<DeptInFolder> {
  var screenSize;
  bool downloadComplete = false;
  String downloadMessage = 'Initializing...';
  bool isDownloading = false;
  @override
  Widget build(BuildContext context) {
    return ShowScreen(isReady);
  }

  List<Docs> docsList = List<Docs>();
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getDocsList();
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
        var percentage = (actualbytes / totalbytes) * 100;

        setState(() {
          downloadMessage = 'Downloading....  ${percentage.floor()}%';
          if (percentage == 100) {
            downloadComplete = true;
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
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }

//
//    dio.download(url, '${dir.path}/kartikResume.pdf',
//        onReceiveProgress: (actualbytes, totalbytes) {
//      var percentage = (actualbytes / totalbytes) * 100;
//
//      setState(() {
//        downloadMessage = 'Downoading....  ${percentage.floor()}%';
//        if(percentage==100)
    //{
    //     downloadComplete=true;
    //}
//      });
//    });
    downloadComplete = true;
  }

  var veh;

  void getDocsList() async {
    var decodedData =
        await getData("http://192.168.43.18:3000/view/" + widget.id);

    List data = decodedData;
    print(data.length);
    print(data);

    for (int i = 0; i < data.length; i++) {
      Docs docs = Docs();
      docs.name = data[i]["name"];
      docs.link = data[i]["url"];
      docs.date = data[i]["updatedAt"].toString().substring(8, 10) +
          "/" +
          data[i]["updatedAt"].toString().substring(5, 7) +
          "/" +
          data[i]["updatedAt"].toString().substring(0, 4);
      docs.size = data[i]["size"] < 1048576
          ? (data[i]["size"] / 1024.00).toStringAsFixed(1) + " KB"
          : (data[i]["size"] / 1048576.00).toStringAsFixed(1) + " MB";
      print(docs.size);
      docsList.add(docs);
    }
    isReady = true;
    setState(() {});
  }

  Future getData(String url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = convert.jsonDecode(data);
      return decodedData;
    } else
      print(response.statusCode);
    return null;
  }

  Widget ShowScreen(bool isReady) {
    screenSize = SizeConfig(context);
    if (!isReady) {
      return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SpinKitWanderingCubes(
          color: Colors.teal,
          shape: BoxShape.circle,
          size: 100.0,
        ),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.blue,
          title: Text(widget.folderName),
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              itemBuilder: (BuildContext cntxt, int index) {
                return ReusableCourseCard(
                    name: docsList[index].name,
                    color: Colors.red,
                    lastUpdate: "Last updated: " + docsList[index].date,
                    onTap: () async {
                      print(docsList[index].link);
                      //if (docsList[index].link.contains(".pdf", 41)) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        //Here DecodedData is a locally saved variable containing selected course data
                        return OpenPDF(docsList[index].link);
                      }));
//                      }
//                      else {
//                        await download(
//                            docsList[index].link, docsList[index].name);
//                        Navigator.pop(context);
//                      }
                    },
                    dept: widget.dept,
                    size: docsList[index].size);
              },
              itemCount: docsList.length,
              padding: EdgeInsets.fromLTRB(0, screenSize.screenHeight * 2.5, 0,
                  screenSize.screenHeight * 2.5)),
//
        ),
      );
  }
}

//
class Docs {
  String name;
  String link;
  String date;
  String size;
}
