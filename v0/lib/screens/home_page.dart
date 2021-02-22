import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:shared_preferences/shared_preferences.dart";

class HomePage extends StatelessWidget {
  // Load user email and password to local storage
  void _login(BuildContext context) async {
    String email, pw;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.get("email");
    pw = prefs.get("password");
    Navigator.pushNamed(context, '/login', arguments: {
      "email": email != null ? email : "",
      "pw": pw != null ? pw : ""
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'lfti',
                    style: kLargeBoldTextStyle2x,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: kContentPadding,
                  margin: kContentMargin,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          _login(context);
                        },
                        child: Container(
                          child: Text(
                            'LOG IN',
                            style: kButtonTextFontStyle,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/signup',
                          );
                        },
                        child: Container(
                          child: Text(
                            'SIGN UP',
                            style: kButtonTextFontStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
