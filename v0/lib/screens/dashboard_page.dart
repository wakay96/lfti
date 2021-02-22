import "package:flutter/material.dart";
import "dart:convert";
import "package:http/http.dart" as http;
import 'package:flutter/services.dart';

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Keys.dart";

// component imports
import "package:lfti_app/components/checklist.dart";
import "package:lfti_app/components/dashboard_card.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/menu.dart";

class DashboardPage extends StatefulWidget {
  final User _currentUser;
  DashboardPage(this._currentUser);

  @override
  _DashboardPageState createState() => _DashboardPageState(_currentUser);
}

class _DashboardPageState extends State<DashboardPage> {
  User _currentUser;
  List<Map<String, dynamic>> _nearbyLocations;
  bool _isDataReady = false;

  _DashboardPageState(this._currentUser) {
    init();
  }

  Future<List<Map<String, dynamic>>> _fetchLocations() async {
    var client = http.Client();
    final String placesKey = Keys.placesAPI;
    final double radius = 24140.2; // (meters) 15 miles
    final String searchKey = _currentUser.getGymMembership() != ""
        ? _currentUser.getGymMembership().toString().replaceAll(" ", "+")
        : "gym+wightlifting+la+fitness+24+hr+crunch+planet+fitness";

    final loc = List<Map<String, dynamic>>();
    final url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchKey&radius=$radius&key=$placesKey";
    try {
      http.Response uriResponse = await client.get(url);
      if (uriResponse.statusCode == 200) {
        var res = json.decode(uriResponse.body);
        for (var item in res["results"]) {
          loc.add({
            "address": item["formatted_address"],
            "place_id": item["place_id"],
            "name": item["name"],
            "location": item["geometry"]["location"]
          });
        }
      } else {
        throw Exception("Error: Failed to load fetch locations");
      }
    } finally {
      client.close();
    }
    return loc.toList();
  }

  void init() async {
    _fetchLocations().then((val) {
      setState(() {
        this._isDataReady = true;
        this._nearbyLocations = val;
      });
    });
  }

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
        title: Text(
          _currentUser.getFirstName(),
        ),
      ),
      drawer: Menu(_currentUser),
      body: ListView(
        children: <Widget>[
          DashboardCard(
            heading: "LAST SESSION",
            mainInfo: _currentUser.getLastSession() != null
                ? _currentUser.getLastSession()["name"]
                : "Nothing here!",
            details: _currentUser.getLastSession() != null
                ? _currentUser.getLastSession()["description"]
                : "You have not done anyting yet.",
          ),
          _isDataReady
              ? Builder(
                  builder: (context) => GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: _nearbyLocations[0]["address"].toString(),
                        ),
                      );
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          "Copied to Clipboard",
                          style: kSmallTextStyle.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ));
                    },
                    child: _nearbyLocations.isNotEmpty
                        ? DashboardCard(
                            heading: "NEARBY FITNESS CENTER",
                            mainInfo: _nearbyLocations[0]["name"].toString(),
                            details: _nearbyLocations[0]["address"].toString(),
                          )
                        : DashboardCard(
                            heading: "NEARBY FITNESS CENTER",
                            mainInfo:
                                "No nearby fitness centers within 15 miles",
                          ),
                  ),
                )
              : CustomCard(
                  cardChild: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Looking for Nearby Gyms",
                          style: kLabelTextStyle,
                        ),
                        SizedBox(height: kSizedBoxHeight),
                        CircularProgressIndicator()
                      ],
                    ),
                  ),
                ),
          // checklist section
          CustomCard(
            // short circuit
            cardChild: _currentUser.getChecklist() != null &&
                    _currentUser.getChecklist().isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("CHECKLIST", style: kLabelTextStyle),
                      Divider(thickness: 3),
                      Checklist(_currentUser.getChecklist())
                    ],
                  )
                : DashboardCard(
                    heading: "CHECKLIST",
                    mainInfo: "Nothing here.",
                    details: "Add items to your checklist!",
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "LET'S GO!",
          color: kBlueButtonColor,
          action: () {
            Navigator.pushNamed(context, "/viewWorkouts",
                arguments: _currentUser);
          }),
    );
  }
}
