import 'package:flutter/material.dart';
import 'package:lfti/data/models/session.dart';
import 'new_session_screen_provider.dart';

class EditSessionScreenProvider extends NewSessionScreenProvider {
  @override
  void initialize(BuildContext context) {
    super.initialize(context);
    try {
      id = args['id'];
      Session session = repo.getSessionById(id);
      name = session.name;
      description = session.description;
      scheduleSelection = generateScheduleSelection();
      activities = [...session.activities];
      nameController = TextEditingController(text: name);
      descriptionController = TextEditingController(text: description);
      notifyListeners();
    } catch (e) {
      print(e);
      error = true;
      notifyListeners();
    }
  }

  @override
  void save() {
    try {
      Session session = createSession();
      repo.updateSessionById(id, session);
    } catch (e) {
      print(e);
      error = true;
      notifyListeners();
    }
  }

  void deleteSession() {
    try {
      repo.deleteSessionById(id);
    } catch (e) {
      print(e);
      error = true;
      notifyListeners();
    }
  }
}
