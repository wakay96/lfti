import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/shared/user_data_tiles.dart';
import 'package:provider/provider.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/providers/dashboard_provider.dart';

class BodyFatSection extends StatelessWidget {
  final Section sectionId = Section.BodyFat;
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return UserDataTiles(
      isActive: viewModel.activeSection == sectionId,
      unit: appStrings.PERCENT_UNIT,
      icons: [AppIcon.bodyFatIcon],
      color: appStyles.bodyFatThemeColor,
      onTap: () => viewModel.setActiveSection(sectionId),
      labels: <String>['Current Body Fat', 'Target Body Fat'],
      contents: <String>[
        '${viewModel.userData.currentBodyFat}',
        '${viewModel.userData.targetBodyFat}'
      ],
    );
  }
}
