import 'dart:async';

import 'package:dart_extras/dart_extras.dart';
import 'package:webian/application/i_drive_application.dart';

/// Activity are User Stories
/// They listen to app events and perform a goal
/// for the user or component. They do this
/// by making use of one of more actions (Use Cases).
abstract class Activity {
  IDriveApplication appDriver;
  Activity(this.appDriver);

  FutureOr<Result> start();
  stop() {}
}
