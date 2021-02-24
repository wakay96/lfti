import 'package:flutter/material.dart';

class UserInfo {
  String id;
  String firstName;
  String lastName;
  String email;

  UserInfo({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
  });
}
