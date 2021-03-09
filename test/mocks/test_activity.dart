import 'package:webian/activities/activity.dart';
import 'package:webian/application/app_driver.dart';

class TestActivity extends Activity {
  static const Symbol symbol = const Symbol("test_activity");

  bool isRunning = false;

  TestActivity(ApplicationDriver application) : super(application);

  @override
  Future start() {
    isRunning = true;
    return Future.value();
  }

  @override
  stop() {
    super.stop();
    isRunning = false;
  }
}
