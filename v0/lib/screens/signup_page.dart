import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/loader.dart";
import "package:lfti_app/classes/Crud.dart";
import "package:lfti_app/classes/User.dart";

// firebase imports
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();

  Loader _loader = Loader();
  User _user = User();

  void _signUp() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth
        .createUserWithEmailAndPassword(
            email: _emailTextController.text.trim(),
            password: _passwordTextController.text)
        .then((res) {
      this._user.setAuthResult(res);
      this._user.setDatabaseReference(
          Firestore.instance.collection("users").document(res.user.uid));
      this._user.setFirstName(_firstNameTextController.text.trim());
      this._user.setLastName(_lastNameTextController.text.trim());
      this._user.setEmail(_emailTextController.text.trim());
      Crud(this._user).signUp();
      print("Sign Up Successfull. UID : " + this._user.getUID());
      _loader.dismissDialog(context);
    }).catchError((e) => print("Error: Failed to sign up! $e"));
    _loader.showLoadingDialog(context);
  }

  bool _isAllInputNotEmpty() {
    if (_firstNameTextController.text.isNotEmpty &&
        _lastNameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Hello Stranger!", style: kMediumBoldTextStyle),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: kContentPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Sign Up!", style: kMediumBoldTextStyle),
                  ),
                  TextFormField(
                      controller: _firstNameTextController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "First Name")),
                  SizedBox(height: kSizedBoxHeight),
                  TextFormField(
                      controller: _lastNameTextController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Last Name")),
                  SizedBox(height: kSizedBoxHeight),
                  TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  SizedBox(height: kSizedBoxHeight),
                  TextFormField(
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                  SizedBox(height: kSizedBoxHeight),
                  SizedBox(height: kSizedBoxHeight),
                  RaisedButton(
                      child: Text(
                        "SIGN UP",
                        style: kButtonTextFontStyle,
                      ),
                      onPressed: () async {
                        if (_isAllInputNotEmpty()) {
                          _signUp();
                          Navigator.pushNamed(context, "/login", arguments: {
                            "email": _emailTextController.text.trim(),
                            "pw": _passwordTextController.text
                          });
                        } else {
                          _loader.showAlertDialog(
                              "Incomplete", "Please complete form!", context);
                          print("Alert: Empty Fields");
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
