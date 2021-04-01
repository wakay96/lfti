import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/workout.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'edit_session_workout_screen.dart';

class CreateSessionScreen extends StatelessWidget {
  static final String id = 'CreateSessionScreen';
  static final String title = 'create session';

  final repo = GetIt.instance<IRepository>();
  @override
  Widget build(BuildContext context) {
    final workouts = repo.getAllWorkouts();
    return Scaffold(
      appBar: AppBar(
        title: Text(CreateSessionScreen.title),
      ),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final Workout workout = workouts[index];
            return AnimatedContainer(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, EditSessionWorkoutScreen.id,
                      arguments: {'data': workout});
                },
                leading: Icon(FontAwesomeIcons.checkCircle),
                title: Text(workout.name),
                subtitle: Text(
                  workout.description ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed(
                      EditSessionWorkoutScreen.id,
                      arguments: {'data': workout},
                    );
                  },
                  icon: Icon(FontAwesomeIcons.angleRight),
                ),
              ),
              duration: Duration(milliseconds: 200),
            );
          }, childCount: workouts.length),
        )
      ]),
    );
  }
}
