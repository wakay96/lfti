import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lfti/data/models/rest.dart';
import 'package:lfti/helpers/app_styles.dart';

class EditRestContent extends StatefulWidget {
  final Rest activity;
  final bool isEnabled;
  EditRestContent(this.activity, {this.isEnabled = true});

  @override
  _EditRestContentState createState() => _EditRestContentState();
}

class _EditRestContentState extends State<EditRestContent> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(
        text: widget.activity.duration.inSeconds.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Rest', style: labelSmallTextStyle),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: controller.text,
                hintStyle: labelMediumTextStyle,
                alignLabelWithHint: true,
                isCollapsed: true,
                fillColor: Colors.grey,
                border: widget.isEnabled ? null : InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              cursorColor: tertiaryColor,
              controller: controller,
              style: widget.isEnabled
                  ? workoutMediumTextStyle
                  : uneditableMediumTextStyle,
              enabled: widget.isEnabled,
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              'sec',
              style: mediumTextStyle,
            ),
          ),
        ],
      )
    ]);
  }
}
