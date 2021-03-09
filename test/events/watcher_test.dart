import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';
import 'package:webian/events/watcher.dart';

void main() {
  final somethingHappen = Event(Symbol('something_happen'));
  late PublishSubject<Event> subject;

  setUp(() {
    subject = PublishSubject();
  });

  tearDown(() {
    subject.close();
  });

  group("Watcher should", () {
    test("subscribe to subject", () {
      Watcher().watch(subject);
      expect(subject.hasListener, true);
    });

    test("cancel subscription on stop", () {
      Watcher().stop();
      expect(subject.hasListener, false);
    });

    test("watch and run on event", () async {
      Event? event;
      Watcher(onEvent: (Event e) {
        event = e;
        subject.close();
      })
        ..watch(subject);
      expectLater(subject, emitsInOrder([emits(somethingHappen), emitsDone]))
          .then((value) {
        expect(event, somethingHappen);
      });
      subject.add(somethingHappen);
    });

    test("watch and run on done", () async {
      bool onDoneWasRun = false;
      Watcher(onDone: () {
        onDoneWasRun = true;
      }).watch(subject);
      expectLater(subject, emitsInOrder([emitsDone])).then((value) {
        expect(onDoneWasRun, true);
      });
      subject.close();
    });

    test("watch and run on error", () async {
      final error = Error();
      bool onErrorWasRun = false;
      final watcher = Watcher(onError: (e) {
        onErrorWasRun = true;
      });
      final secondWatcher = Watcher(onError: (e) {
        if (!onErrorWasRun) {
          throw Error();
        }
      });
      watcher.watch(subject);
      secondWatcher.watch(subject);
      expectLater(subject, emitsInOrder([emitsError(error)])).then((value) {
        expect(onErrorWasRun, true);
      });
      subject.addError(error);
    });

    test("nothing happens until we start to watch ", () {
      // Setup
      final error = Error();
      var onEventCounter = 0;
      var onErrorCounter = 0;
      var onDoneCounter = 0;
      late Watcher watcher;
      watcher = Watcher(
          onEvent: (e) => onEventCounter++,
          onError: (e) {
            onErrorCounter++;
            // After First Error Stop to any more events
            watcher.stop();
          },
          onDone: () => onDoneCounter++)
        ..watch(subject);
      // Later
      expectLater(
          subject,
          emitsInOrder([
            somethingHappen,
            somethingHappen,
            emitsError(error),
            somethingHappen,
            emitsError(error),
            emitsDone
          ])).then((value) {
        // After the events nothing should have happened
        expect(onEventCounter, 2, reason: "onEventCounter");
        expect(onErrorCounter, 1, reason: "onErrorCounter");
        expect(onDoneCounter, 0, reason: "onDoneCounter");
      });
      // Send events
      subject
        ..add(somethingHappen)
        ..add(somethingHappen)
        ..addError(error)
        ..add(somethingHappen)
        ..addError(error)
        ..close();
    });

    test("should be able to pause and resume watching", () async {
      // Setup
      var eventCounter = 0;
      expectLater(subject, emitsThrough(emitsDone)).then((value) {
        // Once all events have been sent then we
        expect(eventCounter, 4);
      });

      late final Watcher watcher;
      watcher = Watcher(onEvent: (e)  {
        eventCounter++;
      })..watch(subject);

      // Send events
      subject.add(somethingHappen); // +1
      // give it time to handle last event first
      await Future.delayed(Duration(milliseconds: 1));
      watcher.pause();
      subject.add(somethingHappen); // 0
      watcher.resume();
      subject.add(somethingHappen); // +1
      subject.add(somethingHappen); // +1
      // give it time to handle last event first
      await Future.delayed(Duration(milliseconds: 1));
      watcher.pause();
      subject.add(somethingHappen); // 0
      watcher.resume();
      subject.add(somethingHappen); // +1
      subject.close();
    });

    test("should be able on resume to receive all events that "
        "were not handled while paused", () async {
      // Setup
      var eventCounter = 0;
      expectLater(subject, emitsThrough(emitsDone)).then((value) {
        // Once all events have been sent then we
        expect(eventCounter, 6);
      });
      late final Watcher watcher;
      watcher = Watcher(onEvent: (e)  {
        eventCounter++;
      })..watch(subject);

      // Send events
      subject.add(somethingHappen); // +1
      // give it time to handle last event first
      await Future.delayed(Duration(milliseconds: 1));
      watcher.pause(cacheEventsUntilResume: true);
      subject.add(somethingHappen); // +1
      watcher.resume();
      subject.add(somethingHappen); // +1
      subject.add(somethingHappen); // +1
      // give it time to handle last event first
      await Future.delayed(Duration(milliseconds: 1));
      watcher.pause(cacheEventsUntilResume: true);
      subject.add(somethingHappen); // +1
      watcher.resume();
      subject.add(somethingHappen); // +1
      subject.close();
    });
  });
}
