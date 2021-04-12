import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/session/create_session_screen_provider.dart.dart';
import 'package:lfti/screens/session/session_screen.dart';
import 'package:lfti/shared/picker/weekday_picker.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';

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
  static final String title = 'Create Session';
  @override
  _CreateSessionScreenState createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final CreateSessionScreenProvider model =
          Provider.of<CreateSessionScreenProvider>(context, listen: false);
      model.initialize(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(CreateSessionScreen.title),
          leading: _getBackButtonActionWidget(),
          actions: _getAppBarAction()),
      body: CustomScrollView(slivers: [
        _getDayPicker(),
        _getHeaderWidget(),
        _getActivityWidgets(),
        _getPadding()
      ]),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  Widget _getPadding() {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 50),
    );
  }

  Widget _getFloatingActionButton() {
    final CreateSessionScreenProvider model =
        Provider.of<CreateSessionScreenProvider>(context);
    return FloatingActionButton.extended(
        backgroundColor: model.scheduleSelection.contains(true)
            ? primaryColor
            : Theme.of(context).disabledColor,
        label: Text('Done'),
        icon: AppIcon.done,
        onPressed: () {
          if (model.scheduleSelection.contains(true)) {
            model.save();
            Navigator.pushNamedAndRemoveUntil(
              context,
              SessionScreen.id,
              (route) => false,
            );
          }
        });
  }

  Widget _getBackButtonActionWidget() {
    final CreateSessionScreenProvider model =
        Provider.of<CreateSessionScreenProvider>(context);
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

  void _showConfirmationDialog(
      {required String title,
      required Function onConfirm,
      String buttonText = 'Confirm',
      String content = ''}) {
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

  List<Widget> _getAppBarAction() {
    final CreateSessionScreenProvider model =
        Provider.of<CreateSessionScreenProvider>(context);
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: model.editMode
            ? IconButton(
                icon: Icon(
                  FontAwesomeIcons.save,
                  color: primaryColor,
                ),
                onPressed: () {
                  model.save();
                  model.toggleEditMode();
                },
              )
            : IconButton(
                icon: Icon(FontAwesomeIcons.edit),
                onPressed: model.toggleEditMode,
              ),
      )
    ];
  }

  Widget _getDayPicker() {
    final CreateSessionScreenProvider model =
        Provider.of<CreateSessionScreenProvider>(context);
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          WeekdayPicker(
            isEditable: model.editMode,
            onSelect: model.editMode ? model.toggleDay : (_) {},
            selections: model.scheduleSelection,
          )
        ],
      ),
    );
  }

  Widget _getHeaderWidget() {
    final CreateSessionScreenProvider model =
        Provider.of<CreateSessionScreenProvider>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          color: model.editMode
              ? Theme.of(context).cardColor
              : Theme.of(context).canvasColor,
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
    final CreateSessionScreenProvider model =
        Provider.of<CreateSessionScreenProvider>(context);
    return model.editMode
        ? SliverReorderableList(
            itemBuilder: (context, index) {
              var act = model.activities[index];
              return Dismissible(
                key: ValueKey(act.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => model.deleteActivity(act),
                child: Material(
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
                      tileColor: model.editMode
                          ? Theme.of(context).cardColor
                          : Theme.of(context).canvasColor,
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
            onReorder: model.onReorderActivities,
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
