import 'package:flutter/material.dart';

class Exercise {
  String name;
  String focus;

  Exercise({@required this.name, this.focus = "--"});

  rename(String name) {
    this.name = name;
  }
}
