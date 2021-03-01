import 'package:flutter/cupertino.dart';

extension EdgeInsetsExtensions on EdgeInsets {
  static EdgeInsets fromLTR(double value) {
    return EdgeInsets.only(
      left: value,
      top: value,
      right: value,
    );
  }

  static EdgeInsets fromRBL(double value) {
    return EdgeInsets.only(
      right: value,
      bottom: value,
      left: value,
    );
  }
}
