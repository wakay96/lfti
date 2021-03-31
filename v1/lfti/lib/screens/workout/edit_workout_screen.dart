import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/session/edit_session_workout_screen_provider.dart';
import 'package:provider/provider.dart';

class EditWorkoutScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditWorkoutScreenProvider(),
      child: EditWorkoutScreen(),
    );
  }
}

class EditWorkoutScreen extends StatefulWidget {
  static String id = 'EditWorkoutScreen';
  static String title = 'edit workout';
  @override
  _EditWorkoutScreenState createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final model =
          Provider.of<EditWorkoutScreenProvider>(context, listen: false);
      model.initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EditWorkoutScreenProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (model.editMode) {
          //  TODO: Show dialog
          print('Show Dialog');
        } else {
          Navigator.pop(context);
        }

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(EditWorkoutScreen.title), actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: model.editMode
                ? IconButton(
                    onPressed: () {
                      model.save();
                      model.toggleEditMode();
                    },
                    icon: Icon(FontAwesomeIcons.save),
                  )
                : IconButton(
                    onPressed: model.toggleEditMode,
                    icon: Icon(FontAwesomeIcons.edit),
                  ),
          ),
        ]),
        body: CustomScrollView(
          slivers: [
            _getHeaderWidget(model),
            _getActivityWidgets(context, model),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: dangerColor,
          onPressed: () {
            print('add exercise');
          },
          child: Icon(
            FontAwesomeIcons.plus,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  List<Widget> _getAppBarAction(EditWorkoutScreenProvider model) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: model.editMode
            ? IconButton(
                icon: Icon(FontAwesomeIcons.save),
                onPressed: () {
                  model.save();
                  model.toggleEditMode();
                },
              )
            : IconButton(
                onPressed: model.toggleEditMode,
                icon: Icon(FontAwesomeIcons.edit),
              ),
      )
    ];
  }

  Widget _getHeaderWidget(EditWorkoutScreenProvider model) {
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

  Widget _getActivityWidgets(
      BuildContext context, EditWorkoutScreenProvider model) {
    return model.editMode
        ? SliverReorderableList(
            itemBuilder: (context, index) {
              var act = model.activities[index];
              return Container(
                key: ValueKey(act.id),
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
