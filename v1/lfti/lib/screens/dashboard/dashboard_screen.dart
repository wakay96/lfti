import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lfti/helpers/app_styles.dart';
import 'package:lfti/providers/dashboard_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:lfti/screens/dashboard/dashboard_progress_indicator.dart';
import 'package:lfti/shared/tiles/session_data_tile.dart';
import 'package:lfti/shared/tiles/user_data_tiles.dart';
import 'package:lfti/helpers/app_icon.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/helpers/app_enums.dart';

/// This class builds and links the provider for the screen
class DashboardScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardScreenProvider>(
      create: (BuildContext context) => DashboardScreenProvider(),
      child: DashboardScreen(),
    );
  }
}

/// Contains actual UI elements
class DashboardScreen extends StatefulWidget {
  static const String id = "DashboardScreen";
  final String appBarTitle = "dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DashboardScreenProvider>(context, listen: false)
        .initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DashboardScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        title: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            widget.appBarTitle,
            style: appBarTitleTextStyleLight,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: primaryColor,
      body: Padding(
        padding: primaryContainerSidePadding,
        child: ListView(reverse: true, children: [
          Container(
            child: Column(children: [
              DashboardProgressIndicator(),
              SizedBox(height: 24.0),

              /// Weight Section
              UserDataTiles(
                  isActive: viewModel.activeSection == DashboardSection.Weight,
                  unit: appStrings.LB_UNIT_TEXT + 's',
                  icons: [AppIcon.weight],
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
                  icons: [AppIcon.bodyFat],
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
                  icons: [AppIcon.time],
                  unit: appStrings.MINUTE_UNIT + 's',
                  color: appStyles.timeThemeColor,
                  onTap: () =>
                      viewModel.setActiveSection(DashboardSection.Activity),
                  labels: ['Current Mins', 'Target Mins'],
                  contents: [
                    '${viewModel.sessionData.currentWorkoutDuration.inMinutes}',
                    '${viewModel.sessionData.targetWorkoutDuration.inMinutes}'
                  ]),

              /// Previous Session
              SessionDataTile(viewModel.sessionData.previousSession),

              /// Next Session
              SessionDataTile(viewModel.sessionData.nextSession)
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
                    fontSize: MediaQuery.of(context).size.height * 0.050,
                    fontWeight: FontWeight.w700,
                    color: currentAppThemeTextColor,
                  ),
                ),
              ),
              Text(
                viewModel.currentMonthDayText,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
