import 'package:flutter/material.dart';
import 'package:lfti_app/classes/ChecklistItem.dart';
import 'package:lfti_app/classes/Constants.dart';

class Checklist extends StatefulWidget {
  final List _checklist;
  Checklist(this._checklist);
  @override
  _ChecklistState createState() => _ChecklistState(_checklist);
}

class _ChecklistState extends State<Checklist> {
  var _checklist = List<ChecklistItem>();

  _ChecklistState(var _list) {
    for (var item in _list) {
      _checklist.add(ChecklistItem(item, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _checklist.map(
        (item) {
          return CheckboxListTile(
            activeColor: Colors.blueAccent,
            value: item.getStatus(),
            title: Text(
              item.getDescription(),
              style: kSmallBoldTextStyle,
            ),
            onChanged: (bool newStatus) {
              setState(
                () => item.setStatus(newStatus),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
