import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/custom_card.dart";

class ChecklistItemCard extends StatefulWidget {
  final Key key;
  final Function onTap, onOptionsTap;
  final IconData optionsIcon;
  final String data;
  ChecklistItemCard(
      {@required this.key,
      @required this.onTap,
      this.onOptionsTap,
      this.data = "",
      this.optionsIcon = Icons.delete});

  @override
  _ChecklistItemCardState createState() => _ChecklistItemCardState(
      key: this.key,
      onTap: this.onTap,
      onOptionsTap: this.onOptionsTap,
      data: this.data,
      optionsIcon: this.optionsIcon);
}

class _ChecklistItemCardState extends State<ChecklistItemCard> {
  Function onTap, onOptionsTap;
  IconData optionsIcon;
  String data;
  Key key;

  _ChecklistItemCardState(
      {this.key, this.onTap, this.onOptionsTap, this.data, this.optionsIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomCard(
          cardChild: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: kSizedBoxHeight),
                    Text(
                      this.data,
                      style: kSmallBoldTextStyle,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => this.onOptionsTap(),
                child: Icon(this.optionsIcon, color: kIconColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
