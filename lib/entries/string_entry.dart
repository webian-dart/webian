import 'package:webian/entries/entry.dart';
import 'package:webian/entries/validation.dart';

class StringEntry extends Entry<String> {
  @override
  final String value;
  @override
  final Validation validation;

  StringEntry({String value, Validation validation})
      : this.value = value ?? "",
        this.validation = validation ?? Validation();

  @override
  clone() => StringEntry(value: this.value, validation: this.validation);
}
