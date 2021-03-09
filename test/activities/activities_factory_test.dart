import 'package:flutter_test/flutter_test.dart';
import 'package:webian/activities/activities_factory.dart';
import 'package:webian/activities/do_nothing_activity.dart';
import 'package:webian/events/event.dart';

import '../mocks/test_activity.dart';
import '../mocks/test_application.dart';

void main() {
  late TestApplication application;

  setUp(() {
    application = TestApplication();
  });

  group("Activities Factry should", () {
    test(
        "build the activity using the provided builder "
        "that matches the event's symbol", () {
      final factory = ActivitiesFactory();
      final activity = TestActivity(application);
      factory.map[TestActivity.symbol] = (application, {Event? event}) {
        return activity;
      };
      final event = Event(TestActivity.symbol);
      final result = factory.buildFor(application, event: event);
      expect(result, activity);
    });

    test(
        "return the do nothing activity when the symbol is for a "
        "activity that does not have a 'registered' activity", () {
      final factory = ActivitiesFactory();
      factory.map[TestActivity.symbol] = (application, {Event? event}) {
        return TestActivity(application);
      };
      final event = Event(Symbol("a_random_symbol"));
      final result = factory.buildFor(application, event: event);
      expect(result, isA<DoNothingActivity>());
    });
  });
}
