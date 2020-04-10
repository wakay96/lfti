import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/components/custom_card.dart';

class DashboardCardTile extends StatelessWidget {
  final String heading;
  final String mainInfo;
  final String details;

  DashboardCardTile(
      {@required this.heading, @required this.mainInfo, this.details = ''});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              heading,
              style: kLabelTextStyle,
            ),
            SizedBox(height: 10.0),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    mainInfo,
                    style: kMediumBoldTextStyle,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    details,
                    style: kMediumLabelTextStyle,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
