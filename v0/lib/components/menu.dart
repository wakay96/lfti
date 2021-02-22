import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

class Menu extends StatelessWidget {
  final User _currentUser;
  Menu(this._currentUser);

  @override
  Widget build(BuildContext context) {
    void _navigateTo(String route) {
      Navigator.pushNamed(context, route, arguments: _currentUser);
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
                _currentUser.getFirstName() + " " + _currentUser.getLastName(),
                style: kMediumTextStyle),
            accountEmail: Text(_currentUser.getEmail(),
                style: kLabelTextStyle.copyWith(
                    color: Colors.white, fontStyle: FontStyle.italic)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                  _currentUser.getFirstName()[0] +
                      _currentUser.getLastName()[0],
                  style: kLargeBoldTextStyle1x),
            ),
          ),
          ListTile(
              trailing: Icon(Icons.dashboard),
              title: Text("Dashboard", style: kSmallTextStyle),
              onTap: () => _navigateTo("/dashboard")),
          ListTile(
              trailing: Icon(Icons.check),
              title: Text("Checklist", style: kSmallTextStyle),
              onTap: () => _navigateTo("/updateChecklist")),
          ListTile(
              trailing: Icon(Icons.fitness_center),
              title: Text("Workouts", style: kSmallTextStyle),
              onTap: () => _navigateTo("/workouts")),
          ListTile(
              trailing: Icon(Icons.account_circle),
              title: Text("Account", style: kSmallTextStyle),
              onTap: () => _navigateTo("/account")),
          ListTile(
              trailing: Icon(Icons.exit_to_app),
              title: Text("Log out", style: kSmallTextStyle),
              onTap: () {
                SharedPreferences.getInstance().then((val) {
                  val.clear();
                  _navigateTo("/");
                });
              }),
        ],
      ),
    );
  }
}
