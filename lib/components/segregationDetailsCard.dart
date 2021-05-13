// import 'package:flutter/material.dart';
//
// class SegregationDetailsCard extends StatefulWidget {
//   @override
//   _SegregationDetailsCardState createState() => _SegregationDetailsCardState();
// }
//
// class _SegregationDetailsCardState extends State<SegregationDetailsCard> {
//   var rejQtyBefReworkController = TextEditingController();
//   var sapQtyCheckController = TextEditingController();
//   var rewQtyController = TextEditingController();
//   var rewOkQtyController = TextEditingController();
//   var remarksController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return CourseCard(
//       cardChild: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('Detail ${index + 1}'),
//             ),
//             DropdownButtonFormField(
//               decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   labelText: 'Parts checked At'),
//               items: getNameList(),
//               onChanged: (v) {
//                 selectedPartsCheckedAt.add(v);
//                 if (v != "Others(Transit/Warehouse)") {
//                   partsCheckedAt.remove(v);
//                 }
//               },
//               value: selectedPartsCheckedAt.length > index
//                   ? selectedPartsCheckedAt[index]
//                   : null,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MaterialButton(
//                   color: Colors.blueGrey,
//                   child: Text(
//                     "Occurring date",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontFamily: "Roboto",
//                     ),
//                   ),
//                   height: 30,
//                   minWidth: 100,
//                   onPressed: () async {
//                     showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(0),
//                             lastDate: DateTime.now())
//                         .then((date) {
//                       setState(() {
//                         _dateTime = date;
//                         print(_dateTime.toString());
//                       });
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Text(_dateTime != null
//                     ? _dateTime
//                         .subtract(Duration(days: 1))
//                         .toString()
//                         .substring(0, 10)
//                     : " Please select a Date"),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 MaterialButton(
//                   color: Colors.blueGrey,
//                   child: Text(
//                     "Segregation date",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontFamily: "Roboto",
//                     ),
//                   ),
//                   height: 30,
//                   minWidth: 100,
//                   onPressed: () async {
//                     showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(0),
//                             lastDate: DateTime.now())
//                         .then((date) {
//                       setState(() {
//                         _segDateTime = date;
//                         print(_segDateTime.toString());
//                       });
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Text(_segDateTime != null
//                     ? _segDateTime
//                         .subtract(Duration(days: 1))
//                         .toString()
//                         .substring(0, 10)
//                     : " Please select a Date"),
//               ],
//             ),
//             TextFormField(
//                 initialValue: qpcr1.segregationDetails.length != 0
//                     ? qpcr1.segregationDetails[index].rejectedQtyBeforeRework
//                         .toString()
//                     : null,
//                 controller: rejQtyBefReworkController,
//                 decoration: InputDecoration(
//                     labelText: 'Rejected Qty before Rework',
//                     fillColor: Colors.white,
//                     filled: true)),
//             TextFormField(
//                 initialValue: qpcr1.segregationDetails.length != 0
//                     ? qpcr1.segregationDetails[index].remarks
//                     : null,
//                 controller: sapQtyCheckController,
//                 decoration: InputDecoration(
//                     labelText: 'SAP Qty to be Checked',
//                     fillColor: Colors.white,
//                     filled: true)),
//             TextFormField(
//                 initialValue: qpcr1.segregationDetails.length != 0
//                     ? qpcr1.segregationDetails[index].remarks
//                     : null,
//                 controller: rewQtyController,
//                 decoration: InputDecoration(
//                     labelText: 'Rework Qty',
//                     fillColor: Colors.white,
//                     filled: true)),
//             TextFormField(
//                 initialValue: qpcr1.segregationDetails.length != 0
//                     ? qpcr1.segregationDetails[index].remarks
//                     : null,
//                 controller: rewOkQtyController,
//                 decoration: InputDecoration(
//                     labelText: 'Rework OK Qty',
//                     fillColor: Colors.white,
//                     filled: true)),
//             TextFormField(
//                 initialValue: qpcr1.segregationDetails.length != 0
//                     ? qpcr1.segregationDetails[index].remarks
//                     : null,
//                 controller: remarksController,
//                 decoration: InputDecoration(
//                     labelText: 'Remarks',
//                     fillColor: Colors.white,
//                     filled: true)),
//           ],
//         ),
//       ),
//     );
//   }
// }
