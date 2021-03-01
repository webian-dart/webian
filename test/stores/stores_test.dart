import 'package:dart_extras/dart_extras.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webian/stores/store.dart';
import 'package:webian/stores/stores.dart';

void main() {
  group("Stores should", () {
    test("provide us with the correct state provider for the symbol", () {
      final symbol1 = Symbol("one");
      final symbol2 = Symbol("two");
      final store1 = DummyStore();
      final store2 = DummyStore();
      final stores = Stores();
      stores.add(symbol1, store1);
      stores.add(symbol2, store2);
      expect(stores.locate(symbol1), store1);
      expect(stores.locate(symbol2), store2);
    });

    test("provides us with the empty stream when no state stream can be found",
        () {
      final stores = Stores();
      final symbol1 = Symbol("one");
      expect(stores.locate(symbol1), null);
    });
  });
}

class DummyStore extends Store<DummyState> {
  DummyStore() : super(DummyState());
}

class DummyState extends Cloneable {
  @override
  clone() => this;
}
