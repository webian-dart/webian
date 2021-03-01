import 'package:webian/entries/validation.dart';

abstract class Validator<T> {
  Validation validate(T value);
}
