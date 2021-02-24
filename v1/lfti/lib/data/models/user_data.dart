class UserData {
  double currentWeight;
  double targetWeight;
  double height;
  Duration targetDailyActivity;
  Duration currentDailyActivity;
  double currentBodyFat;
  double targetBodyFat;
  List<bool> weeklyActivityHistory;
  int targetSessionCount;

  UserData({
    this.currentWeight,
    this.targetWeight,
    this.currentBodyFat,
    this.targetBodyFat,
    this.height,
    this.targetDailyActivity,
    this.currentDailyActivity,
    this.weeklyActivityHistory,
    this.targetSessionCount,
  });
}
