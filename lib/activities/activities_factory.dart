import 'package:webian/application/app_driver.dart';

import '../events/event.dart';
import 'activity.dart';
import 'do_nothing_activity.dart';

typedef ActivityBuilder = Activity Function(ApplicationDriver application,
    {Event event});

class ActivitiesFactory {
  Map<Symbol, ActivityBuilder> map = Map<Symbol, ActivityBuilder>();
  List<ActivityBuilder> lifetimeActivities = <ActivityBuilder>[];

  Activity buildFor(ApplicationDriver application, {Event? event}) {
    if (event != null && map.containsKey(event.symbol)) {
      return map[event.symbol]!(application, event: event);
    } else
      return DoNothingActivity(application);
  }

  List<Activity> buildForAppLifetime(ApplicationDriver application) =>
      lifetimeActivities.map((build) => build(application)..start()).toList();
}
