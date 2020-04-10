import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";

class TimeDropdownMenu extends StatefulWidget {
  final int _initialValue;
  TimeDropdownMenu(this._initialValue);

  final _timeDropdownMenuState = _TimeDropdownMenuState();

  @override
  _TimeDropdownMenuState createState() {
    _timeDropdownMenuState._initSelectedValue(_initialValue);
    return _timeDropdownMenuState;
  }

  int getValue() {
    return _timeDropdownMenuState.getSelectedValue();
  }
}

class _TimeDropdownMenuState extends State<TimeDropdownMenu> {
  int _selectedValue;

  @override
  void _initSelectedValue(int val) {
    this._selectedValue = val;
  }

  int getSelectedValue() {
    return this._selectedValue;
  }

  List<DropdownMenuItem> _generateTimeListOptions() {
    var l = List<DropdownMenuItem>();
    for (var number in Iterable<int>.generate(400).toList()) {
      if (number % 5 == 0) {
        l.add(DropdownMenuItem<int>(
          child: Text(
            number.toString(),
            style: kSmallBoldTextStyle,
          ),
          value: number,
        ));
      }
    }
    l.removeAt(0);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text("$_selectedValue", style: kMediumTextStyle),
      value: _selectedValue,
      underline: Container(),
      isDense: true,
      items: _generateTimeListOptions(),
      onChanged: (val) {
        setState(() {
          this._selectedValue = val;
        });
      },
    );
  }
}
