import 'package:lfti/helpers/app_strings.dart';
import 'package:lfti/helpers/id_generator.dart';

abstract class Activity {
  String id;
  String name;
  String description;

  Activity({
    this.id,
    this.name = DEFAULT_EXERCISE_NAME,
    this.description = DEFAULT_EXERCISE_DESC,
  });
}
