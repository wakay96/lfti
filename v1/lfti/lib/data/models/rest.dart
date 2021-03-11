import 'package:lfti/helpers/app_strings.dart';

import 'activity.dart';

class Rest extends Activity {
  String id;
  int _seconds;
  Duration duration;
  Rest(this._seconds, {this.id})
      : super(name: '${_seconds}s Rest', description: REST_ACTIVITY_DESC) {
    duration = Duration(seconds: _seconds);
  }
}
