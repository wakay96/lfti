import 'package:flutter/material.dart';

class WeekdayPicker extends StatelessWidget {
  final List<bool> selections;
  final Function onSelect;
  late final bool isEditable;

  WeekdayPicker(
      {required this.selections,
      required this.onSelect,
      required this.isEditable});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: isEditable
          ? _getPickerOptions(context, selections, onSelect)
          : _getUneditableOptions(context, selections),
    );
  }

  List<Widget> _getPickerOptions(
    BuildContext context,
    List<bool> selections,
    Function onTap,
  ) {
    const List<String> dayNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    List<Widget> widgets = [];
    for (int i = 0; i < selections.length; i++) {
      widgets.add(
        Expanded(
          flex: 1,
          child: AnimatedContainer(
            height: Theme.of(context).buttonTheme.height,
            decoration: BoxDecoration(
              border: Border.all(),
              color: selections[i]
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
            ),
            duration: Duration(milliseconds: 100),
            child: InkWell(
              onTap: () => onTap(i),
              child: Center(
                child: Text(
                  dayNames[i].substring(0, 1),
                  style: selections[i]
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).accentTextTheme.bodyText1,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> _getUneditableOptions(
    BuildContext context,
    List<bool> selections,
  ) {
    const List<String> dayNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    List<Widget> widgets = [];
    for (int i = 0; i < selections.length; i++) {
      widgets.add(
        Expanded(
          flex: 1,
          child: Container(
            height: Theme.of(context).buttonTheme.height,
            decoration: BoxDecoration(
              border: Border.all(),
              color: selections[i]
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).canvasColor,
            ),
            child: Center(
              child: Text(
                dayNames[i].substring(0, 1),
                style: selections[i]
                    ? Theme.of(context).textTheme.bodyText1
                    : Theme.of(context).accentTextTheme.bodyText1,
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}
