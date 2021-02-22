import 'package:flutter/foundation.dart';
import 'package:lfti/data.models/date_time_info.dart';

class DashboardProvider extends ChangeNotifier {
  DateTimeInfo _dateTimeInfo;

  String currentWeekdayText = 'Monday';
  String currentMonthDayText = 'Jan 1';
  int remainingHours;

  DashboardProvider() {
    _dateTimeInfo = DateTimeInfo(DateTime.now());
    currentWeekdayText = _dateTimeInfo.dayName;
    currentMonthDayText = '${_dateTimeInfo.monthName} ${_dateTimeInfo.day}';
    remainingHours = getRemainingHoursLeft();
  }

  int getRemainingHoursLeft() {
    int current = _dateTimeInfo.militaryHours;
    return current > 0 ? (24 - current) : current;
  }
}
