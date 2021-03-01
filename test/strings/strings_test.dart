import 'package:flutter_test/flutter_test.dart';
import 'package:webian/strings/strings.dart';

void main() {
  group("Strings should", () {
    test("convert string to boolean", () {
      expect(Strings.toBoolean('true'), true);
      expect(Strings.toBoolean('TRUE'), true);
      expect(Strings.toBoolean('false'), false);
      expect(Strings.toBoolean(''), false);
      expect(Strings.toBoolean('dajaj'), false);
    });

    test("capitalize words", () {
      expect(Strings.capitalize('true'), "True");
      expect(Strings.capitalize('True'), "True");
      expect(Strings.capitalize('TRUE'), "TRUE");
      expect(Strings.capitalize('hello'), "Hello");
      expect(Strings.capitalize('hello world'), "Hello world");
      expect(Strings.capitalize(''), "");
    });
  });
}
