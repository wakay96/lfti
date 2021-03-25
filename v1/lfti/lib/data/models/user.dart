class User {
  String id;
  String firstName;
  String lastName;
  String email;
  double height;
  double? currentWeight;
  double? targetWeight;
  double? currentBodyFat;
  double? targetBodyFat;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.height,
    this.currentWeight,
    this.targetWeight,
    this.currentBodyFat,
    this.targetBodyFat,
  });
}
