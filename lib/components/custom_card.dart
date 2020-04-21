/// This class serves as template for all container
import "package:dotted_border/dotted_border.dart";
import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';

class CustomCard extends StatelessWidget {
  final Widget cardChild;
  final Function onTap;
  final Color color;
  final bool dottedBorder;
  final Key key;
  final bool shadow;
  final double width;
  final double height;

  CustomCard({
    @required this.cardChild,
    this.onTap,
    this.dottedBorder = false,
    this.color = kCardBackground,
    this.key,
    this.shadow = false,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: kCardMargin,
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
          boxShadow: shadow == true
              ? [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: Offset(4.0, 2.0),
                  )
                ]
              : null,
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
