// library imports
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:shared_preferences/shared_preferences.dart";

// class imports
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/components/loader.dart';
import "package:lfti_app/classes/User.dart";

import "dart:async";

class LoginPage extends StatefulWidget {
  final Map<String, String> _emailAndPassword;
  LoginPage(this._emailAndPassword);
  @override
  _LoginPageState createState() => _LoginPageState(_emailAndPassword);
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> _userCredentials;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final Loader _loader = Loader();

  _LoginPageState(this._userCredentials) {
    _emailTextController.text = _userCredentials["email"];
    _passwordTextController.text = _userCredentials["pw"];
    if (_emailTextController.text != "" && _passwordTextController.text != "") {
      _login(_emailTextController.text.trim(), _passwordTextController.text);
    }
  }

  void _login(String email, String pw) async {
    _initUser(_emailTextController.text.trim(), _passwordTextController.text)
        .then((user) =>
            Navigator.pushNamed(context, "/dashboard", arguments: user))
        .catchError((e) => print("Error: AutoLogin Error $e"));
  }

  // Store user email and password to local storage
  void _updateLocalStorage(String email, String pw) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("email", email);
      prefs.setString("password", pw);
    });
  }

  Future<User> _initUser(String email, String password) async {
    User _currentUser = User();
    AuthResult auth;
    DocumentReference ref;
    DocumentSnapshot ds;
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      auth = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      ref = Firestore.instance.collection("users").document(auth.user.uid);
      ds = await ref.get();
      _currentUser.setAuthResult(auth);
      _currentUser.setDatabaseReference(ref);
      _currentUser.setDocumentSnapshot(ds);
      _currentUser.initUserData();
      print("Success: Logged in complete!");
      return Future.value(_currentUser);
    } catch (e) {
      print("Error: Unable to Log in! $e");
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Log In",
          style: kMediumBoldTextStyle,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: kContentPadding,
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Welcome Back!", style: kMediumBoldTextStyle),
                Center(
                  child: SingleChildScrollView(
                    padding: kContentPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(labelText: "Email Address")),
                        SizedBox(height: kSizedBoxHeight),
                        TextFormField(
                            controller: _passwordTextController,
                            obscureText: true,
                            decoration: InputDecoration(labelText: "Password")),
                        SizedBox(height: kSizedBoxHeight),
                        SizedBox(height: kSizedBoxHeight),
                        RaisedButton(
                            child: Text(
                              "LOGIN",
                              style: kButtonTextFontStyle,
                            ),
                            onPressed: () {
                              if (_emailTextController.text.isNotEmpty &&
                                  _passwordTextController.text.isNotEmpty) {
                                try {
                                  _initUser(_emailTextController.text.trim(),
                                          _passwordTextController.text)
                                      .then((user) {
                                    _updateLocalStorage(
                                        this._emailTextController.text.trim(),
                                        this._passwordTextController.text);
                                    Navigator.pushNamed(context, "/dashboard",
                                        arguments: user);
                                  }).catchError((e) {
                                    _loader.dismissDialog(context);
                                    _loader.showAlertDialog("Failed to Log In!",
                                        "Please try again.", context);
                                    print("Error: Log In Failed");
                                  });
                                  // show loading while procecssing login
                                  _loader.showLoadingDialog(context);
                                } catch (e) {
                                  _loader.showAlertDialog("Failed to Log In!",
                                      "Please try again.", context);
                                  print(
                                      "Error: User Initialization Failed! $e");
                                }
                              } else {
                                _loader.showAlertDialog("Whoops...",
                                    "Enter Email and/or Password", context);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
