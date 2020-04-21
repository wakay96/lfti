class Date {
  int month;
  int date;
  int year;

  Date(this.month, this.date, this.year);

  int getMonth;
  int getDate;
  int getYear;

  @override
  String toString() {
    return "$month/$date/$year";
  }
}
