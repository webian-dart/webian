import 'package:dart_extras/dart_extras.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webian/stores/store.dart';

void main() {
  group("Store should", () {
    test("emits state changes", () {
      final initialStateToSend = TestState();
      final store = TestStore(initialStateToSend);
      bool called = false;
      store.addListener(() {
        called = true;
      });
      store.notifyListeners();
      expect(called, true);
    });
  });
}

class TestStore extends Store<TestState> {
  TestStore(TestState initialValue) : super(initialValue);
}

class TestState implements Cloneable {
  @override
  clone() {
    return this;
  }
}
