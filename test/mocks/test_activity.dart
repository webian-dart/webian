import 'dart:async';

import 'package:dart_extras/dart_extras.dart';
import 'package:webian/activities/activity.dart';
import 'package:webian/application/i_drive_application.dart';

class TestActivity extends Activity {
  static const Symbol symbol = const Symbol("test_activity");

  bool isRunning = false;

  TestActivity(IDriveApplication application) : super(application);

  @override
  FutureOr<Result> start() {
    isRunning = true;
    return Result.success();
  }

  @override
  stop() {
    super.stop();
    isRunning = false;
  }
}
