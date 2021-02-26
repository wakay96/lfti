import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/screens/dashboard/dashboard_progress_indicator.dart';
import 'package:lfti/shared/session_data_tile.dart';
import 'package:lfti/shared/user_data_tiles.dart';
import 'package:provider/provider.dart';

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
        child: ListView(reverse: true, children: [
          Container(
            child: Column(children: [
              DashboardProgressIndicator(),
              SizedBox(height: 12.0),

              /// Weight Section
              UserDataTiles(
                  isActive: viewModel.activeSection == DashboardSection.Weight,
                  unit: appStrings.LB_UNIT_TEXT + 's',
                  icons: [AppIcon.weightIcon],
                  color: appStyles.weightThemeColor,
                  onTap: () =>
                      viewModel.setActiveSection(DashboardSection.Weight),
                  labels: ['Current Weight', 'Target Weight'],
                  contents: [
                    '${viewModel.userData.currentWeight}',
                    '${viewModel.userData.targetWeight}'
                  ]),

              /// Body Fat
              UserDataTiles(
                  isActive: viewModel.activeSection == DashboardSection.BodyFat,
                  unit: appStrings.PERCENT_UNIT,
                  icons: [AppIcon.bodyFatIcon],
                  color: appStyles.bodyFatThemeColor,
                  onTap: () =>
                      viewModel.setActiveSection(DashboardSection.BodyFat),
                  labels: ['Current Body Fat', 'Target Body Fat'],
                  contents: [
                    '${viewModel.userData.currentBodyFat}',
                    '${viewModel.userData.targetBodyFat}'
                  ]),

              /// Daily and Weekly Activity
              UserDataTiles(
                  isActive:
                      viewModel.activeSection == DashboardSection.Activity,
                  icons: [AppIcon.workoutIcon],
                  unit: appStrings.MINUTE_UNIT + 's',
                  color: appStyles.workoutThemeColor,
                  onTap: () =>
                      viewModel.setActiveSection(DashboardSection.Activity),
                  labels: ['Current Mins', 'Target Mins'],
                  contents: [
                    '${viewModel.sessionData.currentWorkoutDuration.inMinutes}',
                    '${viewModel.sessionData.targetWorkoutDuration.inMinutes}'
                  ]),

              /// Previous Session
              SessionDataTile(
                session: viewModel.sessionData.previousSession,
                isExpanded:
                    viewModel.activeSection == DashboardSection.PreviousSession,
                onTap: () => viewModel
                    .setActiveSection(DashboardSection.PreviousSession),
              ),

              /// Next Session
              SessionDataTile(
                session: viewModel.sessionData.nextSession,
                isExpanded:
                    viewModel.activeSection == DashboardSection.NextSession,
                onTap: () =>
                    viewModel.setActiveSection(DashboardSection.NextSession),
              )
            ]),
          ),
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
        ]),
      ),
    );
  }
}
