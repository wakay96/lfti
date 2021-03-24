import 'package:flutter_test/flutter_test.dart';
import 'package:lfti/data/models/date_time_info.dart';

void dateTimeInfoTest() {
  group('DateTimeInfo Class', () {
    group('dayName ', () {
      DateTimeInfo dti = DateTimeInfo(DateTime.now());
      test(" - result should be a valid weekday name", () {
        /// execute
        String res = dti.dayName;

        /// assert
        List<String> options = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ];
        expect(true, options.contains(res));
      });

      test(' - should return Friday', () {
        dti = DateTimeInfo(DateTime(2007, 2, 16));
        String name = dti.dayName;
        expect(name, 'Friday');
      });
    });
    group('monthName', () {
      DateTimeInfo dti = DateTimeInfo(DateTime.now());
      test(' - should return valid month', () {
        /// execute
        String res = dti.monthName;

        // assert
        List<String> options = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        expect(true, options.contains(res));
      });
      test(' - should return valid abbreviated month length', () {
        /// execute
        String res = dti.monthName;

        // assert
        expect(true, res.length == 3);
      });
    });

    group('year', () {
      DateTimeInfo dti = DateTimeInfo(DateTime.now());
      test(' - should return valid year of > 4 length', () {
        /// execute
        String year = dti.year;

        /// assert
        expect(true, year.length >= 4);
      });

      test(' - should return year greater >= 2021', () {
        int year = int.parse(dti.year);
        expect(true, year >= 2021);
      });

      test(' - should return 2007', () {
        dti = DateTimeInfo(DateTime(2007, 2, 16));
        String year = dti.year;
        expect(year, '2007');
      });
    });

    group('day', () {
      DateTimeInfo dti = DateTimeInfo(DateTime.now());
      test(' - should return valid day > 0 && <= 31', () {
        /// execute
        int d = int.parse(dti.day);

        /// assert
        expect(true, d > 0 && d <= 31);
      });

      test(' - should return 16', () {
        dti = DateTimeInfo(DateTime(2020, 2, 16));
        String day = dti.day;
        expect(day, '16');
      });
    });
  });
}
