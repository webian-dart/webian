import 'package:webian/stores/application_state.dart';
import 'package:webian/stores/store.dart';

abstract class ApplicationStore<T extends ApplicationState> extends Store<T> {
  static const Symbol symbol = const Symbol("application_store");
  ApplicationStore(T initialValue) : super(initialValue);
}
