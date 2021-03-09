import 'dart:async';

import 'package:dart_extras/dart_extras.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/application/interactor.dart';
import 'package:webian/events/event.dart';
import 'package:webian/stores/provides_state.dart';

import '../mocks/test_watcher.dart';

void main() {
  late Interactor interactor;
  late PublishSubject<Event> inputBus;
  final somethingHappen = Event(Symbol('something_happen'));

  setUp(() {
    inputBus = PublishSubject<Event>();
    interactor = Interactor(inputBus);
  });

  tearDown(() {
    inputBus.close();
  });

  group("Interactor should", () {
    test(
        "still emit events when a publish subject "
        "is not provided at creation", () {
      final watcher = TestWatcher();
      watcher.runOnDone = () {
        expect(watcher.events[0], somethingHappen);
      };
      interactor.watch(watcher);
      interactor.emit(somethingHappen);
      interactor.dispose();
    });

    test("emit events", () {
      scheduleMicrotask(() {
        interactor.emit(somethingHappen);
      });
      expect(inputBus.stream, emits(somethingHappen));
    });

    test("close the events on dispose", () {
      interactor.dispose();
      scheduleMicrotask(() {
        interactor.emit(somethingHappen);
      });
      expect(inputBus.stream, neverEmits(somethingHappen));
    });

    test("subscribe watcher", () async {
      final watcher = TestWatcher();
      interactor.watch(watcher);
      final fault = Fault("error");
      inputBus.listen((event) {
        expect(watcher.events[0], somethingHappen);
      }, onError: (fault) {
        expect(watcher.error, fault);
      });
      expectLater(inputBus,
          emitsInOrder([emits(somethingHappen), emitsError(fault), emitsDone]));
      inputBus.add(somethingHappen);
      inputBus.addError(fault);
      inputBus.close();
    });
  });
}

class TestProvidesState extends Mock implements ProvidesState<String> {}
