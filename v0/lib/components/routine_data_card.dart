import "package:flutter/material.dart";
import "package:lfti_app/components/custom_card.dart";
import "package:lfti_app/classes/Constants.dart";

class RoutineDataCard extends StatelessWidget {
  final Function onTap;
  final String label;
  final String data;

  const RoutineDataCard({this.label, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        onTap: () => this.onTap(),
        cardChild: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(this.label, style: kLabelTextStyle),
              SizedBox(height: kSizedBoxHeight),
              Text(
                this.data,
                style: kSmallBoldTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
