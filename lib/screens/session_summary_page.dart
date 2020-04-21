import "package:flutter/material.dart";
import "dart:core";
import "package:charts_flutter/flutter.dart" as charts;

// component imports
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/summary_card.dart";
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/custom_card.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/Session.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Crud.dart";

class SessionSummaryPage extends StatefulWidget {
  final Map _args;
  SessionSummaryPage(this._args);

  @override
  _SessionSummaryPageState createState() =>
      _SessionSummaryPageState(this._args);
}

class _SessionSummaryPageState extends State<SessionSummaryPage> {
  User _currentUser;
  Session _session;

  _SessionSummaryPageState(Map args) {
    this._currentUser = args["user"];
    this._session = args["session"];
  }

  Widget _getTimeWidget() {
    String label = "TIME";
    Widget widget;
    Map<String, String> time = this._session.getElapseTime();

    Widget minWidget = SummaryCard(label: "", data: time["min"], sub: "MIN");
    Widget secWidget = SummaryCard(label: "", data: time["sec"], sub: "SEC");

    if (time["hour"] == "0" && time["min"] == "0") {
      widget = SummaryCard(label: label, data: time["sec"], sub: "SEC");
    } else if (time["hour"] == "0") {
      widget = Row(
        children: <Widget>[
          SummaryCard(label: label, data: time["min"], sub: "MIN"),
          SizedBox(width: kSizedBoxHeight),
          secWidget
        ],
      );
    } else {
      widget = Row(
        children: <Widget>[
          SummaryCard(label: label, data: time["hour"], sub: "HR"),
          SizedBox(width: kSizedBoxHeight),
          minWidget,
          SizedBox(width: kSizedBoxHeight),
          secWidget
        ],
      );
    }
    return widget;
  }

  List<charts.Series<CountedSets, String>> _generateChartData() {
    final data = [
      CountedSets(
        category: "PERFORMED",
        data: this._session.getPerformedSets(),
        color: kBlueAccentColor.shade100,
      ),
      CountedSets(
        category: "SKIPPED",
        data: this._session.getSkippedSets(),
        color: kAmberAccentColor,
      ),
    ];
    return [
      charts.Series<CountedSets, String>(
        data: data,
        id: "Result",
        domainFn: (CountedSets count, _) => count.category,
        measureFn: (CountedSets count, _) => count.data,
        colorFn: (CountedSets count, _) =>
            charts.ColorUtil.fromDartColor(count.color),
        labelAccessorFn: (CountedSets row, _) => row.category,
      )
    ];
  }

  // update session obj and database
  void _updateLastSession() {
    _currentUser.setLastSession({
      "name": _session.getWorkout().name,
      "description": "Date: " +
          _session.date +
          "\nTime: " +
          _session.getFormattedElapseTime(),
      "date": _session.date,
      "duration": _session.getElapseTime()
    });
    Crud(this._currentUser).updateDatabase(
      "lastSession",
      _currentUser.getLastSession(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _generateChartData();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Session Summary",
          style: kSmallTextStyle.copyWith(color: Colors.white),
        ),
      ),
      drawer: Menu(_currentUser),
      body: ListView(
        children: <Widget>[
          CustomCard(
            cardChild: SummaryCard(
              label: "WORKOUT",
              data: _session.getWorkout().name,
              subData: _session.getWorkout().description,
              style: kMediumBoldTextStyle,
            ),
          ),
          CustomCard(cardChild: _getTimeWidget()),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: CustomCard(
                      color: kBlueAccentColor.shade100,
                      cardChild: SummaryCard(
                        label: "PERFORMED",
                        data: _session.getPerformedRoutines().length.toString(),
                        sub: "EXERCISES",
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomCard(
                      color: kBlueAccentColor.shade100,
                      cardChild: SummaryCard(
                        label: "PERFORMED",
                        data: _session.getPerformedSets().toString(),
                        sub: "SETS",
                      ),
                    ),
                  ),
                ],
              ),
              // pie chart
              Container(
                height: 220.0,
                child: charts.PieChart(
                  _generateChartData(),
                  defaultRenderer: charts.ArcRendererConfig(
                      //     arcRendererDecorators: [
                      // charts.ArcLabelDecorator(
                      //   insideLabelStyleSpec: charts.TextStyleSpec(
                      //     fontSize: 14,
                      //     color: charts.ColorUtil.fromDartColor(Colors.white),
                      //   ),
                      //   outsideLabelStyleSpec: charts.TextStyleSpec(
                      //     fontSize: 14,
                      //     color: charts.ColorUtil.fromDartColor(Colors.black),
                      //   ),
                      // ),
                      // ]
                      ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomCard(
                      color: kAmberAccentColor,
                      cardChild: SummaryCard(
                          label: "SKIPPED",
                          data: _session.getSkippedRoutines().length.toString(),
                          sub: "EXERCISES"),
                    ),
                  ),
                  Expanded(
                    child: CustomCard(
                      color: kAmberAccentColor,
                      cardChild: SummaryCard(
                          label: "SKIPPED",
                          data: _session.getSkippedSets().toString(),
                          sub: "SETS"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationButton(
          label: "DONE",
          action: () {
            _updateLastSession();
            Navigator.pushNamed(
              context,
              "/dashboard",
              arguments: _currentUser,
            );
          },
          color: kBlueButtonColor),
    );
  }
}

class CountedSets {
  String category;
  int data;
  Color color;
  CountedSets({@required this.data, @required this.category, this.color});
}
