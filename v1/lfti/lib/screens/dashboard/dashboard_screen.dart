import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;
import 'package:lfti/helpers/app_strings.dart' as appStrings;
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/providers/dashboard_provider.dart';
import 'package:lfti/screens/dashboard/widgets/body_fat_section.dart';
import 'package:lfti/screens/dashboard/widgets/activity_section.dart';
import 'package:lfti/screens/dashboard/widgets/dashboard_progress_indicator.dart';
import 'package:lfti/screens/dashboard/widgets/weight_section.dart';
import 'package:lfti/shared/session_data_tile.dart';
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
              WeightSection(),

              /// Body Fat
              BodyFatSection(),

              /// Daily and Weekly Activity
              ActivitySection(),

              /// Previous Session
              SessionDataTile(
                session: viewModel.sessionData.previousSession,
                isExpanded: viewModel.activeSection == Section.PreviousSession,
                onTap: () =>
                    viewModel.setActiveSection(Section.PreviousSession),
              ),

              /// Next Session
              SessionDataTile(
                session: viewModel.sessionData.nextSession,
                isExpanded: viewModel.activeSection == Section.NextSession,
                onTap: () => viewModel.setActiveSection(Section.NextSession),
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
