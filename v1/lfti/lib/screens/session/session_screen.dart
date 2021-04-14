import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/screens/session/session_workout_screen.dart';
import 'package:provider/provider.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/session/session_screen_provider.dart';
import 'package:lfti/screens/session/edit_session_screen.dart';

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
  static final String title = 'Sessions';
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      final SessionScreenProvider model =
          Provider.of<SessionScreenProvider>(context, listen: false);
      model.initialize(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SessionScreenProvider>(context);
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(title: Text(SessionScreen.title)),
        SliverList(delegate: _buildSessionTiles(model)),
        SliverPadding(padding: EdgeInsets.only(bottom: 100))
      ]),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  Widget _getFloatingActionButton() {
    final SessionScreenProvider model =
        Provider.of<SessionScreenProvider>(context);
    Widget icon;
    Function handler;
    Color color;
    String label;

    if (model.selectedSession == null) {
      label = 'Create';
      handler = (context) =>
          Navigator.pushNamed(context, SelectSessionWorkoutScreen.id);
      icon = AppIcon.add;
      color = primaryColor;
    } else {
      label = 'Do This!';
      if (model.selectedSession == null) {
        handler = (_) => print('Select workout first');
        color = Theme.of(context).disabledColor;
      } else {
        handler = (context) => model.startSession(context);
        color = primaryColor;
      }
      icon = AppIcon.play;
    }

    return FloatingActionButton.extended(
      label: Text(label),
      icon: icon,
      onPressed: () => handler(context),
      backgroundColor: color,
    );
  }

  SliverChildBuilderDelegate _buildSessionTiles(SessionScreenProvider model) {
    return SliverChildBuilderDelegate(
      (context, index) {
        return _getSessionTile(model, index);
      },
      childCount: model.sessions.length,
    );
  }

  Widget _getSessionTile(SessionScreenProvider model, int index) {
    final session = model.sessions[index];
    final bool isSelected = model.isSelectedSession(session.id);

    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(),
      ),
      child: ListTile(
        title: Text(session.name),
        subtitle: Text(ListToString(session.schedule).parse()),
        leading: Icon(
          FontAwesomeIcons.dumbbell,
          color:
              isSelected ? workoutThemeColor : Theme.of(context).primaryColor,
        ),
        onTap: () {
          isSelected
              ? model.resetSelectedSession()
              : model.toggleSelectedSession(session.id!);
        },
        trailing: IconButton(
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              EditSessionScreen.id,
              arguments: {'id': session.id},
            );
            model.initialize(context);
          },
          icon: Icon(FontAwesomeIcons.angleRight),
        ),
      ),
      duration: Duration(milliseconds: 200),
    );
  }
}
