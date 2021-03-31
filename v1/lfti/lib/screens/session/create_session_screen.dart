import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/id_generator.dart';
import 'package:lfti/providers/session/create_session_screen_provider.dart';
import 'package:lfti/screens/session/session_screen.dart';
import 'package:lfti/screens/workout/edit_workout_screen.dart';
import 'package:lfti/shared/picker/weekday_picker.dart';
import 'package:provider/provider.dart';

import 'edit_session_workout_screen.dart';

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
      body: CustomScrollView(slivers: [
        _getWorkoutWidgets(model),
      ]),
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    CreateSessionScreenProvider model,
  ) {
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
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Confirm'),
              onPressed: () {
                model.save();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  SessionScreen.id,
                  (_) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getWorkoutWidgets(CreateSessionScreenProvider model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final Workout workout = model.workouts[index];
        return AnimatedContainer(
          decoration: BoxDecoration(
            color: model.isSelectedWorkout(workout.id)
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
            border: Border.all(),
          ),
          child: ListTile(
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
            subtitle: Text(
              workout.description ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(
                  EditSessionScreen.id,
                  arguments: {'data': workout},
                );
                model.refresh();
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
      }, childCount: model.workouts.length),
    );
  }
}
