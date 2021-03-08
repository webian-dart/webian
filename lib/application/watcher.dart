import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:webian/events/event.dart';

typedef OnEvent = Function(Event event);
typedef OnError = Function(Object event);
typedef OnDone = Function();
final OnEvent defaultOnEvent = (e) {};
final OnError defaultOnError = (e) {};
final OnDone defaultOnDone = () {};

class Watcher {
  final OnEvent onEvent;
  final OnError onError;
  final VoidCallback onDone;
  final bool cancelOnError;
  StreamSubscription? _subscription;

  Watcher(OnEvent? onEvent,
      {OnError? onError, VoidCallback? onDone, bool cancelOnError = true})
      : this.onEvent = onEvent ?? defaultOnEvent,
        this.onError = onError ?? defaultOnError,
        this.onDone = onDone ?? defaultOnDone,
        this.cancelOnError = cancelOnError;

  watch(Stream<Event> stream) {
    _subscription = stream.listen(onEvent,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  pause() {
    if (_subscription?.isPaused == false) _subscription?.pause();
  }

  resume() {
    if (_subscription?.isPaused == true) _subscription?.resume();
  }
}
