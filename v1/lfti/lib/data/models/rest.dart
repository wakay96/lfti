import 'activity.dart';

class Rest extends Activity {
  String id;
  Duration duration;

  Rest(this.id, this.duration)
      : super(name: 'Rest', description: '${duration.inSeconds}s Rest', id: id);
}
