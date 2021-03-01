import 'package:rxdart/rxdart.dart';
import 'package:webian/activities/activity.dart';
import 'package:webian/application/application.dart';
import 'package:webian/application/old_interactor.dart';
import 'package:webian/events/event.dart';
import 'package:webian/services/services.dart';
import 'package:webian/stores/stores.dart';

class TestApplication extends Application {
  TestApplication(
      {OldInteractor interactor,
      Stores stores,
      PublishSubject<Event> channel,
      Services services})
      : super(
            interactor: interactor,
            stores: stores,
            channel: channel,
            services: services);

  @override
  done(Activity activity) {}
}
