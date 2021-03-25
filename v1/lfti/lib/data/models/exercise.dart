import 'activity.dart';

class Exercise extends Activity {
  String? target;
  int? setCount;
  int? repCount;

  Exercise({
    required String id,
    required String name,
    String? description,
    this.setCount,
    this.repCount,
    this.target,
  }) : super(id: id, name: name, description: description);
}
