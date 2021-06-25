// import 'package:flutter/material.dart';
// import 'package:rane_dms/components/sharedPref.dart';
// import 'package:rane_dms/components/sizeConfig.dart';
// import 'package:rane_dms/screens/QPCR/closeQPCR/otherDeptQPCR.dart';
//
// import 'package:rane_dms/screens/QPCR/closeQPCR/myQPCRScreen.dart';
//
// class TabBarScreen extends StatefulWidget {
//   final String selectedDepartment;
//   TabBarScreen(this.selectedDepartment);
//   @override
//   _TabBarScreenState createState() => _TabBarScreenState();
// }
//
// class _TabBarScreenState extends State<TabBarScreen> {
//   List<Widget> _widgets = <Widget>[];
//   int _defaultIndex = 0;
//   int _selectedIndex;
//   PageController pageController = new PageController();
//
//   SavedData savedData = SavedData();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     _selectedIndex = _defaultIndex;
//   }
//
//   SizeConfig screenSize;
//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenSize = SizeConfig(context);
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[],
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Text("QPCR List",
//                 style: TextStyle(
//                     color: Theme.of(context).accentColor,
//                     fontSize: screenSize.screenHeight * 3)),
//           ],
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//         elevation: 5,
//       ),
//       // backgroundColor: Theme.of(context).accentColor,
//       body: PageView(
//         onPageChanged: (index) {
//           _selectedIndex = index;
//           setState(() {});
//         },
//         controller: pageController,
//         children: [
//           OtherDeptQPCR(widget.selectedDepartment),
//           MyQPCRScreen(widget.selectedDepartment)
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         onTap: (page) {
//           setState(() {
//             _selectedIndex = page;
//           });
//           pageController.jumpToPage(page);
//         },
//         currentIndex: _selectedIndex,
//         selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
//         unselectedIconTheme:
//             IconThemeData(color: Theme.of(context).accentColor),
//         unselectedLabelStyle: TextStyle(color: Colors.white),
//         backgroundColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         items: [
//           BottomNavigationBarItem(
//             icon: Container(
//               child: CircleAvatar(
//                   radius: _selectedIndex == 0
//                       ? screenSize.screenHeight * 2.6
//                       : screenSize.screenHeight * 2.5,
//                   backgroundColor: _selectedIndex == 0
//                       ? Theme.of(context).accentColor
//                       : Colors.white,
//                   child: Image.asset('images/${widget.selectedDepartment}.png')
//                   // color: _selectedIndex == 0 ? Colors.white : Colors.black,
//
//                   ),
//             ),
//             label: "QPCR from ${widget.selectedDepartment}",
//           ),
//           BottomNavigationBarItem(
//               icon: Container(
//                 child: CircleAvatar(
//                   radius: screenSize.screenHeight * 2.5,
//                   backgroundColor: _selectedIndex == 1
//                       ? Theme.of(context).primaryColor
//                       : Colors.white,
//                   child: Icon(
//                     _selectedIndex == 1
//                         ? Icons.favorite
//                         : Icons.favorite_border,
//                     color: _selectedIndex == 1 ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//               label: 'My QPCR'),
//         ],
//       ),
//     );
//   }
// }
