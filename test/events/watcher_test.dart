import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';
import 'package:webian/events/watcher.dart';

void main() {
  final somethingHappen = Event(Symbol('something_happen'));
  Watcher watcher;
  PublishSubject<Event> subject;

  setUp(() {
    watcher = Watcher();
    subject = PublishSubject();
  });

  tearDown(() {
    subject.close();
  });

  group("Watcher should", () {
    test("subscribe to subject", () {
      watcher.watch(subject);
      expect(subject.hasListener, true);
    });

    test("cancel subscription on stop", () {
      watcher.stop();
      expect(subject.hasListener, false);
    });

    test("listen and run on event", () async {
      watcher.watch(subject);
      expectLater(subject, emitsInOrder([emits(somethingHappen), emitsDone]));
      watcher.onEventAction = (e) {
        expect(e, somethingHappen);
        subject.close();
      };
      subject.add(somethingHappen);
    });

    test("listen and run on done", () async {
      watcher.watch(subject);
      final secondWatcher = Watcher();
      secondWatcher.watch(subject);
      expectLater(subject, emitsInOrder([emitsDone]));
      bool onDoneWasRun = false;
      watcher.onDoneAction = () {
        onDoneWasRun = true;
      };
      secondWatcher.onDoneAction = () {
        if (!onDoneWasRun) {
          throw Error();
        }
      };
      subject.close();
    });

    test("listen and run on error", () async {
      final error = Error();
      watcher.watch(subject);
      final secondWatcher = Watcher();
      secondWatcher.watch(subject);
      expectLater(subject, emitsInOrder([emitsError(error)]));
      bool onErrorWasRun = false;
      watcher.onErrorAction = (e) {
        onErrorWasRun = true;
      };
      secondWatcher.onErrorAction = (e) {
        if (!onErrorWasRun) {
          throw Error();
        }
      };
      subject.addError(error);
    });

    test("nothing happens when a new event action or on error isn\'t set", () {
      watcher.watch(subject);
      expectLater(subject, emitsInOrder([emits(somethingHappen)]));
      subject.add(somethingHappen);
      subject.addError(Error());
    });
  });
}
