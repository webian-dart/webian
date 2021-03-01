import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webian/ui/screen_ruler.dart';

extension BuildContextScreenRullerExtensions on BuildContext {
  ScreenRuler get screenRuler => ScreenRuler.of(this);

  ThemeData get theme => Theme.of(this);

  void clearFocus() => FocusScope.of(this).requestFocus(FocusNode());
}
