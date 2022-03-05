import 'package:riverpod/src/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/application/i_drive_application.dart';
import 'package:webian/events/event.dart';

class TestApplication extends IDriveApplication {
  @override
  PublishSubject<Event> inputsBus;

  @override
  PublishSubject<Event> internalBus;
  @override
  final ProviderContainer scope;

  TestApplication(
      {PublishSubject<Event>? internalBus,
      PublishSubject<Event>? inputsBus,
      ProviderContainer? scope})
      : internalBus = internalBus ?? PublishSubject<Event>(),
        inputsBus = inputsBus ?? PublishSubject<Event>(),
        this.scope = scope ?? ProviderContainer(),
        super();

  @override
  void close() {
    inputsBus.close();
    internalBus.close();
  }
}
