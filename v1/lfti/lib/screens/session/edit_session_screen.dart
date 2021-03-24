import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/session/edit_session_screen_provider.dart';
import 'package:provider/provider.dart';

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
  static final String title = 'edit session';
  @override
  _EditSessionScreenState createState() => _EditSessionScreenState();
}

class _EditSessionScreenState extends State<EditSessionScreen> {
  @override
  void didChangeDependencies() {
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context, listen: false);
    model.initialize(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final EditSessionScreenProvider model =
        Provider.of<EditSessionScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(EditSessionScreen.title), actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed:
                model.editMode ? model.saveChanges : model.enableEditMode,
            icon: model.editMode
                ? Icon(FontAwesomeIcons.save)
                : Icon(FontAwesomeIcons.edit),
          ),
        ),
      ]),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name', style: labelSmallTextStyle),
                Text(model.name ?? '', style: mediumTextStyle),
                SizedBox(height: 8.0),
                Text('Description', style: labelSmallTextStyle),
                Text(model.description ?? '', style: mediumTextStyle),
                SizedBox(height: 8.0),
                Text('Schedule', style: labelSmallTextStyle),
                Text(model.schedule, style: mediumTextStyle),
              ],
            ),
          ),
          ...getActivityTiles(),
        ],
      ),
    );
  }

  List<Widget> getActivityTiles() {
    final model = Provider.of<EditSessionScreenProvider>(context);
    final List<dynamic> activities = model.activities;
    return activities.map((act) {
      final name = act.name;
      final String desc = act.description ?? '';
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          ),
        ),
        child: InkWell(
          onTap: model.editMode
              ? () {
                  print('pressed');
                }
              : null,
          child: ListTile(
            title: Text(name),
            subtitle: Text(desc),
            leading: act is Exercise ? AppIcon.inactiveWorkout : AppIcon.rest,
            trailing: model.editMode
                ? Icon(FontAwesomeIcons.angleRight)
                : SizedBox(width: 1),
          ),
        ),
      );
    }).toList();
  }
}
