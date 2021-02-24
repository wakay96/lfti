import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class DetailExpandableTile extends StatelessWidget {
  final String title;
  final Widget header;
  final Widget content;
  final Function onTap;
  final bool isExpanded;

  DetailExpandableTile({
    this.title = '',
    this.onTap,
    this.isExpanded = false,
    this.content,
    @required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// title
            Text(
              title.toUpperCase(),
              style: appStyles.grayLabelText,
            ),

            SizedBox(height: 3.0),

            /// Widget content
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: appStyles.inactiveBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                border: appStyles.inactiveBorder,
              ),
              child: isExpanded
                  ? Column(
                      children: [header, content],
                    )
                  : header,
            ),
          ],
        ),
      ),
    );
  }
}
