import 'package:flutter_test/flutter_test.dart';
import 'package:webian/events/event_data.dart';

void main() {
  group("Even Data should", () {
    test("is not empty", () {
      final data = Data("");
      expect(data.isNotEmpty(), true);
      expect(data.isEmpty(), false);
    });
    test("is empty", () {
      final data = Data.empty;
      expect(data.isNotEmpty(), false);
      expect(data.isEmpty(), true);
    });
  });
}
