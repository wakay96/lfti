import 'dart:convert';

import 'package:uuid/uuid.dart';

class UserInfo {
  Uuid id;
  String firstName;
  String lastName;
  String email;
  double currentWeight;
  double targetWeight;
  double height;
  double currentBodyFat;
  double targetBodyFat;

  UserInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.currentWeight,
    this.targetWeight,
    this.currentBodyFat,
    this.targetBodyFat,
    this.height,
  });

  factory UserInfo.fromJson(String json) {
    var decoded = jsonDecode(json);
    return UserInfo(
      id: decoded['id'] as Uuid,
      firstName: decoded['firstName'] as String,
      lastName: decoded['lastName'] as String,
      email: decoded['email'] as String,
      currentWeight: decoded['currentWeight'] as double,
      targetWeight: decoded['targetWeight'] as double,
      height: decoded['height'] as double,
      currentBodyFat: decoded['currentBodyFat'] as double,
      targetBodyFat: decoded['targetBodyFat'] as double,
    );
  }
}
