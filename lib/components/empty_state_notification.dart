import "package:flutter/material.dart";

// class imports
import "package:lfti_app/classes/Constants.dart";

class EmptyStateNotification extends StatelessWidget {
  final String sub;
  const EmptyStateNotification({this.sub = ""});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Nothing here yet!",
            style: kMediumBoldTextStyle.copyWith(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kSmallSizedBoxHeight),
          Text(
            this.sub,
            style: kMediumLabelTextStyle.copyWith(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
