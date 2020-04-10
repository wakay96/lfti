/// This class serves as template for all container
import "package:dotted_border/dotted_border.dart";
import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

class CustomCard extends StatelessWidget {
  final Widget cardChild;
  final Function onTap;
  final Color color;
  bool dottedBorder;
  Key key;

  CustomCard({
    @required this.cardChild,
    this.onTap,
    this.dottedBorder = false,
    this.color = kCardBackground,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: kCardMargin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: this.color,
        ),
        child: DottedBorder(
          color: this.dottedBorder ? Colors.black : Colors.transparent,
          strokeWidth: 2,
          padding: kContentPadding,
          dashPattern: [6.0, 6.0, 6.0, 6.0],
          child: this.cardChild,
        ),
      ),
    );
  }
}
