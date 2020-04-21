import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/classes/Crud.dart";

class AccountPage extends StatefulWidget {
  final User _currentUser;
  AccountPage(this._currentUser);

  @override
  _AccountPageState createState() => _AccountPageState(this._currentUser);
}

class _AccountPageState extends State<AccountPage> {
  User _currentUser;
  String _email, _gymMembership;
  _AccountPageState(this._currentUser) {
    this._email = this._currentUser.getEmail();
    this._gymMembership = this._currentUser.getGymMembership();
  }

  void _showGymMembershipInputDialog() async {
    final inputTextController = TextEditingController();
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Gym Membership"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          content: TextFormField(
            controller: inputTextController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: _gymMembership,
              suffixIcon: GestureDetector(
                  onTap: () => inputTextController.clear(),
                  child: Icon(Icons.close)),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel", style: kSmallTextStyle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Confirm", style: kSmallTextStyle),
              onPressed: () {
                setState(() {
                  this._gymMembership = inputTextController.text.toString();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateUserData() async {
    // TODO: Add option to change email
    if (_currentUser.getGymMembership().toUpperCase() !=
        this._gymMembership.toUpperCase()) {
      this._currentUser.setGymMembership(this._gymMembership);
      Crud(_currentUser).updateDatabase("gymMembership", this._gymMembership);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: Text("Account"),
      ),
      drawer: Menu(_currentUser),
      body: ListView(
        children: <Widget>[
          ContentCard(
            label: "Name",
            content: this._currentUser.getFirstName() +
                " " +
                this._currentUser.getLastName(),
          ),
          ContentCard(
            label: "Email",
            content: _email.toString(),
          ),
          ContentCard(
            label: "Gym Membership",
            content: this._gymMembership.toString(),
            onTap: () => _showGymMembershipInputDialog(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "SAVE",
          color: kBlueButtonColor,
          action: () {
            _updateUserData();
            Navigator.pushNamed(context, "/dashboard", arguments: _currentUser);
          }),
    );
  }
}

class ContentCard extends StatelessWidget {
  final String label, content;
  final Function onTap;
  ContentCard({@required this.label, @required this.content, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kContentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label.toString()),
          Divider(thickness: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Text(
                  content == "" ? "Not Specified" : content.toString(),
                  style: content == ""
                      ? kSmallTextStyle.copyWith(
                          fontStyle: FontStyle.italic, color: Colors.grey)
                      : kSmallBoldTextStyle,
                ),
              ),
              onTap != null
                  ? Expanded(
                      child: GestureDetector(
                        onTap: onTap,
                        child: Icon(Icons.edit),
                      ),
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
