import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart';

class NavBar {
  final String label;
  NavBar(this.label);
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu, size: 35),
      backgroundColor: primaryColor,
      shadowColor: Colors.transparent,
      title: Container(
        alignment: Alignment.bottomRight,
        child: Text(
          label,
          style: appBarTitleTextStyleLight,
        ),
      ),
      centerTitle: false,
    );
  }
}
