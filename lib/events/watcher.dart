import 'dart:async';
import 'package:dart_extras/dart_extras.dart';
import 'event.dart';

class Watcher<T extends Event> {
  void Function(T event)? onEvent;
  Function(dynamic error)? onError;
  void Function()? onDone;
  void Function()? onUnpaused;
  final bool cancelOnError;
  StreamSubscription<T>? _subscription;
  Stream<Event>? _stream;

  Watcher(
      {this.onEvent, this.onError, this.onDone, this.cancelOnError = false});

  watch(Stream<Event> stream) {
    _stream = stream;
    _subscription = stream.cast<T>().listen(onEvent,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  stop() {
    _clearSubscription();
    _stream = null;
  }

  void _clearSubscription() {
    _subscription?.cancel();
    _subscription = null;
  }

  pause({bool cacheEventsUntilResume = false, Future<void>? resumeSignal}) {
    if (cacheEventsUntilResume && _subscription?.isPaused == false) {
      _subscription?.pause(resumeSignal);
    } else {
      _clearSubscription();
    }
  }

  resume() {
    if (_subscription?.isPaused == true) {
      _subscription?.resume();
      onUnpaused?.call();
    } else
      _stream?.apply((it) {
        watch(it);
        onUnpaused?.call();
      });
  }
}
