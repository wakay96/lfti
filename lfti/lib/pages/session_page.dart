import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/models/exercise.dart';
import 'package:lfti/models/routine.dart';
import 'package:lfti/services/date_service.dart';

class SessionPage extends StatefulWidget {
  static final String path = AppSubPage.sessionPage.path;
  const SessionPage({super.key, required this.routine});
  final Routine routine;

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  String header = '';
  String routineName = '';
  List<Exercise> exercises = [];

  @override
  void initState() {
    final DateTime date = DateTime.now();
    header = '${Months.values[date.month].abbr} ${date.day}';
    routineName = widget.routine.name;
    exercises = [...widget.routine.exercises];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(header),
      ),
      body: ListView.builder(
        itemCount: widget.routine.exercises.length,
        itemBuilder: (context, index) {
          final Exercise exercise = exercises[index];
          return Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) {
                    setState(() {
                      exercises.remove(exercise);
                    });
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            child: ListTile(
              title: Text(widget.routine.exercises[index].name),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
