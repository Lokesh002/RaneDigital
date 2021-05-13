import 'package:flutter/material.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class PMSDataEntry extends StatefulWidget {
  @override
  _PMSDataEntryState createState() => _PMSDataEntryState();
}

class _PMSDataEntryState extends State<PMSDataEntry> {
  SizeConfig screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      body: Container(
        height: screenSize.screenHeight * 100,
        width: screenSize.screenWidth * 100,
        child: TextField(
          maxLines: 3,
          minLines: 1,
          onChanged: (v) {
            print(v);
          },
        ),
      ),
    );
  }
}
