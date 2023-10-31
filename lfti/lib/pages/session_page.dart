import 'package:lfti_api/lfti_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../data/services/date_service.dart';

class SessionPage extends StatefulWidget {
  static const String path = 'SessionPage';
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
