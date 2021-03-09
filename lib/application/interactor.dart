import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';
import 'package:webian/events/watcher.dart';

class Interactor {
  bool _isNotDisposed = true;
  final PublishSubject<Event> _inputBus;

  Interactor([PublishSubject<Event>? inputBus])
      : this._inputBus = inputBus ?? PublishSubject<Event>();

  emit(Event event) {
    if (_isNotDisposed) _inputBus.add(event);
  }

  emitFor(Symbol symbol) => emit(Event(symbol));

  StreamSubscription subscribe(Function(Event) onEvent) =>
      _inputBus.stream.listen(onEvent);

  watch(Watcher<Event> watcher) {
    watcher.watch(_inputBus.stream);
  }

  dispose() {
    _isNotDisposed = false;
    _inputBus.close();
  }
}
