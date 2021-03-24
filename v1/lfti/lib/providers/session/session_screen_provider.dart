import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/providers/screen_provider.dart';
import 'package:lfti/screens/session/create_session_screen.dart';

class SessionScreenProvider extends ScreenProvider {
  bool editMode = false;
  Session? selectedSession;
  late List<Session> sessions = [];

  void initialize(BuildContext context) {
    super.initialize(context);
    this.sessions = repo.getAllSessions();
  }

  void enableEditMode() {
    editMode = true;
    toggleSelectedSession(null);
    notifyListeners();
  }

  void saveChanges() {
    editMode = false;
    selectedSession = null;
    notifyListeners();
  }

  void toggleSelectedSession(String? id) {
    Session? session;
    try {
      session = sessions.firstWhere((item) => item.id == id);
      selectedSession = session;
    } catch (e) {
      selectedSession = null;
    }
    notifyListeners();
  }

  void deleteSession(String id) {
    sessions.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  bool isSelectedSession(String id) {
    if (selectedSession != null) {
      return id == selectedSession?.id;
    } else {
      return false;
    }
  }

  void startSession(BuildContext context) {
    print('start session');
  }

  void createSession(BuildContext context) {
    Navigator.pushNamed(context, CreateSessionScreen.id);
  }
}
