import 'package:flutter/material.dart';
import 'package:rane_dms/components/sizeConfig.dart';
import 'constants.dart';

class IconContent extends StatelessWidget {
  final String icon;
  final String label;

  IconContent({this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          icon,
          width: screenSize.screenWidth * 10,
          height: screenSize.screenHeight * 5,
        ),
        SizedBox(
          height: screenSize.screenHeight,
        ),
        Text(
          label,
          style: TextStyle(
            color: ktextColor,
          ),
        )
      ],
    );
  }
}
