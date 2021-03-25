import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/helpers/string_formatter.dart';
import 'package:lfti/providers/session/session_screen_provider.dart';
import 'package:lfti/screens/session/create_session_screen.dart';
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
      floatingActionButton: _getFloatingActionButton(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(SessionScreen.title),
          ),
          SliverList(
            delegate: _buildSessionTiles(model),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _getFloatingActionButton() {
    final model = Provider.of<SessionScreenProvider>(context);
    IconData iconData;
    Function handler;
    Color color;

    if (model.selectedSession == null) {
      handler = (context) {
        Navigator.pushNamed(
          context,
          CreateSessionScreen.id,
        );
      };
      iconData = FontAwesomeIcons.plus;
      color = dangerColor;
    } else {
      if (model.selectedSession == null) {
        handler = (_) => print('Select workout first');
        color = Theme.of(context).disabledColor;
      } else {
        handler = (context) => model.startSession(context);
        color = dangerColor;
      }
      iconData = FontAwesomeIcons.play;
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

  SliverChildBuilderDelegate _buildSessionTiles(SessionScreenProvider model) {
    return SliverChildBuilderDelegate(
      (context, index) => _getSessionTile(model, index),
      childCount: model.sessions.length,
    );
  }

  Widget _getSessionTile(SessionScreenProvider model, int index) {
    final session = model.sessions[index];
    final bool isSelected = model.isSelectedSession(session.id);

    return AnimatedContainer(
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        border: Border.all(),
      ),
      child: ListTile(
        title: Text(session.workout.name),
        subtitle: Text(ListToString(session.schedule).parse()),
        leading: Icon(
          FontAwesomeIcons.dumbbell,
          color:
              isSelected ? workoutThemeColor : Theme.of(context).primaryColor,
        ),
        onTap: () {
          isSelected
              ? model.resetSelectedSession()
              : model.toggleSelectedSession(session.id);
          model.toggleEditMode();
        },
        trailing: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              EditSessionScreen.id,
              arguments: {'id': session.id},
            );
          },
          icon: Icon(FontAwesomeIcons.angleRight),
        ),
      ),
      duration: Duration(milliseconds: 200),
    );
  }
}
