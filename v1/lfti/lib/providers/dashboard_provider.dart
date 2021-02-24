import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/date_time_info.dart';
import 'package:lfti/data/models/session_info.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_strings.dart';

class ProgressViewWidgetDataModel {
  String message;
  int total;
  int current;

  ProgressViewWidgetDataModel({
    this.message = '',
    this.total = 100,
    this.current = 0,
  });
}

class DashboardProvider extends ChangeNotifier {
  final IRepository repository = GetIt.I<IRepository>();
  DateTimeInfo _dateTimeInfo;

  /// Screen Data
  String currentWeekdayText = '';
  String currentMonthDayText = '';
  String remainingHoursText = '';
  double currentWeight = 0.0;
  double targetWeight = 0.0;
  double currentBodyFat = 0.0;
  double targetBodyFat = 0.0;
  int currentDailyActivity = 0;
  int targetDailyActivity = 0;
  List<bool> weekActivity = [];
  int weekActivityPerformedCount = 0;
  Section activeSection;

  /// TODO: Implement Session class
  // Session previousSession;
  // Session currentSession;

  ProgressViewWidgetDataModel progressViewData = ProgressViewWidgetDataModel();

  DashboardProvider() {
    initializeData();
  }

  initializeData() {
    _dateTimeInfo = DateTimeInfo(DateTime.now());
    activeSection = Section.DateAndTime;
    currentWeekdayText = _dateTimeInfo.dayName;
    currentMonthDayText = "${_dateTimeInfo.monthName} ${_dateTimeInfo.day}";
    remainingHoursText = getFormattedRemainingHoursLeft();
    currentWeight = 150.5;
    targetWeight = 180.0;
    currentBodyFat = 21.1;
    targetBodyFat = 16.0;
    currentDailyActivity = 35;
    targetDailyActivity = 65;
    weekActivity = [true, true, false, true, true, false, false];
    weekActivityPerformedCount = calcWeeklyActivityPerformedCount();
    progressViewData.message = remainingHoursText;
    progressViewData.total = 24;
    progressViewData.current = _dateTimeInfo.militaryHours;
    notifyListeners();
  }

  int calcRemainingHrs() => 24 - _dateTimeInfo.militaryHours;
  double calcRemainingWeight() => targetWeight - currentWeight;
  double calcRemainingBodyFat() => targetBodyFat - currentBodyFat;

  bool hasExpandedSection() {
    return activeSection == Section.NextSession ||
        activeSection == Section.PreviousSession;
  }

  int calcWeeklyActivityPerformedCount() {
    int count = 0;
    weekActivity.forEach((element) {
      if (element == true) count++;
    });
    return count;
  }

  String getFormattedRemainingHoursLeft() {
    final int remaining = calcRemainingHrs();
    if (remaining == 1) {
      return "$remaining hour left";
    } else if (remaining > 1) {
      return "$remaining hours left";
    } else {
      return TIME_UP_MESSAGE;
    }
  }

  String getFormattedRemainingWeightLeft() {
    final double remaining = calcRemainingWeight();
    if (remaining == 1) {
      return "$remaining $LB_UNIT_TEXT left";
    } else if (remaining > 1) {
      return "$remaining $LBS_UNIT_TEXT left";
    } else {
      return GOAL_MET_MESSAGE;
    }
  }

  void selectWeeklyAndDailySection() {
    progressViewData.message = remainingHoursText;
    progressViewData.total = 24;
    progressViewData.current = _dateTimeInfo.militaryHours;
    activeSection = Section.DateAndTime;
    notifyListeners();
  }

  void selectWeightSection() {
    if (activeSection == Section.Weight) {
      selectWeeklyAndDailySection();
    } else {
      progressViewData.message = 'Weight Section';
      progressViewData.total = targetWeight.floor();
      progressViewData.current = currentWeight.floor();
      activeSection = Section.Weight;
      notifyListeners();
    }
  }

  void selectBodyFatSection() {
    if (activeSection == Section.BodyFat) {
      selectWeeklyAndDailySection();
    } else {
      progressViewData.message = 'BMI Section';
      progressViewData.total = currentBodyFat.floor();
      progressViewData.current = targetBodyFat.floor();
      activeSection = Section.BodyFat;
      notifyListeners();
    }
  }

  void selectActivitySection() {
    if (activeSection == Section.Activity) {
      selectWeeklyAndDailySection();
    } else {
      progressViewData.message = 'Activity Section';
      progressViewData.total = weekActivity.length;
      progressViewData.current = weekActivityPerformedCount;
      activeSection = Section.Activity;
      notifyListeners();
    }
  }

  void selectPreviousSession() {
    if (activeSection == Section.PreviousSession) {
      selectWeeklyAndDailySection();
    } else {
      activeSection = Section.PreviousSession;
      notifyListeners();
    }
  }

  void selectNextSession() {
    if (activeSection == Section.NextSession) {
      selectWeeklyAndDailySection();
    } else {
      activeSection = Section.NextSession;
      notifyListeners();
    }
  }
}
