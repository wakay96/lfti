import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/app_styles.dart';

import '../../helpers/app_styles.dart';

class EditExerciseContent extends StatefulWidget {
  final Exercise activity;
  final Widget icon;
  final bool isNameEditable;
  final bool isTargetEditable;
  final bool isSetsEditable;
  final bool isRepsEditable;
  final Function onChanged;

  EditExerciseContent(this.activity,
      {this.icon,
      this.isNameEditable = true,
      this.isTargetEditable = true,
      this.isSetsEditable = true,
      this.isRepsEditable = true,
      this.onChanged});

  @override
  _EditExerciseContentState createState() => _EditExerciseContentState();
}

class _EditExerciseContentState extends State<EditExerciseContent> {
  TextEditingController repsTextController;
  TextEditingController setsTextController;
  TextEditingController nameTextController;
  FixedExtentScrollController targetSelectionController;
  Map<String, bool> editable;
  Exercise activity;

  final targetItems = [
    Target.Chest,
    Target.Leg,
    Target.Shoulder,
    Target.Back,
    Target.Arm,
    Target.Core
  ];

  @override
  void initState() {
    activity = widget.activity;
    repsTextController =
        TextEditingController(text: activity.repCount.toString());
    setsTextController =
        TextEditingController(text: activity.setCount.toString());
    nameTextController = TextEditingController(text: activity.name);
    targetSelectionController = FixedExtentScrollController(
        initialItem: targetItems.indexOf(activity.target));
    editable = {
      'name': widget.isNameEditable,
      'sets': widget.isSetsEditable,
      'reps': widget.isRepsEditable,
      'target': widget.isTargetEditable
    };
    super.initState();
  }

  void confirmChange() {
    widget.onChanged(activity);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderTextFieldInput(nameTextController, context,
              keyboardType: TextInputType.text,
              enabled: editable['name'],
              label: 'Name'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderTextFieldInput(
                      setsTextController,
                      context,
                      label: 'Sets',
                      keyboardType: TextInputType.number,
                      enabled: editable['sets'],
                      onChanged: (val) {
                        activity.setCount = int.tryParse(val);
                        confirmChange();
                      },
                    )
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderTextFieldInput(repsTextController, context,
                        label: 'Reps',
                        keyboardType: TextInputType.number,
                        enabled: editable['reps'], onChanged: (val) {
                      activity.repCount = int.tryParse(val);
                      confirmChange();
                    })
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Target', style: labelSmallTextStyle),
                    SizedBox(height: 4.0),
                    editable['target']
                        ? InkWell(
                            child: Text(
                              activity.target,
                              style: workoutMediumTextStyle,
                            ),
                            onTap: () async {
                              await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height /
                                          3,
                                      child: CupertinoPicker(
                                        backgroundColor: primaryColor,
                                        onSelectedItemChanged: (index) {
                                          activity.target = targetItems[index];
                                        },
                                        squeeze: 1,
                                        diameterRatio: 1,
                                        magnification: 1.5,
                                        itemExtent: 20,
                                        children:
                                            _buildPickerItems(targetItems),
                                        scrollController:
                                            targetSelectionController,
                                      ),
                                    );
                                  });
                              confirmChange();
                            },
                          )
                        : Text(
                            '${activity.target}',
                            style: mediumTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

List<Widget> _buildPickerItems(List items) {
  return items.map((item) {
    return Text('$item', style: mediumTextStyle, textAlign: TextAlign.center);
  }).toList();
}

Widget _renderTextFieldInput(
    TextEditingController controller, BuildContext context,
    {TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    Function onChanged,
    String label}) {
  return TextField(
    onChanged: (val) => onChanged(val),
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelStyle: labelSmallTextStyle,
      labelText: label,
      fillColor: Colors.grey,
      border: enabled ? null : InputBorder.none,
    ),
    cursorColor: tertiaryColor,
    controller: controller,
    style: enabled ? workoutMediumTextStyle : uneditableMediumTextStyle,
    enabled: enabled,
  );
}
