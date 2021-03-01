import 'package:webian/events/event.dart';
import 'package:webian/events/watcher.dart';

class TestWatcher<T extends Event> extends Watcher<T> {
  Function runOnDone = () {};
  List<Event> events = [];
  dynamic error;
  bool isDone = false;

  TestWatcher() {
    this.onEventAction = onEvent;
    this.onErrorAction = onError;
    this.onDoneAction = onDone;
  }

  void onEvent(T event) {
    events.add(event);
  }

  void onError(dynamic error) {
    this.error = error;
  }

  void onDone() {
    this.isDone = true;
    runOnDone();
  }
}
