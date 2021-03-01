

import 'package:flutter_test/flutter_test.dart';

import '../mocks/test_activity.dart';
import '../mocks/test_application.dart';

void main() {
    group("Activity should", () {
       test("stop", () {
            final activity = TestActivity(TestApplication());
            activity.start();
            expect(activity.isRunning, true);
            activity.stop();
            expect(activity.isRunning, false);
       });
    });
}
