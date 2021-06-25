// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rane_dms/components/ReusableButton.dart';
// import 'package:rane_dms/components/courseCard.dart';
// import 'package:rane_dms/components/networking.dart';
// import 'package:rane_dms/components/sharedPref.dart';
// import 'package:rane_dms/components/sizeConfig.dart';
//
// class QPCRMainScreen extends StatefulWidget {
//   @override
//   _QPCRMainScreenState createState() => _QPCRMainScreenState();
// }
//
// SavedData savedData = SavedData();
//
// class _QPCRMainScreenState extends State<QPCRMainScreen> {
//   SizeConfig screenSize;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//   }
//
//   String accountType;
//
//   getData() async {
//     accountType = SavedData.getAccountType();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenSize = SizeConfig(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: EdgeInsets.symmetric(vertical: screenSize.screenHeight * 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("QPCR"),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenSize.screenWidth * 5),
//                 child: Visibility(
//                   visible: accountType == 'admin',
//                   child: MaterialButton(
//                     onPressed: () async {
//                       Networking networking = Networking();
//                       var data = await networking.getData('QPCR/makeBackup');
//                       if (data != null) {
//                         Fluttertoast.showToast(msg: data['msg']);
//                       }
//                     },
//                     height: screenSize.screenHeight * 5,
//                     minWidth: screenSize.screenWidth * 20,
//                     color: Colors.redAccent,
//                     elevation: 5.0,
//                     child: Text(
//                       "Generate Backup",
//                       style: TextStyle(fontSize: screenSize.screenHeight * 2),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//         elevation: 5.0,
//       ),
//       backgroundColor: Theme.of(context).backgroundColor,
//       body: Padding(
//           padding: EdgeInsets.symmetric(vertical: screenSize.screenHeight * 10),
//           child: Container(
//             width: screenSize.screenWidth * 100,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ReusableButton(
//                   onPress: () {
//                     Navigator.pushNamed(context, '/generateQPCRScreen');
//                   },
//                   height: screenSize.screenHeight * 10,
//                   width: screenSize.screenWidth * 80,
//                   content: "Generate QPCR",
//                 ),
//                 SizedBox(height: screenSize.screenHeight * 5),
//                 ReusableButton(
//                   onPress: () {
//                     Navigator.pushNamed(context, '/viewQPCRScreen');
//                   },
//                   height: screenSize.screenHeight * 10,
//                   width: screenSize.screenWidth * 80,
//                   content: "View QPCR Past Data",
//                 ),
//                 SizedBox(height: screenSize.screenHeight * 5),
//                 ReusableButton(
//                   onPress: () {
//                     Navigator.pushNamed(context, '/closeQPCRScreen');
//                   },
//                   height: screenSize.screenHeight * 10,
//                   width: screenSize.screenWidth * 80,
//                   content: "Close QPCR",
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
