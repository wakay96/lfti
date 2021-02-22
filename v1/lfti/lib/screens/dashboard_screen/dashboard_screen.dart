import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/shared/column_header_content.dart';
import 'package:lfti/shared/column_header_content.dart';
import 'package:lfti/shared/detail_expandable_tile.dart';
import 'package:lfti/shared/detail_split_tile.dart';
import 'package:lfti/shared/row_content.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final DashboardProvider viewModel = Provider.of<DashboardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          size: 35,
        ),
        backgroundColor: appStyles.mainBackgroundColor,
        shadowColor: Colors.transparent,
        title: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            'dashboard',
            style: appStyles.appBarTitleTextStyleLight,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        color: appStyles.mainBackgroundColor,
        padding: appStyles.primaryContainerSidePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Weekday and date
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          viewModel.currentWeekdayText,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.065,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        viewModel.currentMonthDayText,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// TODO: Circular Progress bar
            Container(
              padding: EdgeInsets.only(bottom: 30.0),
              child: FittedBox(
                child: Center(
                  child: Stack(
                    children: [
                      CircularStepProgressIndicator(
                        totalSteps: 100,
                        currentStep: 10,
                        stepSize: 15,
                        selectedStepSize: 20,
                        selectedColor: appStyles.dangerColor,
                        unselectedColor: Colors.grey[200],
                        padding: 0,
                        width: 180,
                        height: 180,
                        roundedCap: (_, __) => true,
                      ),
                      Container(
                        width: 180,
                        height: 180,
                        child: Center(
                          child: viewModel.remainingHours > 0
                              ? RowContent(
                                  content: '${viewModel.remainingHours}',
                                  subContent: viewModel.remainingHours > 1
                                      ? 'hours left'
                                      : 'hour left',
                                )
                              : RowContent(content: "Time's up"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                children: [
                  /// Weight
                  DetailSplitTile(
                    title: 'Weight',
                    content1: RowContent(
                      content: '150',
                      subContent: appStrings.LBS_UNIT_TEXT,
                    ),
                    content2: RowContent(
                      content: '180',
                      subContent: appStrings.LBS_UNIT_TEXT,
                    ),
                  ),
                  SizedBox(height: 8.0),

                  /// Body Fat
                  DetailSplitTile(
                    title: 'Body Fat',
                    content1: RowContent(
                      content: '21',
                      subContent: appStrings.PERCENT_LABEL,
                    ),
                    content2: RowContent(
                      content: '16',
                      subContent: appStrings.PERCENT_LABEL,
                    ),
                  ),
                  SizedBox(height: 8.0),

                  /// Activity
                  DetailSplitTile(
                    title: 'Activity',
                    label1: 'WEEK',
                    label2: 'DAY',
                    content1: RowContent(
                      content: '150',
                      subContent: appStrings.LBS_UNIT_TEXT,
                    ),
                    content2: RowContent(
                      content: '150',
                      subContent: appStrings.LBS_UNIT_TEXT,
                    ),
                  ),
                  SizedBox(height: 8.0),

                  /// Previous Session
                  DetailExpandableTile(
                    title: 'Previous Session',
                    content: ColumnHeaderContent(),
                  ),
                  SizedBox(height: 8.0),

                  /// Next Session
                  DetailExpandableTile(
                    title: 'Next Session',
                    content: ColumnHeaderContent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
