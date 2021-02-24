import 'package:flutter/material.dart';

class UserAccountData {
  String id;
  String firstName;
  String lastName;
  String email;

  UserAccountData({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
  });
}
