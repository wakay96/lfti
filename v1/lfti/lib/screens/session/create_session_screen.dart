import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/session/create_session_screen_provider.dart';
import 'package:lfti/screens/session/session_screen.dart';
import 'package:lfti/screens/workout/edit_workout_screen.dart';
import 'package:lfti/shared/text/day_picker.dart';
import 'package:provider/provider.dart';

class CreateSessionScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateSessionScreenProvider>(
      create: (context) => CreateSessionScreenProvider(),
      child: CreateSessionScreen(),
    );
  }
}

class CreateSessionScreen extends StatefulWidget {
  static final String id = 'CreateSessionScreen';
  static final String title = 'create session';

  @override
  _CreateSessionScreenState createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      final model =
          Provider.of<CreateSessionScreenProvider>(context, listen: false);
      model.initialize(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CreateSessionScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(CreateSessionScreen.title),
      ),
      body: Column(
        children: [
          WeekdayPicker(
            selections: model.selectedDays,
            onSelect: model.toggleDay,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: model.workouts.length,
              itemBuilder: (context, index) {
                final Workout workout = model.workouts[index];
                return AnimatedContainer(
                  decoration: BoxDecoration(
                    color: model.isSelectedWorkout(workout.id)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    border: Border.all(),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: ListTile(
                    key: UniqueKey(),
                    onTap: () {
                      model.isSelectedWorkout(workout.id)
                          ? model.setSelectedWorkout(null)
                          : model.setSelectedWorkout(workout);
                    },
                    leading: Icon(
                      FontAwesomeIcons.checkCircle,
                      color: model.isSelectedWorkout(workout.id)
                          ? dangerColor
                          : Theme.of(context).iconTheme.color,
                    ),
                    title: Text(workout.name),
                    subtitle: Text(workout.description ?? ''),
                    trailing: IconButton(
                      onPressed: () async {
                        var updatedWorkout =
                            await Navigator.of(context).pushNamed(
                          EditWorkoutScreen.id,
                          arguments: {'data': model.workouts[index]},
                        ) as Workout;
                        model.updateEditedWorkout(index, updatedWorkout);
                        // model.setSelectedWorkout(updatedWorkout);
                      },
                      icon: Icon(
                        FontAwesomeIcons.angleRight,
                        color: model.isSelectedWorkout(workout.id)
                            ? dangerColor
                            : Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  duration: Duration(milliseconds: 200),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  FloatingActionButton _getFloatingActionButton() {
    final model = Provider.of<CreateSessionScreenProvider>(context);
    late IconData iconData = FontAwesomeIcons.plus;
    late Function handler;
    late Color color;

    if (model.selectedWorkout == null || !model.selectedDays.contains(true)) {
      handler = (_) => print('select day and/or workout');
      color = Theme.of(context).disabledColor;
    } else {
      handler = (context) => _showConfirmationDialog(context, model);
      color = dangerColor;
    }

    return FloatingActionButton(
      backgroundColor: color,
      onPressed: () => handler(context),
      child: Icon(
        iconData,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Future<void> _showConfirmationDialog(
      BuildContext context, CreateSessionScreenProvider model) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('All set?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Workout Name',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(model.selectedWorkout!.name),
                SizedBox(height: 5.0),
                Text(
                  'Perform on',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(model.getSelectedDaysText(),
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                model.saveChanges();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(SessionScreen.id, (_) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
