class DateService {}

enum Months {
  january('Jan', 'January'),
  february('Feb', 'February'),
  march('Mar', 'March'),
  april('Apr', 'April'),
  may('May', 'May'),
  june('Jun', 'June'),
  july('Jul', 'July'),
  august('Aug', 'August'),
  september('Sept', 'September'),
  october('Oct', 'October'),
  november('Nov', 'November'),
  december('Dec', 'December');

  final String abbr;
  final String name;

  const Months(this.abbr, this.name);
}

enum Days {
  monday('Mon'),
  tuesday('Tue'),
  wednesday('Wed'),
  thursday('Thu'),
  friday('Fri'),
  saturday('Sat'),
  sunday('Sun');

  final String abbr;

  const Days(this.abbr);
}
