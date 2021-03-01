
import '../application/application.dart';
import '../events/event.dart';
import 'activity.dart';
import 'do_nothing_activity.dart';

typedef ActivityBuilder = Activity Function(Application application, {Event event});

class ActivitiesFactory {
    
    Map<Symbol, ActivityBuilder> map = Map<Symbol, ActivityBuilder>();
    List<ActivityBuilder> lifetimeActivities =  <ActivityBuilder>[];

    Activity buildFor(Application application, {Event event}) {
        if (map.containsKey(event.symbol)) return map[event.symbol](application, event: event);
        else return DoNothingActivity(application);
    }
    
    List<Activity> buildForAppLifetime(Application application)
        => lifetimeActivities.map((build) => build(application)..start()).toList();
}
