import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/user_data_tiles.dart';
import 'package:provider/provider.dart';

class ActivitySection extends StatelessWidget {
  final Section sectionId = Section.Activity;
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return UserDataTiles(
      isActive: viewModel.activeSection == sectionId,
      icons: [AppIcon.workoutIcon],
      unit: appStrings.MINUTE_UNIT + 's',
      color: appStyles.workoutThemeColor,
      onTap: () => viewModel.setActiveSection(sectionId),
      labels: <String>['Current Mins', 'Target Mins'],
      contents: <String>[
        '${viewModel.sessionData.currentWorkoutDuration.inMinutes}',
        '${viewModel.sessionData.targetWorkoutDuration.inMinutes}'
      ],
    );
  }
}
