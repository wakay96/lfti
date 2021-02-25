import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lfti/data/models/date_time_info.dart';
import 'package:lfti/data/models/session.dart';
import 'package:lfti/data/models/session_data.dart';
import 'package:lfti/data/models/user_data.dart';
import 'package:lfti/data/repository/i_repository.dart';
import 'package:lfti/helpers/app_enums.dart';
import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/app_styles.dart' as appStyles;

class ProgressViewWidgetDataModel {
  String message;
  int total;
  int current;
  Color color;

  ProgressViewWidgetDataModel({
    this.message = '',
    this.total = 100,
    this.current = 0,
    this.color = appStyles.secondaryColor,
  });
}

class DashboardProvider extends ChangeNotifier {
  final IRepository _repository = GetIt.I<IRepository>();
  DateTimeInfo _dateTimeInfo;

  /// Screen Data
  String currentWeekdayText = '';
  String currentMonthDayText = '';
  String remainingHoursText = '';
  int weekSessionCount = 0;
  Session previousSession;
  Session nextSession;

  UserData userData;
  Section activeSection;
  SessionsData sessionData;

  ProgressViewWidgetDataModel progressViewData = ProgressViewWidgetDataModel();

  DashboardProvider() {
    initializeData();
  }

  initializeData() {
    _dateTimeInfo = DateTimeInfo(DateTime.now());
    currentWeekdayText = _dateTimeInfo.dayName;
    currentMonthDayText = "${_dateTimeInfo.monthName} ${_dateTimeInfo.day}";

    userData = _repository.getUserData();
    sessionData = _repository.getSessionData();

    previousSession = sessionData.previousSession;
    nextSession = sessionData.nextSession;
    weekSessionCount = getWeekSessionCount();

    selectDayAndTimeSection();
    notifyListeners();
  }

  int calcRemainingHrsOfTheDay() => 24 - _dateTimeInfo.militaryHours;

  /// only show progress indicator iff no expandable widgets
  /// are expanded
  bool shouldShowProgressIndicator() {
    return activeSection == Section.NextSession ||
        activeSection == Section.PreviousSession;
  }

  int getWeekSessionCount() {
    int count = 0;
    sessionData.daysWorkedOutThisWeek.forEach((element) {
      if (element == true) count++;
    });
    return count;
  }

  String getFormattedMessageRemaining(
      {double spent, double total, String unit, String message}) {
    final double value = (total - spent).abs();
    String roundedStringValue = value.toStringAsFixed(1);
    if (value == 1 || unit == PERCENT_UNIT) {
      return "$roundedStringValue $unit left";
    } else if (value > 1) {
      return "$roundedStringValue ${unit}s left";
    } else {
      return unit;
    }
  }

  String getFormattedArrayEnumValues(List<dynamic> list) {
    String formattedString = '';
    list.forEach((element) {
      formattedString += (element.toString() + ', ');
    });
    // remove last comma
    return formattedString.substring(0, formattedString.length - 2);
  }

  void selectDayAndTimeSection() {
    progressViewData.message = getFormattedMessageRemaining(
        spent: _dateTimeInfo.militaryHours.toDouble(),
        total: 24,
        unit: HOUR_UNIT,
        message: TIME_UP_MESSAGE);
    progressViewData.total = 24;
    progressViewData.current = _dateTimeInfo.militaryHours;
    progressViewData.color = appStyles.secondaryColor;
    activeSection = Section.DateAndTime;
    notifyListeners();
  }

  void selectWeightSection() {
    if (activeSection == Section.Weight) {
      selectDayAndTimeSection();
    } else {
      progressViewData.message = getFormattedMessageRemaining(
          spent: userData.currentWeight,
          total: userData.targetWeight,
          unit: LB_UNIT_TEXT,
          message: GOAL_MET_MESSAGE);
      progressViewData.total = userData.targetWeight.floor();
      progressViewData.current = userData.currentWeight.floor();
      progressViewData.color = appStyles.weightThemeColor;
      activeSection = Section.Weight;
      notifyListeners();
    }
  }

  void selectBodyFatSection() {
    if (activeSection == Section.BodyFat) {
      selectDayAndTimeSection();
    } else {
      progressViewData.message = getFormattedMessageRemaining(
          spent: userData.currentBodyFat,
          total: userData.targetBodyFat,
          unit: PERCENT_UNIT,
          message: GOAL_MET_MESSAGE);
      progressViewData.total = userData.currentBodyFat.floor();
      progressViewData.current = userData.targetBodyFat.floor();
      progressViewData.color = appStyles.bodyFatThemeColor;
      activeSection = Section.BodyFat;
      notifyListeners();
    }
  }

  void selectActivitySection() {
    if (activeSection == Section.Activity) {
      selectDayAndTimeSection();
    } else {
      progressViewData.message = getFormattedMessageRemaining(
          spent: sessionData.currentWorkoutDuration.inMinutes.toDouble(),
          total: sessionData.targetWorkoutDuration.inMinutes.toDouble(),
          unit: MINUTE_UNIT,
          message: GOAL_MET_MESSAGE);
      progressViewData.total = sessionData.targetWorkoutDuration.inMinutes;
      progressViewData.current = sessionData.currentWorkoutDuration.inMinutes;
      activeSection = Section.Activity;
      notifyListeners();
    }
  }

  void selectPreviousSession() {
    if (activeSection == Section.PreviousSession) {
      selectDayAndTimeSection();
    } else {
      activeSection = Section.PreviousSession;
      notifyListeners();
    }
  }

  void selectNextSession() {
    if (activeSection == Section.NextSession) {
      selectDayAndTimeSection();
    } else {
      activeSection = Section.NextSession;
      notifyListeners();
    }
  }
}
