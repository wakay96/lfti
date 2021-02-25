import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_icons.dart';
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/row_content.dart';
import 'package:lfti/shared/tile_button.dart';
import 'package:provider/provider.dart';

class ActivitySection extends StatelessWidget {
  final color = appStyles.workoutThemeColor;
  final unit = appStrings.MINUTE_UNIT + 's';

  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TileButton(
            onTap: viewModel.selectActivitySection,
            label: 'Current Mins',
            icon: IconService.workoutIcon,
            content: RowContent(
              content: viewModel.sessionData.currentWorkoutDuration.inMinutes
                  .toString(),
              subContent: unit,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: TileButton(
            onTap: viewModel.selectActivitySection,
            label: 'Target Mins.',
            content: RowContent(
              content: viewModel.sessionData.targetWorkoutDuration.inMinutes
                  .toString(),
              subContent: unit,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
