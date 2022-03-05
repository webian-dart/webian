import 'dart:async';

import 'package:dart_extras/dart_extras.dart';
import 'package:webian/application/i_drive_application.dart';

import 'activity.dart';

class DoNothingActivity extends Activity {
  DoNothingActivity(IDriveApplication appDriver) : super(appDriver);

  @override
  FutureOr<Result> start() {
    return Result.success();
  }
}
