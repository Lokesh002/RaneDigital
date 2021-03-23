import 'package:flutter/material.dart';
import 'package:rane_dms/components/sizeConfig.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget cardChild;
  final Function onPress;
  ReusableCard({@required this.colour, this.cardChild, this.onPress});

  @override
  Widget build(BuildContext context) {
    SizeConfig screenSize = SizeConfig(context);
    return GestureDetector(
      onTap: onPress,
      child: Container(
        // width: screenSize.screenWidth * 40,
        // height: screenSize.screenHeight * 20,
        margin: EdgeInsets.symmetric(
            vertical: screenSize.screenHeight * 2.5,
            horizontal: screenSize.screenWidth * 5),
        child: cardChild,
        padding: EdgeInsets.symmetric(horizontal: screenSize.screenWidth * 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenSize.screenHeight * 3),
          border: Border.all(color: Colors.blueAccent, width: 1),
          color: colour,
        ),
      ),
    );
  }
}
