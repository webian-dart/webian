import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';
import 'package:webian/events/watcher.dart';
import 'package:webian/stores/locates_providers_of_state.dart';
import 'package:webian/stores/provides_state.dart';

/// And Interactor is a class that is used to that
/// The core of the app can talk to the outside world.
/// It accepts events and publishes its own events.

class OldInteractor {
  bool _isNotDisposed = true;
  final PublishSubject<Event> _events;
  final LocatesProviderOfState _locatorOfProvidersOfState;

  OldInteractor(
      {LocatesProviderOfState locatorOfProviderOfState,
      PublishSubject<Event> events})
      : this._locatorOfProvidersOfState = locatorOfProviderOfState,
        this._events = events ?? PublishSubject<Event>();

  emit(Event event) {
    if (_isNotDisposed) {
      _events.add(event);
    }
  }

  ProvidesState<T> find<T>(Symbol symbol) =>
      _locatorOfProvidersOfState.locate<T>(symbol);

  subscribe(Watcher watcher) => watcher.watch(_events);

  dispose() {
    _isNotDisposed = false;
    _events.close();
  }
}
