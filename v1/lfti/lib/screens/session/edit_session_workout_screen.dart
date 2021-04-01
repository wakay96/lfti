import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/session/edit_session_workout_screen_provider.dart';
import 'package:lfti/screens/session/session_screen.dart';
import 'package:lfti/shared/picker/weekday_picker.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';

class EditSessionScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditSessionWorkoutScreenProvider>(
      create: (context) => EditSessionWorkoutScreenProvider(),
      child: EditSessionWorkoutScreen(),
    );
  }
}

class EditSessionWorkoutScreen extends StatefulWidget {
  static final String id = 'EditSessionScreen';
  static final String title = 'edit session';
  @override
  _EditSessionWorkoutScreenState createState() =>
      _EditSessionWorkoutScreenState();
}

class _EditSessionWorkoutScreenState extends State<EditSessionWorkoutScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final EditSessionWorkoutScreenProvider model =
          Provider.of<EditSessionWorkoutScreenProvider>(context, listen: false);
      model.initialize(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(EditSessionWorkoutScreen.title),
          leading: _getBackButtonActionWidget(),
          actions: _getAppBarAction(context)),
      body: CustomScrollView(slivers: [
        _getDayPicker(),
        _getHeaderWidget(),
        _getActivityWidgets(),
      ]),
    );
  }

  Widget _getBackButtonActionWidget() {
    final EditSessionWorkoutScreenProvider model =
        Provider.of<EditSessionWorkoutScreenProvider>(context);
    return IconButton(
        icon: AppIcon.backArrow,
        onPressed: () {
          model.editMode
              ? _showConfirmationDialog(
                  title: 'Discard changes?',
                  content: 'Unsaved changes will be discarded.',
                  onConfirm: () {
                    // Pop Dialog Box
                    Navigator.pop(context);
                    // Pop Current Screen
                    Navigator.pop(context);
                  })
              : Navigator.pop(context);
        });
  }

  void _showConfirmationDialog({
    required String title,
    required Function onConfirm,
    String buttonText = 'Confirm',
    String content = '',
  }) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              ElevatedButton(
                onPressed: () => onConfirm(),
                child: Text(buttonText),
              ),
            ],
          );
        });
  }

  Widget _getDayPicker() {
    final EditSessionWorkoutScreenProvider model =
        Provider.of<EditSessionWorkoutScreenProvider>(context);
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          WeekdayPicker(
            onSelect: model.editMode ? model.toggleDay : (_) {},
            selections: model.scheduleSelection,
          )
        ],
      ),
    );
  }

  List<Widget> _getAppBarAction(BuildContext context) {
    final EditSessionWorkoutScreenProvider model =
        Provider.of<EditSessionWorkoutScreenProvider>(context);
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: model.editMode
            ? IconButton(
                icon: Icon(FontAwesomeIcons.save),
                onPressed: () {
                  _showConfirmationDialog(
                      title: 'Save Changes?',
                      onConfirm: () {
                        model.save();
                        Navigator.pushNamedAndRemoveUntil(
                            context, SessionScreen.id, (_) => false);
                      });
                },
              )
            : IconButton(
                onPressed: model.toggleEditMode,
                icon: Icon(FontAwesomeIcons.edit),
              ),
      )
    ];
  }

  Widget _getHeaderWidget() {
    final EditSessionWorkoutScreenProvider model =
        Provider.of<EditSessionWorkoutScreenProvider>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          elevation: 8.0,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onChanged: model.updateName,
                    minLines: 1,
                    maxLines: 2,
                    enabled: model.editMode,
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: model.nameController,
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    onChanged: model.updateDescription,
                    minLines: 1,
                    maxLines: 2,
                    enabled: model.editMode,
                    decoration: InputDecoration(labelText: 'Description'),
                    controller: model.descriptionController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _getActivityWidgets() {
    final EditSessionWorkoutScreenProvider model =
        Provider.of<EditSessionWorkoutScreenProvider>(context);
    return model.editMode
        ? SliverReorderableList(
            itemBuilder: (context, index) {
              var act = model.activities[index];
              return Dismissible(
                key: ValueKey(act.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => model.deleteActivity(act),
                child: Material(
                  elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    child: ListTile(
                      title: Text(act.name),
                      leading: act is Exercise
                          ? AppIcon.inactiveWorkout
                          : AppIcon.rest,
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: Icon(FontAwesomeIcons.bars),
                      ),
                    ),
                  ),
                ),
                background: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: dangerColor,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(10.0),
                    child: AppIcon.trash),
              );
            },
            itemCount: model.activities.length,
            onReorder: model.onReorder,
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var act = model.activities[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  child: ListTile(
                    title: Text(act.name),
                    leading: act is Exercise
                        ? AppIcon.inactiveWorkout
                        : AppIcon.rest,
                    // trailing:
                    //     model.editMode ? Icon(FontAwesomeIcons.bars) : SizedBox(),
                  ),
                );
              },
              childCount: model.activities.length,
            ),
          );
  }
}
