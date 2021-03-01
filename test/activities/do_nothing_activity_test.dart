import 'package:flutter_test/flutter_test.dart';
import 'package:webian/activities/do_nothing_activity.dart';

import '../mocks/test_application.dart';

void main() {
  group("Do Nothing Activity should", () {
    test("do nothing", () {
      DoNothingActivity(TestApplication()).start();
    });
  });
}
