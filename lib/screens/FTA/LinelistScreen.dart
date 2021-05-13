import 'package:flutter/material.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/FTA/machineListScreen.dart';

class FTALineListScreen extends StatefulWidget {
  @override
  _FTALineListScreenState createState() => _FTALineListScreenState();
}

class _FTALineListScreenState extends State<FTALineListScreen> {
  List<Line> lineList;
  List<Line> lines = [];
  List<Machines> machines = [];
  bool isLoaded = false;
  getLine() async {
    LineDataStructure lineDataStructure = LineDataStructure();
    lineList = await lineDataStructure.getLines();

    this.isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine();
  }

  SizeConfig screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Lines"),
      ),
      body: !isLoaded
          ? Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.screenWidth * 5,
                      vertical: screenSize.screenHeight * 2),
                  child: Container(
                    height: screenSize.screenHeight * 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FTAMachineListScreen(
                                    lineList[index].machines,
                                    lineList[index].lineId)));
                      },
                      child: Material(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenSize.screenHeight * 2),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.screenWidth * 5,
                              vertical: screenSize.screenHeight * 2),
                          child: Center(
                            child: Text(
                              lineList[index].lineName,
                              style: TextStyle(
                                  fontSize: screenSize.screenHeight * 3,
                                  color: Colors.teal),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: lineList.length,
              ),
            ),
    );
  }
}
