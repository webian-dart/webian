import 'package:flutter_test/flutter_test.dart';
import 'package:webian/navigation/destinations/destination.dart';

void main() {
  group("Destination should", () {
    test("be to nowhere", () {
      expect(Destination.nowhere.isNowhere, true);
      expect(Destination.nowhere.isToSomewhere, false);
    });

    test("be to somewhere", () {
      expect(Destination(Uri()).isToSomewhere, true);
      expect(Destination(Uri()).isNowhere, false);
    });
  });
}
