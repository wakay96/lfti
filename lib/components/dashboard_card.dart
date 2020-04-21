import 'package:flutter/material.dart';
import 'package:lfti_app/classes/Constants.dart';
import 'package:lfti_app/components/custom_card.dart';

class DashboardCard extends StatelessWidget {
  final String heading;
  final String mainInfo;
  final String details;

  DashboardCard(
      {@required this.heading, @required this.mainInfo, this.details = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomCard(
        cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.heading,
                style: kLabelTextStyle,
              ),
              Divider(
                thickness: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.mainInfo,
                    style: kMediumBoldTextStyle,
                  ),
                  SizedBox(height: kSizedBoxHeight),
                  Text(
                    this.details,
                    style: kMediumLabelTextStyle,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
