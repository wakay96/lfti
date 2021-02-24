import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/detail_split_tile.dart';
import 'package:lfti/shared/row_content.dart';

class BodyFatSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return DetailSplitTile(
      isActive: viewModel.activeSection == Section.BodyFat,
      onTap: viewModel.selectBodyFatSection,
      title: 'Body Fat',
      content1: RowContent(
        content: '${viewModel.userData.currentBodyFat}',
        subContent: appStrings.PERCENT_UNIT,
      ),
      content2: RowContent(
        content: '${viewModel.userData.targetBodyFat}',
        subContent: appStrings.PERCENT_UNIT,
      ),
    );
  }
}
