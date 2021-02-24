import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/detail_split_tile.dart';
import 'package:lfti/shared/row_content.dart';
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:provider/provider.dart';

class WeightSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return DetailSplitTile(
      isActive: viewModel.activeSection == Section.Weight,
      onTap: viewModel.selectWeightSection,
      title: 'Weight',
      content1: RowContent(
        content: '${viewModel.userData.currentWeight}',
        subContent: appStrings.LB_UNIT_TEXT,
      ),
      content2: RowContent(
        content: '${viewModel.userData.targetWeight}',
        subContent: appStrings.LB_UNIT_TEXT,
      ),
    );
  }
}
