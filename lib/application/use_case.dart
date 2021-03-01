
import 'package:dart_extras/dart_extras.dart';

/// An Action is a Use Case that will output a
/// result back to the creator/user of the action.
abstract class Action<R extends ResultOf> {
    Future<R> execute();
}
