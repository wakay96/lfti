import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";

class Menu extends StatelessWidget {
  final User _currentUser;
  Menu(this._currentUser);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              _currentUser.getFirstName() + " " + _currentUser.getLastName(),
              style: kMediumTextStyle,
            ),
            accountEmail: Text(
              _currentUser.getEmail(),
              style: kLabelTextStyle,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                _currentUser.getFirstName()[0] + _currentUser.getLastName()[0],
                style:
                    kLargeBoldTextStyle1x.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Dashboard",
              style: kSmallTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, "/dashboard",
                  arguments: _currentUser);
            },
          ),
          ListTile(
            title: Text(
              "Checklist",
              style: kSmallTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, "/updateChecklist",
                  arguments: _currentUser);
            },
          ),
          ListTile(
            title: Text(
              "Workouts",
              style: kSmallTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, "/workouts",
                  arguments: _currentUser);
            },
          ),
          ListTile(
            title: Text(
              "Log out",
              style: kSmallTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }
}
