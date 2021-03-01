import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webian/navigation/destinations/destination.dart';

import 'app_navigation_state.dart';

abstract class AppNavigationStore<S extends AppNavigationState>
    extends StateNotifier<S> {
  AppNavigationStore(S initialValue) : super(initialValue);

  void push(Destination destination) => _add(destination);

  void pushOrBringToFront(Destination destination) {
    if (state.destinationsStack.contains(destination)) {
      _bringToFront(destination);
    } else {
      _add(destination);
    }
  }

  _bringToFront(Destination destination) {
    state = state.clone(
        destinations: [...state.destinationsStack]
          ..remove(destination)
          ..add(destination));
  }

  _add(Destination destination) {
    state = state.clone(
        destinations: [...state.destinationsStack]..add(destination));
  }

  void removeLast() {
    state =
        state.clone(destinations: [...state.destinationsStack]..removeLast());
  }
}
