import 'package:webian/application/app_driver.dart';

/// Activity are User Stories
/// They listen to app events and perform a goal
/// for the user or component. They do this
/// by making use of one of more actions (Use Cases).
abstract class Activity {
  ApplicationDriver application;
  Activity(this.application);

  Future start();
  stop() {}
}
