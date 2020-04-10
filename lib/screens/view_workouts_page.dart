import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import "package:lfti_app/classes/Workout.dart";
import "package:lfti_app/classes/Routine.dart";

// component imports
import "package:lfti_app/components/workout_card.dart";
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/empty_state_notification.dart";

class ViewWorkoutsPage extends StatefulWidget {
  final User _currentUser;
  ViewWorkoutsPage(this._currentUser);

  @override
  _ViewWorkoutsPageState createState() => _ViewWorkoutsPageState(_currentUser);
}

class _ViewWorkoutsPageState extends State<ViewWorkoutsPage> {
  User _currentUser;
  List<Workout> _workoutList;

  _ViewWorkoutsPageState(this._currentUser) {
    if (_currentUser.getWorkoutList() == null) {
      this._currentUser.setWorkoutList(List<Workout>());
    }
    this._workoutList = _currentUser.getWorkoutList();
  }

  @override
  Widget build(BuildContext context) {
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
          "WORKOUTS",
        ),
      ),
      drawer: Menu(_currentUser),
      body: _workoutList.length > 0
          ? CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Widget item;
                    if (index < _currentUser.getWorkoutList().length) {
                      item = WorkoutCard(
                          user: _currentUser,
                          index: index,
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/viewRoutines', arguments: {
                              "user": this._currentUser,
                              "workout": this._currentUser.getWorkoutAt(index)
                            });
                          });
                    }
                    return item;
                  }),
                ),
              ],
            )
          : EmptyStateNotification(sub: "Create workout routines first."),
    );
  }
}
