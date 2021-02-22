import 'dart:core';
import 'package:date_time_format/date_time_format.dart';

class DateTimeInfo {
  DateTime _dateTime;

  DateTimeInfo(this._dateTime);

  String get time {
    String t = DateTimeFormat.format(_dateTime, format: 'g:i a');
    return t;
  }

  String get dayName {
    String d = DateTimeFormat.format(_dateTime, format: 'l');
    return d;
  }

  String get monthName {
    String m = DateTimeFormat.format(_dateTime, format: 'M');
    return m;
  }

  String get year {
    String y = DateTimeFormat.format(_dateTime, format: 'Y');
    return y;
  }

  String get day {
    String d = DateTimeFormat.format(_dateTime, format: 'j');
    return d;
  }

  String get fullDate {
    return '$monthName $day ,$year';
  }

  int get militaryHours {
    String h = DateTimeFormat.format(_dateTime, format: 'G');
    return int.parse(h);
  }
}
