import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/classes/Loader.dart';
import "package:lfti_app/classes/User.dart";

class LoginPage extends StatefulWidget {
  final Map<String, String> _emailAndPassword;
  LoginPage(this._emailAndPassword);
  @override
  _LoginPageState createState() => _LoginPageState(_emailAndPassword);
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> _userCredentials;
  _LoginPageState(this._userCredentials);

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _currentUser = User();
  final _loader = Loader();

  void _init() {
    _emailTextController.text = _userCredentials["email"];
    _passwordTextController.text = _userCredentials["pw"];
  }

  @override
  Widget build(BuildContext context) {
    _init();
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
                Text('Welcome Back!', style: kMediumBoldTextStyle),
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
                            onPressed: () async {
                              try {
                                await _currentUser.login(
                                    _emailTextController.text.trim(),
                                    _passwordTextController.text);
                                await _currentUser.setDatabaseReference();
                                await _currentUser.setDocumentSnapshot();
                                await _currentUser.initUserData();
                                if (_currentUser.isLoggedIn()) {
                                  Navigator.pushNamed(context, "/dashboard",
                                      arguments: _currentUser);
                                } else {
                                  _loader.showAlertDialog("Failed to Log In!",
                                      "Invalid Email / Password", context);
                                }
                              } catch (e) {
                                print("Error: Failed to Log in! $e");
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
