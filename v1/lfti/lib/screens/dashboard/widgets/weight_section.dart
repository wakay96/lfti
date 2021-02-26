import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/user_data_tiles.dart';
import 'package:provider/provider.dart';

class WeightSection extends StatelessWidget {
  final Section sectionId = Section.Weight;
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return UserDataTiles(
      isActive: viewModel.activeSection == sectionId,
      unit: appStrings.LB_UNIT_TEXT + 's',
      icons: [AppIcon.weightIcon],
      color: appStyles.weightThemeColor,
      onTap: () => viewModel.setActiveSection(sectionId),
      labels: <String>['Current Weight', 'Target Weight'],
      contents: <String>[
        '${viewModel.userData.currentWeight}',
        '${viewModel.userData.targetWeight}'
      ],
    );
  }
}
