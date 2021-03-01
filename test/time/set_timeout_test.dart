import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webian/time/set_timeout.dart';

void main() {
  group("SetTimeoutTest should", () {
    test("run action after timeout time", () {
      fakeAsync((async) {
        bool run = false;
        final duration = Duration(seconds: 5);
        SetTimeout(duration, () {
          run = true;
        }).run();
        async.elapse(Duration(milliseconds: 4999));
        expect(run, false);
        async.elapse(Duration(milliseconds: 1));
        expect(run, true);
      });
    });
  });
}
