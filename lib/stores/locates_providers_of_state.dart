import 'package:webian/stores/provides_state.dart';

abstract class LocatesProviderOfState {
  ProvidesState<T> locate<T>(Symbol symbol);
}
