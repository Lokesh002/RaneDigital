// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rane_dms/components/QPCRDataStructure.dart';
// import 'package:rane_dms/components/constants.dart';
// import 'package:rane_dms/components/networking.dart';
// import 'package:rane_dms/components/sizeConfig.dart';
//
// class TeamInvolvedScreen extends StatefulWidget {
//   @override
//   _TeamInvolvedScreenState createState() => _TeamInvolvedScreenState();
// }
//
// class _TeamInvolvedScreenState extends State<TeamInvolvedScreen> {
//   SizeConfig screenSize;
//   QPCR qpcr = QPCR();
//   Team selectedMember;
//   List<Team> notSelectedUsers = [];
//   List<Team> selectedUsers = [];
//   bool isReady = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     qpcr = globalQpcr;
//     getData();
//   }
//
//   void getData() async {
//     Networking networking = Networking();
//     var d = await networking.getData('User/getAllUsers');
//     log(d.toString());
//     List userList = d;
//     for (int i = 0; i < userList.length; i++) {
//       log(userList[i]['username'].toString());
//       Team u = Team();
//       u.username = userList[i]['username'];
//       u.date = null;
//       u.isLeader = false;
//
//       notSelectedUsers.add(u);
//       // log(users.toString());
//     }
//     log(notSelectedUsers.toString());
//
//     if (globalQpcr.teamInvolved.isEmpty) {
//       print("not present");
//     } else {
//       selectedUsers = globalQpcr.teamInvolved;
//       selectedUsers.forEach((element) {
//         notSelectedUsers.remove(element);
//       });
//     }
//     isReady = true;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //print(selectedMember.username);
//     screenSize = SizeConfig(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Team Involved"),
//       ),
//       backgroundColor: Colors.white,
//       body: !isReady
//           ? Container(
//               width: screenSize.screenWidth * 100,
//               height: screenSize.screenHeight * 90,
//               child: Center(child: CircularProgressIndicator()),
//             )
//           : Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                           padding:
//                               EdgeInsets.only(top: screenSize.screenHeight * 5),
//                           child: Container(
//                             width: screenSize.screenWidth * 100,
//                             height: screenSize.screenHeight * 15,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: screenSize.screenWidth * 5),
//                                   child: Container(
//                                     width: screenSize.screenWidth * 50,
//                                     height: screenSize.screenHeight * 10,
//                                     child: DropdownButtonFormField(
//                                         hint: Text('Please select member'),
//                                         value: selectedMember,
//                                         onChanged: (e) {
//                                           selectedMember = e;
//                                           setState(() {});
//                                         },
//                                         elevation: 5,
//                                         items: notSelectedUsers
//                                             .map((e) => DropdownMenuItem(
//                                                 child: Text(e.username + " "),
//                                                 value: e))
//                                             .toList()),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: screenSize.screenWidth * 2),
//                                   child: MaterialButton(
//                                     onPressed: () {
//                                       if (selectedMember != null) {
//                                         selectedUsers.add(selectedMember);
//                                         Team m = selectedMember;
//                                         selectedMember = null;
//
//                                         //setState(() {});
//                                         notSelectedUsers.remove(m);
//                                         m = null;
//                                         setState(() {});
//                                       } else {
//                                         Fluttertoast.showToast(
//                                             msg:
//                                                 "Please select a member first");
//                                       }
//                                     },
//                                     elevation: 5,
//                                     color: Colors.green,
//                                     height: screenSize.screenHeight * 5,
//                                     minWidth: screenSize.screenWidth * 7,
//                                     child: Text(
//                                       "+",
//                                       style: TextStyle(
//                                           fontSize: screenSize.screenHeight * 4,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )),
//                       Container(
//                         width: screenSize.screenWidth * 100,
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: screenSize.screenWidth * 2),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     "S.No",
//                                     style: TextStyle(
//                                         fontSize:
//                                             screenSize.screenHeight * 2.5),
//                                   )),
//                               Expanded(
//                                   flex: 5,
//                                   child: Text(
//                                     "Name",
//                                     style: TextStyle(
//                                         fontSize:
//                                             screenSize.screenHeight * 2.5),
//                                   )),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(
//                                     "Leader",
//                                     style: TextStyle(
//                                         fontSize:
//                                             screenSize.screenHeight * 2.5),
//                                   )),
//                               Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     "",
//                                     style: TextStyle(
//                                         fontSize:
//                                             screenSize.screenHeight * 2.5),
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: screenSize.screenWidth * 100,
//                         height: screenSize.screenHeight * 50,
//                         child: ListView(
//                             children: selectedUsers
//                                 .map((e) => Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: screenSize.screenHeight * 1,
//                                           horizontal:
//                                               screenSize.screenWidth * 2),
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 (selectedUsers.indexOf(e) + 1)
//                                                     .toString(),
//                                                 style: TextStyle(
//                                                     fontSize: screenSize
//                                                             .screenHeight *
//                                                         2.5),
//                                               )),
//                                           Expanded(
//                                               flex: 5,
//                                               child: Text(
//                                                 e.username,
//                                                 style: TextStyle(
//                                                     fontSize: screenSize
//                                                             .screenHeight *
//                                                         2.5),
//                                               )),
//                                           Expanded(
//                                               flex: 3,
//                                               child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: CupertinoSwitch(
//                                                   value: e.isLeader,
//                                                   onChanged: (v) {
//                                                     e.isLeader = v;
//                                                     setState(() {});
//                                                   },
//                                                 ),
//                                               )),
//                                           Expanded(
//                                               flex: 1,
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   e.isLeader = false;
//                                                   selectedUsers.remove(e);
//                                                   notSelectedUsers.add(e);
//                                                   setState(() {});
//                                                 },
//                                                 child: Container(
//                                                   color: Colors.red,
//                                                   height:
//                                                       screenSize.screenHeight *
//                                                           4,
//                                                   width:
//                                                       screenSize.screenWidth *
//                                                           4,
//                                                   child: Center(
//                                                     child: Text(
//                                                       "-",
//                                                       style: TextStyle(
//                                                           fontSize: screenSize
//                                                                   .screenHeight *
//                                                               4,
//                                                           color: Colors.white),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )),
//                                         ],
//                                       ),
//                                     ))
//                                 .toList()),
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       globalQpcr.teamInvolved = [];
//                       globalQpcr.teamInvolved = selectedUsers;
//                       Networking networking = Networking();
//                       if (selectedUsers.length > 0) {
//                         QPCRList qpcrList = QPCRList();
//                         var map = qpcrList.QpcrToMap(globalQpcr);
//                         var d = await networking
//                             .postData('QPCR/QPCRSave', {"newQPCR": map});
//                         globalQpcr = qpcrList.getQPCR(d);
//
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => TeamInvolvedScreen()));
//                         isReady = true;
//                       } else {
//                         Fluttertoast.showToast(
//                             msg: "Please add at least one member");
//                       }
//                     },
//                     child: Container(
//                       width: screenSize.screenWidth * 100,
//                       height: screenSize.screenHeight * 10,
//                       color: Colors.green,
//                       child: Center(
//                           child: Text(
//                         "Proceed",
//                         style: TextStyle(
//                             fontSize: screenSize.screenHeight * 4,
//                             color: Colors.white),
//                       )),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }
