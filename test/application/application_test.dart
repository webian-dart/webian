import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';

import '../mocks/mock_interactor.dart';
import '../mocks/test_application.dart';
import '../mocks/test_services.dart';
import '../mocks/test_stores.dart';

void main() {
  group("Application should", () {
    test("dispose interactor and channel on close", () {
      // ignore: close_sinks
      final channel = PublishSubject<Event>();
      final interactor = MockInteractor();
      final app = TestApplication(
          channel: channel,
          interactor: interactor,
          services: TestServices(),
          stores: TestStores());
      app.close();
      expect(channel.isClosed, true);
      verify(interactor.dispose());
    });
  });
}
