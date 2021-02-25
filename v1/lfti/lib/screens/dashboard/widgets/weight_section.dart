import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/helpers/app_icons.dart';
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/row_content.dart';
import 'package:lfti/shared/tile_button.dart';
import 'package:provider/provider.dart';

class WeightSection extends StatelessWidget {
  final color = appStyles.weightThemeColor;
  final unit = appStrings.LB_UNIT_TEXT + 's';

  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TileButton(
              onTap: viewModel.selectWeightSection,
              label: 'Current Weight',
              icon: IconService.weightIcon,
              content: RowContent(
                content: viewModel.userData.currentWeight.toString(),
                subContent: unit,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: TileButton(
              onTap: viewModel.selectWeightSection,
              label: 'Target Weight',
              content: RowContent(
                content: viewModel.userData.targetWeight.toString(),
                subContent: unit,
                color: color,
              ),
            ),
          ),
        ]);
  }
}
