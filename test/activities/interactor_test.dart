import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/application/old_interactor.dart';
import 'package:webian/events/event.dart';
import 'package:webian/stores/locates_providers_of_state.dart';
import 'package:webian/stores/provides_state.dart';

import '../mocks/mock_provider_of_state_streams.dart';
import '../mocks/test_watcher.dart';

void main() {
  OldInteractor _interactor;
  PublishSubject<Event> _events;
  LocatesProviderOfState _stateProviderLocator;
  final somethingHappen = Event(Symbol('something_happen'));

  setUp(() {
    _events = PublishSubject<Event>();
    _stateProviderLocator = MockLocatesProviderOfState();
    _interactor = OldInteractor(
        locatorOfProviderOfState: _stateProviderLocator, events: _events);
  });

  tearDown(() {
    _events.close();
  });

  group("Interactor should", () {
    test(
        "still emit events when a publish subject "
        "is not provided at creation", () {
      _interactor =
          OldInteractor(locatorOfProviderOfState: _stateProviderLocator);
      final watcher = TestWatcher();
      watcher.runOnDone = () {
        expect(watcher.events[0], somethingHappen);
      };
      _interactor.subscribe(watcher);
      _interactor.emit(somethingHappen);
      _interactor.dispose();
    });

    test("emit events", () {
      scheduleMicrotask(() {
        _interactor.emit(somethingHappen);
      });
      expect(_events.stream, emits(somethingHappen));
    });

    test("close the events on dispose", () {
      _interactor.dispose();
      scheduleMicrotask(() {
        _interactor.emit(somethingHappen);
      });
      expect(_events.stream, neverEmits(somethingHappen));
    });

    test("subscribe watcher", () async {
      final watcher = TestWatcher();
      _interactor.subscribe(watcher);
      final error = Exception("error");
      _events.listen((event) {
        expect(watcher.events[0], somethingHappen);
      }, onError: (error) {
        expect(watcher.error, error);
      });
      expectLater(_events,
          emitsInOrder([emits(somethingHappen), emitsError(error), emitsDone]));
      _events.add(somethingHappen);
      _events.addError(error);
      _events.close();
    });

    test("provide the correct provider of state for the provide symbol", () {
      final stateProvider = TestProvidesState();
      final symbol = Symbol("some_store_symbol");
      when(_stateProviderLocator.locate<String>(symbol))
          .thenAnswer((_) => stateProvider);
      final result = _interactor.find<String>(symbol);
      expect(result, stateProvider);
    });
  });
}

class TestProvidesState extends Mock implements ProvidesState<String> {}
