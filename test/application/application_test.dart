import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';

import '../mocks/test_application.dart';

void main() {
  group("Application should", () {
    test("dispose interactor and channel on close", () {
      // ignore: close_sinks
      final appBus = PublishSubject<Event>();
      // ignore: close_sinks
      final inputBus = PublishSubject<Event>();
      final app = TestApplication(internalBus: appBus, inputsBus: inputBus);
      app.close();
      expect(appBus.isClosed, true);
      expect(inputBus.isClosed, true);
    });
  });
}
