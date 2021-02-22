import "package:flutter/material.dart";

class CustomDropdownMenu extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final Function onChangeAction;
  CustomDropdownMenu(
      {this.initialValue = "", @required this.items, this.onChangeAction});

  final _customDropdownMenuState = _CustomDropdownMenuState();
  @override
  _CustomDropdownMenuState createState() {
    _customDropdownMenuState._initDropdownValue(
        this.initialValue, this.items, this.onChangeAction);
    return _customDropdownMenuState;
  }

  String getValue() {
    print("New Value : " + _customDropdownMenuState.getValue());
    return _customDropdownMenuState.getValue();
  }
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String _dropdownValue;
  List<String> _items;
  Function _onChangeAction;

  void _initDropdownValue(String val, List<String> l, Function f) {
    this._dropdownValue = val;
    this._items = l;
    this._onChangeAction = f;
  }

  String getValue() {
    return this._dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: this._dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      isDense: true,
      items: this._items.map((val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val == null ? "null" : val.toString()),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          this._dropdownValue = val;
          print("Selected New Value : $_dropdownValue");
        });
        _onChangeAction();
      },
    );
  }
}
