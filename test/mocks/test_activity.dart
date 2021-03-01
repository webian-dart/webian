import 'package:webian/activities/activity.dart';
import 'package:webian/application/application.dart';

class TestActivity extends Activity {
  static const Symbol symbol = const Symbol("test_activity");

  bool isRunning = false;

  TestActivity(Application application) : super(application);

  @override
  Application application;

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
