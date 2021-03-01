import 'package:dart_extras/dart_extras.dart';

abstract class ApplicationState implements Cloneable {
  static const Symbol symbol = const Symbol("app_store");

  ApplicationState();
}
