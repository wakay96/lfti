import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lfti/data/models/exercise.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/app_styles.dart';

class EditExerciseContent extends StatefulWidget {
  final Exercise activity;
  final Widget icon;
  final bool isNameEditable;
  final bool isTargetEditable;
  final bool isSetsEditable;
  final bool isRepsEditable;
  EditExerciseContent(this.activity,
      {this.icon,
      this.isNameEditable = true,
      this.isTargetEditable = true,
      this.isSetsEditable = true,
      this.isRepsEditable = true});

  @override
  _EditExerciseContentState createState() => _EditExerciseContentState();
}

class _EditExerciseContentState extends State<EditExerciseContent> {
  TextEditingController repsTextController;
  TextEditingController setsTextController;
  TextEditingController nameTextController;
  Map<String, bool> editable;
  Exercise activity;

  @override
  void initState() {
    repsTextController =
        TextEditingController(text: widget.activity.repCount.toString());
    setsTextController =
        TextEditingController(text: widget.activity.setCount.toString());
    nameTextController = TextEditingController(text: widget.activity.name);
    activity = widget.activity;
    editable = {
      'name': widget.isNameEditable,
      'sets': widget.isSetsEditable,
      'reps': widget.isRepsEditable,
      'target': widget.isNameEditable,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderTextFieldInput(nameTextController, context,
              keyboardType: TextInputType.text, enabled: editable['name']),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sets', style: labelSmallTextStyle),
                    _renderTextFieldInput(setsTextController, context,
                        keyboardType: TextInputType.number,
                        enabled: editable['sets'])
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reps', style: labelSmallTextStyle),
                    _renderTextFieldInput(repsTextController, context,
                        keyboardType: TextInputType.number,
                        enabled: editable['reps'])
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
                    _renderTextFieldInput(
                        TextEditingController(text: activity.target), context,
                        enabled: editable['target'])
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

void showTargetPicker(BuildContext context) {
  FixedExtentScrollController targetSelectionController;
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoPicker(
            backgroundColor: primaryColor,
            onSelectedItemChanged: (val) {
              print(val);
            },
            diameterRatio: 1,
            magnification: 1.2,
            itemExtent: 25,
            children: _buildPickerItems([
              Target.Chest,
              Target.Leg,
              Target.Shoulder,
              Target.Back,
              Target.Arm,
              Target.Core
            ]),
            scrollController: targetSelectionController,
          ),
        );
      });
}

List<Widget> _buildPickerItems(List items) {
  return items.map((item) {
    return Text('$item', style: mediumTextStyle, textAlign: TextAlign.center);
  }).toList();
}

Widget _renderTextFieldInput(
    TextEditingController controller, BuildContext context,
    {TextInputType keyboardType = TextInputType.text, bool enabled = true}) {
  return TextField(
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: controller.text,
      hintStyle: labelMediumTextStyle,
      alignLabelWithHint: true,
      isCollapsed: true,
      fillColor: Colors.grey,
      border: enabled ? null : InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    ),
    cursorColor: tertiaryColor,
    controller: controller,
    style: enabled ? workoutMediumTextStyle : uneditableMediumTextStyle,
    enabled: enabled,
  );
}
