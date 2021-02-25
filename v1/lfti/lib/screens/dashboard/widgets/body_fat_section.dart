import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_icons.dart';
import 'package:lfti/shared/tile_button.dart';
import 'package:lfti/shared/row_content.dart';
import 'package:provider/provider.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/providers/dashboard_provider.dart';

class BodyFatSection extends StatelessWidget {
  final color = appStyles.bodyFatThemeColor;
  final unit = appStrings.PERCENT_UNIT;
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: TileButton(
            onTap: viewModel.selectBodyFatSection,
            label: 'Current Body Fat',
            icon: IconService.bodyFatIcon,
            content: RowContent(
              content: viewModel.userData.currentBodyFat.toString(),
              subContent: unit,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: TileButton(
            onTap: viewModel.selectBodyFatSection,
            label: 'Target Body Fat',
            content: RowContent(
              content: viewModel.userData.targetBodyFat.toString(),
              subContent: unit,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
