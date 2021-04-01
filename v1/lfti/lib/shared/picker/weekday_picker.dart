import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart';

class WeekdayPicker extends StatelessWidget {
  final List<bool> selections;
  final Function onSelect;

  WeekdayPicker({
    required this.selections,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _getPickerOptions(context, selections, onSelect),
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
            decoration: BoxDecoration(
              border: Border.all(),
              color: selections[i]
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
            ),
            duration: Duration(milliseconds: 200),
            child: TextButton(
              onPressed: () => onTap(i),
              child: Text(dayNames[i].substring(0, 1),
                  style: selections[i]
                      ? TextStyle(
                          color: dangerColor,
                          fontWeight: FontWeight.bold,
                        )
                      : Theme.of(context).textTheme.bodyText1),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}
