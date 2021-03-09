import 'package:webian/events/event.dart';
import 'package:webian/events/watcher.dart';

class TestWatcher<T extends Event> extends Watcher<T> {
  Function runOnDone = () {};
  List<Event> events = [];
  dynamic error;
  bool isDone = false;

  TestWatcher(): super() {
    this.onEvent = onEventAction;
    this.onError= onErrorAction;
    this.onDone = onDoneAction;
  }

  void onEventAction(T event) {
    events.add(event);
  }

  void onErrorAction(dynamic error) {
    this.error = error;
  }

  void onDoneAction() {
    this.isDone = true;
    runOnDone();
  }
}
