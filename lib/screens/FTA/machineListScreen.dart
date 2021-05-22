import 'package:flutter/material.dart';
import 'package:rane_dms/components/lineDataStructure.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/FTA/ftaListScreen.dart';

class FTAMachineListScreen extends StatefulWidget {
  List<Machines> machineList;
  String lineId;
  FTAMachineListScreen(this.machineList, this.lineId);
  @override
  _FTAMachineListScreenState createState() => _FTAMachineListScreenState();
}

class _FTAMachineListScreenState extends State<FTAMachineListScreen> {
  List<Machines> machines = [];
  bool isLoaded = false;
  getMachines() async {
    machines = widget.machineList;

    this.isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMachines();
  }

  SizeConfig screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Machines"),
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
                                builder: (context) => FTAListScreen(
                                    null,
                                    null,
                                    machines[index].machineId,
                                    machines[index].machineCode.toLowerCase() !=
                                            "others"
                                        ? machines[index].machineCode +
                                            " - " +
                                            machines[index].machineName
                                        : machines[index].machineName,
                                    widget.lineId,
                                    null)));
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
                              machines[index].machineCode.toLowerCase() !=
                                      "others"
                                  ? machines[index].machineCode +
                                      " - " +
                                      machines[index].machineName
                                  : machines[index].machineName,
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
                itemCount: machines.length,
              ),
            ),
    );
  }
}
