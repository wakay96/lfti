import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/activity.dart';
import 'package:lfti/providers/session/edit_session_screen_provider.dart';
import 'package:lfti/screens/session/session_screen.dart';
import 'package:lfti/shared/activity_tile.dart';
import 'package:lfti/shared/add_activity_button.dart';
import 'package:lfti/shared/picker/weekday_picker.dart';
import 'package:provider/provider.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';

class EditSessionScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditSessionScreenProvider>(
      create: (context) => EditSessionScreenProvider(),
      child: EditSessionScreen(),
    );
  }
}

class EditSessionScreen extends StatefulWidget {
  static final String id = 'EditSessionScreen';
  static final String title = 'Edit Session';
  @override
  _EditSessionScreenState createState() => _EditSessionScreenState();
}

class _EditSessionScreenState extends State<EditSessionScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final EditSessionScreenProvider model =
          Provider.of<EditSessionScreenProvider>(context, listen: false);
      model.initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(EditSessionScreen.title),
          leading: _getBackButtonActionWidget(),
          actions: _getAppBarAction()),
      body: CustomScrollView(slivers: [
        _getDayPicker(),
        _getHeaderWidget(),
        _getActivityWidgets(),
        SliverPadding(padding: EdgeInsets.only(bottom: 50))
      ]),
    );
  }

  Widget _getBackButtonActionWidget() {
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context);
    return IconButton(
        icon: AppIcon.backArrow,
        onPressed: () {
          model.editMode
              ? _showConfirmationDialog(
                  title: 'Discard changes?',
                  content: Text('Unsaved changes will be discarded.'),
                  onConfirm: () {
                    // Pop Dialog Box
                    Navigator.pop(context);
                    // Pop Current Screen
                    Navigator.pop(context);
                  })
              : Navigator.pop(context);
        });
  }

  List<Widget> _getAppBarAction() {
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context);
    return <Widget>[
      model.editMode
          ? IconButton(
              icon: AppIcon.save,
              onPressed: () {
                model.save();
                model.resetSelectedActivity();
                model.toggleEditMode();
              })
          : PopupMenuButton<String>(onSelected: (value) {
              if (value == 'Edit') {
                model.toggleEditMode();
                return;
              }

              if (value == 'Delete') {
                model.deleteSession();
                _showConfirmationDialog(
                  title: 'Confirm Delete',
                  content:
                      Text('Are you sure you want to delete this Session?'),
                  onConfirm: () => Navigator.pushNamedAndRemoveUntil(
                      context, SessionScreen.id, (_) => false),
                );
                return;
              }
            }, itemBuilder: (BuildContext context) {
              return ['Edit', 'Delete'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            }),
    ];
  }

  Widget _getDayPicker() {
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context);
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
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: model.editMode
              ? Theme.of(context).cardColor
              : Theme.of(context).canvasColor,
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
                      decoration: model.editMode
                          ? InputDecoration(labelText: 'Name')
                          : InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Name',
                            ),
                      controller: model.nameController,
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      onChanged: model.updateDescription,
                      minLines: 1,
                      maxLines: 2,
                      enabled: model.editMode,
                      decoration: model.editMode
                          ? InputDecoration(labelText: 'Description')
                          : InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Description',
                            ),
                      controller: model.descriptionController,
                    ),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _getActivityWidgets() {
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context);
    return SliverReorderableList(
      itemBuilder: (context, index) {
        final Activity act = model.activities[index];
        final bool isSelected = model.isActivitySelected(act.id);
        final bool editMode = model.editMode;
        return Material(
          key: ValueKey(act.id),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(
                visible: isSelected,
                child: AddActivityButton(
                  isSelected,
                  index - 1,
                  model.addActivity,
                ),
              ),
              ActivityTile(
                index: index,
                act: act,
                leading:
                    act is Exercise ? AppIcon.inactiveWorkout : AppIcon.rest,
                trailing: _getActivityTileTrailing(index),
                active: editMode,
                isSelected: isSelected,
                onDismiss:
                    isSelected ? null : (item) => model.deleteActivity(item),
                onTap: editMode
                    ? () {
                        isSelected
                            ? model.resetSelectedActivity()
                            : model.setSelectedActivity(act.id);
                      }
                    : null,
              ),
              Visibility(
                visible: isSelected,
                child: AddActivityButton(
                  isSelected,
                  index + 1,
                  model.addActivity,
                ),
              ),
            ],
          ),
        );
      },
      itemCount: model.activities.length,
      onReorder: model.onReorderActivities,
    );
  }

  Widget? _getActivityTileTrailing(int index) {
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context);
    if (model.editMode) {
      final act = model.activities[index];
      bool isSelected = model.isActivitySelected(act.id);
      if (isSelected) {
        if (act is Exercise) {
          final TextEditingController setController =
              TextEditingController(text: act.setCount.toString());
          final TextEditingController repController =
              TextEditingController(text: act.repCount.toString());
          final _formKey = GlobalKey<FormState>();
          return InkWell(
              child: AppIcon.edit,
              onTap: () {
                _showConfirmationDialog(
                  title: 'Edit',
                  content: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Sets'),
                            controller: setController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Reps'),
                            controller: repController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonText: 'Save',
                  onConfirm: () {
                    Map<String, String> data = {
                      'setCount': setController.text,
                      'repCount': repController.text
                    };
                    model.updateExercise(index, data);
                    Navigator.pop(context);
                  },
                );
              });
        }
      }
      return ReorderableDragStartListener(
        index: index,
        child: Icon(FontAwesomeIcons.gripLines),
      );
    }

    return null;
  }

  void _showConfirmationDialog({
    required String title,
    required Function onConfirm,
    String buttonText = 'Confirm',
    Widget? content,
  }) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: content == null
                ? Text('')
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [content],
                  ),
            actions: [
              ElevatedButton(
                onPressed: () => onConfirm(),
                child: Text(buttonText),
              ),
            ],
          );
        });
  }
}
