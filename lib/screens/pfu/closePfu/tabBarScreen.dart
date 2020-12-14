import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/pfu/closePfu/machineListScreen.dart';
import 'package:rane_dms/screens/pfu/closePfu/myPFUScreen.dart';

class TabBarScreen extends StatefulWidget {
  final String selectedDepartment;
  TabBarScreen(this.selectedDepartment);
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  List<Widget> _widgets = <Widget>[];
  int _defaultIndex = 0;
  int _selectedIndex;

  void _onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //TabController tabController = TabController(length: 2, vsync: null);
  SavedData savedData = SavedData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = _defaultIndex;
  }

  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("PFU List",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: screenSize.screenHeight * 3)),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 5,
          bottom: TabBar(
            physics: NeverScrollableScrollPhysics(),
            unselectedLabelColor: Theme.of(context).accentColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(screenSize.screenHeight * 5),
              color: Theme.of(context).accentColor,
            ),
            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Text(
                    "PFU from " + widget.selectedDepartment,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    "My PFU",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
            onTap: _onTapHandler,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: TabBarView(children: [
          MachineListScreen(widget.selectedDepartment),
          MyPFUScreen(widget.selectedDepartment)
        ]),
      ),
    );
  }
}
