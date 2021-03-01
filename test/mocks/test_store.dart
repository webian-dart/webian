import 'package:dart_extras/dart_extras.dart';
import 'package:webian/stores/store.dart';

class TestStore extends Store {
  static const Symbol symbol = const Symbol("test_store");

  TestStore(Cloneable initialValue) : super(initialValue);
}
