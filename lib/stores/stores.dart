import 'package:webian/providers/provider.dart';
import 'package:webian/stores/provides_state.dart';
import 'package:webian/stores/store.dart';

import 'locates_providers_of_state.dart';

class Stores extends ProviderOf<Store> implements LocatesProviderOfState {
  @override
  ProvidesState<T> locate<T>(Symbol symbol) {
    if (items.containsKey(symbol)) {
      return (items[symbol] as Store) as ProvidesState<T>;
    } else
      return null;
  }
}
