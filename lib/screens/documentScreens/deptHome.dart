import 'package:flutter/material.dart';
import 'package:rane_dms/components/networking.dart';
import 'package:rane_dms/components/reusableCourseCard.dart';
import 'package:rane_dms/screens/documentScreens/deptInFolder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class DeptHome extends StatefulWidget {
  final String dept;
  DeptHome(this.dept);
  @override
  _DeptHomeState createState() => _DeptHomeState();
}

class _DeptHomeState extends State<DeptHome> {
  SizeConfig screenSize;

  @override
  Widget build(BuildContext context) {
    return showScreen(isReady);
  }

  List<Folders> foldersList = List<Folders>();
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getDocsList();
    }
  }

  var veh;

  void getDocsList() async {
    Networking networking = Networking();
    var decodedData = await networking.getData(widget.dept);
    List data = decodedData;

    for (int i = 0; i < data.length; i++) {
      Folders folders = Folders();
      folders.folderName = data[i]["name"].toString().trim();
      folders.date = data[i]["updatedAt"].toString().substring(8, 10) +
          "/" +
          data[i]["updatedAt"].toString().substring(5, 7) +
          "/" +
          data[i]["updatedAt"].toString().substring(0, 4);
      folders.id = data[i]["_id"].toString();

      foldersList.add(folders);
    }
    isReady = true;
    setState(() {});
  }

  Widget showScreen(bool isReady) {
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
          title: Text(widget.dept + " Folders"),
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              itemBuilder: (BuildContext cntxt, int index) {
                return ReusableCourseCard(
                    name: foldersList[index].folderName,
                    color: Colors.red,
                    lastUpdate: "Last Updated: " + foldersList[index].date,
                    isFolder: true,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        //Here DecodedData is a locally saved variable containing selected course data
                        return DeptInFolder(foldersList[index].id,
                            foldersList[index].folderName, widget.dept);
                      }));
                    },
                    dept: widget.dept,
                    size: "-");
              },
              itemCount: foldersList.length,
              padding: EdgeInsets.fromLTRB(0, screenSize.screenHeight * 2.5, 0,
                  screenSize.screenHeight * 2.5)),
//
        ),
      );
  }
}

//
class Folders {
  String id;
  String folderName;
  String date;
}
