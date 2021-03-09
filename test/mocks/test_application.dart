import 'package:dart_extras/src/results/result.dart';
import 'package:riverpod/src/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/activities/activity.dart';
import 'package:webian/application/app_driver.dart';
import 'package:webian/events/event.dart';

class TestApplication extends ApplicationDriver {
  final PublishSubject<Event> appBus;
  final PublishSubject<Event> inputBus;
  final ProviderContainer scope;

  TestApplication(
      {PublishSubject<Event>? appBus,
      PublishSubject<Event>? inputBus,
      ProviderContainer? scope})
      : this.appBus = appBus ?? PublishSubject<Event>(),
        this.inputBus = inputBus ?? PublishSubject<Event>(),
        this.scope = scope ?? ProviderContainer(),
        super();

  @override
  void close() {
    appBus.close();
    inputBus.close();
  }
}
