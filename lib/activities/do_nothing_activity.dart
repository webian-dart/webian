import 'package:webian/application/app_driver.dart';

import 'activity.dart';

class DoNothingActivity extends Activity {
  DoNothingActivity(ApplicationDriver application) : super(application);

  @override
  Future start() {
      return Future.value(null);
  }
  
}
