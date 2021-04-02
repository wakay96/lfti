import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/workout.dart';

class WorkoutList extends StatelessWidget {
  WorkoutList({required this.workouts, this.onTap});

  final List<Workout> workouts;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final Workout workout = workouts[index];
          return AnimatedContainer(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(),
            ),
            child: ListTile(
              title: Text(workout.name),
              subtitle: Text(
                workout.description ?? '',
                overflow: TextOverflow.ellipsis,
              ),
              onTap: onTap != null
                  ? () {
                      onTap!(workout);
                    }
                  : () {},
              trailing: Icon(FontAwesomeIcons.angleRight),
            ),
            duration: Duration(milliseconds: 200),
          );
        }, childCount: workouts.length),
      )
    ]);
  }
}
