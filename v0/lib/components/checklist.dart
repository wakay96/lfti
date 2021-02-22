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

  _ChecklistState(var l) {
    for (var item in l) {
      _checklist.add(ChecklistItem(item, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _checklist.map((item) {
        var style = item.isChecked()
            ? kSmallTextStyle.copyWith(
                color: Colors.grey, decoration: TextDecoration.lineThrough)
            : kSmallBoldTextStyle;
        return Column(
          children: <Widget>[
            CheckboxListTile(
                dense: true,
                value: item.isChecked(),
                title: Text(item.getDescription(), style: style),
                onChanged: (newStatus) {
                  setState(() {
                    item.setStatus(newStatus);
                  });
                }),
          ],
        );
      }).toList(),
    );
  }
}
