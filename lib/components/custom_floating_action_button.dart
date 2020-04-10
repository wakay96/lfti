import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class CustomFloatingActionButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color color;
  const CustomFloatingActionButton(
      {@required this.onPressed, this.icon = Icons.add, this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kFloatingActionButtonColor.withOpacity(0.9),
      child: Icon(this.icon, size: 40.0),
      onPressed: () => onPressed(),
    );
  }
}
