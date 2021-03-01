import 'package:dart_extras/dart_extras.dart';
import 'package:webian/entries/validation.dart';

abstract class Entry<T> implements Cloneable {
  T get value;
  Validation get validation;
}
