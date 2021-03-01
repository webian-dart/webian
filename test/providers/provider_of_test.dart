import 'package:flutter_test/flutter_test.dart';
import 'package:webian/providers/provider.dart';

void main() {
  group("ProviderOf should", () {
    test("have a just added item", () {
      final provider = _ProviderOfImplementation();
      final symbol = Symbol('hello');
      final item = _Item();
      provider.add(symbol, item);
      expect(provider.contains<_Item>(symbol), true);
      expect(provider.has(symbol), true);
      expect(provider.contains(Symbol("unknown")), false);
      expect(provider.has(Symbol("unknown")), false);
    });

    test("give us back the correct item for the symbol", () {
      final provider = _ProviderOfImplementation();
      final symbol = Symbol('hello');
      final item = _Item();
      provider.add(symbol, item);
      expect(provider.get<_Item>(symbol), item);
      expect(provider.get<_Item2>(symbol), null);
      expect(provider.get<_Item>(Symbol("unknown")), null);
    });

    test("give us back the first matching correct item for the type", () {
      final provider = _ProviderOfImplementation();
      final item1 = _Item();
      final item2 = _Item();
      final item3 = _Item2();
      provider.add(Symbol('1'), item1);
      provider.add(Symbol('2'), item2);
      provider.add(Symbol('3'), item3);
      expect(provider.of<_Item>(), item1);
      expect(provider.of<_Item2>(), item3);
      expect(provider.of<_Item3>(), null);
    });

    test("will not add any more entries or update for enter symbol key", () {
      final provider = _ProviderOfImplementation();
      final symbol = Symbol('hello');
      final item = _Item();
      final itemSameTimeAsFirst = _Item();
      final item2 = _Item2();
      provider.add(symbol, item);
      provider.add(symbol, item2);
      provider.add(symbol, itemSameTimeAsFirst);
      expect(provider.of<_Item>(), item);
      expect(provider.items.length, 1);
    });
  });
}

class _Item {}

class _Item2 extends _Item {}

class _Item3 extends _Item {}

class _ProviderOfImplementation extends ProviderOf<_Item> {}
