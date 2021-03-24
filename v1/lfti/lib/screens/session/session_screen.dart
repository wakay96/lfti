import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/session/session_screen_provider.dart';
import 'package:lfti/screens/session/edit_session_screen.dart';
import 'package:provider/provider.dart';

class SessionScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionScreenProvider>(
      create: (context) => SessionScreenProvider(),
      child: SessionScreen(),
    );
  }
}

class SessionScreen extends StatefulWidget {
  static final String id = 'SessionScreen';
  static final String title = 'sessions';
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void didChangeDependencies() {
    final SessionScreenProvider model =
        Provider.of<SessionScreenProvider>(context, listen: false);
    model.initialize(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SessionScreenProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: getFloatingActionButton(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(SessionScreen.title), actions: [
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
          SliverList(delegate: buildSessionTiles(model)),
        ],
      ),
    );
  }

  FloatingActionButton getFloatingActionButton() {
    final model = Provider.of<SessionScreenProvider>(context);
    late IconData iconData;
    late Function handler;
    late Color color;

    if (model.editMode) {
      handler = (context) => model.createSession(context);
      iconData = FontAwesomeIcons.plus;
      color = dangerColor;
    } else {
      iconData = FontAwesomeIcons.play;
      if (model.selectedSession == null) {
        handler = (_) => print('Select workout first');
        color = Theme.of(context).disabledColor;
      } else {
        handler = (context) => model.startSession(context);
        color = dangerColor;
      }
    }
    return FloatingActionButton(
      backgroundColor: color,
      onPressed: () => handler(context),
      child: Icon(
        iconData,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  SliverChildBuilderDelegate buildSessionTiles(SessionScreenProvider model) {
    return SliverChildBuilderDelegate(
      (context, index) {
        final session = model.sessions[index];
        return Container(
          decoration: BoxDecoration(
            color: model.isSelectedSession(session.id)
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
            border: Border(
              bottom: BorderSide(),
            ),
          ),
          child: ListTile(
            onTap: model.editMode
                ? () {
                    Navigator.pushNamed(
                      context,
                      EditSessionScreen.id,
                      arguments: {'id': session.id},
                    );
                  }
                : () {
                    model.isSelectedSession(session.id)
                        ? model.toggleSelectedSession(null)
                        : model.toggleSelectedSession(session.id);
                  },
            leading: Icon(
              FontAwesomeIcons.dumbbell,
              color: model.selectedSession != null &&
                      model.selectedSession!.id == session.id
                  ? workoutThemeColor
                  : Theme.of(context).primaryColor,
            ),
            title: Text(session.workout.name),
            subtitle: Text(ListToString(session.schedule).parse()),
            trailing:
                model.editMode ? Icon(FontAwesomeIcons.angleRight) : SizedBox(),
          ),
        );
      },
      childCount: model.sessions.length,
    );
  }
}
