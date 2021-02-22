import 'package:lfti/helpers/app_strings.dart';

import 'activity.dart';

class Rest extends Activity {
  int _seconds;
  Duration duration;
  Rest(this._seconds)
      : super(name: REST_ACTIVITY_NAME, description: REST_ACTIVITY_DESC) {
    duration = Duration(seconds: _seconds);
  }
}
