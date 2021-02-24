import 'package:flutter/material.dart';

class UserData {
  double currentWeight;
  double targetWeight;
  double height;

  /// TODO: account for metric system
  /// Currently in in inches
  double currentBodyFat;
  double targetBodyFat;

  UserData({
    this.currentWeight,
    this.targetWeight,
    this.currentBodyFat,
    this.targetBodyFat,
    this.height,
  });
}
