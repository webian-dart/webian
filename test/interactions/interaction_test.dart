import 'package:flutter_test/flutter_test.dart';
import 'package:webian/events/event_data.dart';
import 'package:webian/interactions/interaction.dart';

void main() {
  group("Interaction should", () {
    test("instantiates the interation", () {
      final symbol = Symbol("want_to_see_more");
      final i = Interaction(symbol, data: Data("for sure"));
      expect(i.symbol, symbol);
      expect(i.data.data, "for sure");
    });
  });
}
