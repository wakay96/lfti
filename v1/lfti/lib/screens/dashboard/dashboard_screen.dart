import 'package:flutter/material.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/screens/dashboard/widgets/dashboard_progress_indicator.dart';
import 'package:lfti/screens/dashboard/widgets/weight_section.dart';
import 'package:lfti/shared/column_header_content.dart';
import 'package:lfti/shared/detail_expandable_tile.dart';
import 'package:provider/provider.dart';

import 'widgets/body_fat_section.dart';
import 'widgets/daily_and_weekly_activity_section.dart';

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
        backgroundColor: appStyles.primaryColor,
        shadowColor: Colors.transparent,
        title: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            appStrings.DASHBOARD_HEADER_TEXT,
            style: appStyles.appBarTitleTextStyleLight,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        color: appStyles.primaryColor,
        padding: appStyles.primaryContainerSidePadding,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.125,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FittedBox(
                child: Text(
                  viewModel.currentWeekdayText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.065,
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
            ]),
          ),
          Container(
            child: Column(children: [
              viewModel.hasExpandedSection()
                  ? Container()
                  : DashboardProgressIndicator(),

              /// Weight
              WeightSection(),
              SizedBox(height: 8.0),

              /// Body Fat
              BodyFatSection(),
              SizedBox(height: 8.0),

              /// Daily and Weekly Activity
              DailyAndWeeklyActivity(),
              SizedBox(height: 8.0),

              /// Previous Session
              /// TODO: implement dynamic data
              DetailExpandableTile(
                isExpanded: viewModel.activeSection == Section.PreviousSession,
                onTap: viewModel.selectPreviousSession,
                title: 'Previous Session',
                header: ColumnHeaderContent(header: 'null', content1: 'null'),
                content: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              ),
              SizedBox(height: 8.0),

              /// Next Session
              /// TODO: implement dynamic data
              DetailExpandableTile(
                isExpanded: viewModel.activeSection == Section.NextSession,
                onTap: viewModel.selectNextSession,
                title: 'Next Session',
                header: ColumnHeaderContent(header: 'null', content1: 'null'),
                content: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
