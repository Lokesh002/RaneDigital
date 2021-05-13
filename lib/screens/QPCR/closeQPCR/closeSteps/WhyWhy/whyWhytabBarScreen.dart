import 'package:flutter/material.dart';
import 'package:rane_dms/components/sharedPref.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/WhyWhy/detectionWhyWhy.dart';
import 'package:rane_dms/screens/QPCR/closeQPCR/closeSteps/WhyWhy/occurenceWhyWhy.dart';

class WhyWhyTabBarScreen extends StatefulWidget {
  final int index;
  WhyWhyTabBarScreen(this.index);

  @override
  _WhyWhyTabBarScreenState createState() => _WhyWhyTabBarScreenState();
}

class _WhyWhyTabBarScreenState extends State<WhyWhyTabBarScreen> {
  List<Widget> _widgets = <Widget>[];
  int _defaultIndex = 0;
  int _selectedIndex;
  PageController pageController = new PageController();

  SavedData savedData = SavedData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = _defaultIndex;
  }

  SizeConfig screenSize;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Occurrence/Detection WhyWhy"),
      ),
      body: PageView(
        onPageChanged: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        controller: pageController,
        children: [
          OccurrenceWhyWhy(widget.index),
          DetectionWhyWhy(widget.index)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (page) {
          setState(() {
            _selectedIndex = page;
          });
          pageController.jumpToPage(page);
        },
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme:
            IconThemeData(color: Theme.of(context).accentColor),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              child: CircleAvatar(
                radius: _selectedIndex == 0
                    ? screenSize.screenHeight * 2.6
                    : screenSize.screenHeight * 2.5,
                backgroundColor: _selectedIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                child: Icon(
                  _selectedIndex == 0
                      ? Icons.account_tree_sharp
                      : Icons.account_tree_outlined,
                  color: _selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                // color: _selectedIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            label: "Occurrence Stage",
          ),
          BottomNavigationBarItem(
              icon: Container(
                child: CircleAvatar(
                  radius: screenSize.screenHeight * 2.5,
                  backgroundColor: _selectedIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  child: Icon(
                    _selectedIndex == 1
                        ? Icons.zoom_out_sharp
                        : Icons.zoom_out_rounded,
                    color: _selectedIndex == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ),
              label: 'Detection Stage'),
        ],
      ),
    );
  }
}
