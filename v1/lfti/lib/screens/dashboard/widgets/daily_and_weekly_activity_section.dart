import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/detail_split_tile.dart';
import 'package:lfti/shared/row_content.dart';
import 'package:provider/provider.dart';

class DailyAndWeeklyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return DetailSplitTile(
      isActive: viewModel.activeSection == Section.Activity,
      onTap: viewModel.selectActivitySection,
      title: 'Activity',
      label1: 'WEEK',
      label2: 'DAY',
      content1: RowContent(
        content: '${viewModel.weekSessionCount}',
        subContent: viewModel.weekSessionCount > 1
            ? '${appStrings.SESSION_TEXT}s this week'
            : '${appStrings.SESSION_TEXT} this week',
      ),
      content2: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RowContent(
            content:
                '${viewModel.sessionData.currentWorkoutDuration.inMinutes}',
            subContent: 'of',
          ),
          SizedBox(width: 5.0),
          RowContent(
            content: '${viewModel.sessionData.targetWorkoutDuration.inMinutes}',
            subContent: '${appStrings.MINUTE_UNIT}s',
          ),
        ],
      ),
    );
  }
}
