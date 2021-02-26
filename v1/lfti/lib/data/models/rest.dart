import 'package:lfti/helpers/app_strings.dart';

import 'activity.dart';

class Rest extends Activity {
  int _minutes;
  Duration duration;
  Rest(this._minutes)
      : super(name: REST_ACTIVITY_NAME, description: REST_ACTIVITY_DESC) {
    duration = Duration(minutes: _minutes);
  }
}
