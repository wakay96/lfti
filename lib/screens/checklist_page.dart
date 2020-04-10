import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/classes/User.dart";
import 'package:lfti_app/components/custom_dialog_button.dart';

// component imports
import "package:lfti_app/components/menu.dart";
import "package:lfti_app/components/checklist_item_card.dart";
import "package:lfti_app/components/bottom_navigation_button.dart";
import "package:lfti_app/components/empty_state_notification.dart";
import "package:lfti_app/components/custom_floating_action_button.dart";

// firestore import
import "package:cloud_firestore/cloud_firestore.dart";

class ChecklistPage extends StatefulWidget {
  final User _currentUser;
  ChecklistPage(this._currentUser);

  @override
  _ChecklistPageState createState() => _ChecklistPageState(_currentUser);
}

class _ChecklistPageState extends State<ChecklistPage> {
  final User _currentUser;
  List _checklist = List();

  _ChecklistPageState(this._currentUser) {
    if (this._currentUser.getChecklist() == null) {
      this._currentUser.setChecklist(List());
    }
    _checklist = this._currentUser.getChecklist();
  }

  void _showAddChecklistDialog() async {
    final _descriptionTextController = TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text("Checklist Item Description", style: kMediumLabelTextStyle),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: kCardBackground,
          content: TextFormField(
            controller: _descriptionTextController,
            keyboardType: TextInputType.text,
            style: kSmallBoldTextStyle,
          ),
          actions: <Widget>[
            CustomDialogButton(
              label: "CANCEL",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CustomDialogButton(
              label: "ADD",
              onPressed: () {
                setState(() {
                  this
                      ._currentUser
                      .addChecklistItem(_descriptionTextController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditChecklistDialog(int index) async {
    final _descriptionTextController =
        TextEditingController(text: _checklist[index]);
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text("Checklist Item Description", style: kMediumLabelTextStyle),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: kCardBackground,
          content: TextFormField(
            controller: _descriptionTextController,
            keyboardType: TextInputType.text,
            style: kSmallBoldTextStyle,
          ),
          actions: <Widget>[
            CustomDialogButton(
              label: "CANCEL",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CustomDialogButton(
              label: "ADD",
              onPressed: () {
                setState(() {
                  this._currentUser.setChecklistItemAt(
                      index, _descriptionTextController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeChecklistAt(int index) {
    _currentUser.getChecklist().removeAt(index);
    setState(() {
      _checklist = _currentUser.getChecklist();
    });
  }

  void _saveChanges() {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(_currentUser.getFirestoreReference(),
            {"checklist": _currentUser.getChecklist()});
      });
      print("Success: Checklist Updated!");
      Navigator.pushNamed(context, "/dashboard", arguments: _currentUser);
    } catch (e) {
      print("Error: Failed to update Checklist :" + e.toString());
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      var r = this._checklist.removeAt(oldIndex);
      this._checklist.insert(newIndex, r);
    });
  }

  List<ChecklistItemCard> _getChecklistItems() {
    final routines = List<ChecklistItemCard>();
    if (this._checklist.isNotEmpty) {
      for (int i = 0; i < this._checklist.length; i++) {
        routines.add(
          ChecklistItemCard(
            key: Key("C" + _checklist[i] + i.toString()),
            onOptionsTap: () => _removeChecklistAt(i),
            optionsIcon: Icons.delete,
            data: _checklist[i],
            onTap: () => _showEditChecklistDialog(i),
          ),
        );
      }
    }
    return routines;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text(
            "CHECKLIST",
          ),
        ),
        drawer: Menu(this._currentUser),
        body: this._checklist.isNotEmpty
            ? ReorderableListView(
                onReorder: _onReorder,
                children: _getChecklistItems(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EmptyStateNotification(
                        sub: "Add Items to your Checklist first."),
                  ],
                ),
              ),
        floatingActionButton: CustomFloatingActionButton(
          icon: Icons.add,
          onPressed: () => _showAddChecklistDialog(),
        ),
        bottomNavigationBar: BottomNavigationButton(
            label: "SAVE", action: _saveChanges, color: kBlueButtonColor));
  }
}
