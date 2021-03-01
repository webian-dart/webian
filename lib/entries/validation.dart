import 'package:dart_extras/dart_extras.dart';

import 'entry_status.dart';

class Validation implements Cloneable {
  final EntryStatus status;
  final bool isValid;
  final String validationMessage;

  Validation({EntryStatus status, bool isValid, String validationMessage})
      : this.status = status ?? EntryStatus.EMPTY,
        this.isValid = isValid ?? false,
        this.validationMessage =
            validationMessage ?? "Unknown validation Error";

  @override
  clone() => Validation(
      status: this.status,
      isValid: this.isValid,
      validationMessage: this.validationMessage);
}
