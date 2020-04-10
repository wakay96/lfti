import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:lfti_app/classes/Constants.dart";

class CustomButtonCard extends StatelessWidget {
  final Key key;
  final Function onTap;
  final Color color;
  final IconData icon;
  const CustomButtonCard(
      {this.key, @required this.onTap, this.color, this.icon = Icons.add});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: this.color,
        child: Center(
          child: Icon(
            this.icon,
            size: 40.0,
            color: kIconColor,
          ),
        ),
      ),
      onTap: this.onTap,
    );
  }
}
