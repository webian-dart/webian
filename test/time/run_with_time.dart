// run_with_time.dart
import 'package:clock/clock.dart';

/// Runs [callback] and prints how long it took.
T runWithTime<T>(T callback()) {
    var stopwatch = clock.stopwatch()..start();
    var result = callback();
    print("It took ${stopwatch.elapsed}!");
    return result;
}