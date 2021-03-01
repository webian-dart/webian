import 'package:flutter_test/flutter_test.dart';
import 'package:webian/application/app_error.dart';

void main() {
  group("App Error should", () {
    test("hold the message", () {
      final error = AppError("some error");
      expect(error.message, "some error");
    });
  });
}
