import 'package:webian/application/i_drive_application.dart';

import '../events/event.dart';
import 'activity.dart';
import 'do_nothing_activity.dart';

typedef ActivityBuilder = Activity Function(IDriveApplication appDriver,
    {Event event});

class ActivitiesFactory {
  Map<Symbol, ActivityBuilder> map = Map<Symbol, ActivityBuilder>();
  List<ActivityBuilder> lifetimeActivities = <ActivityBuilder>[];

  Activity buildFor(IDriveApplication appDriver, {Event? event}) {
    if (event != null && map.containsKey(event.symbol)) {
      return map[event.symbol]!(appDriver, event: event);
    } else
      return DoNothingActivity(appDriver);
  }

  List<Activity> buildForAppLifetime(IDriveApplication appDriver) =>
      lifetimeActivities.map((build) => build(appDriver)..start()).toList();
}
