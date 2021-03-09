import 'package:flutter/widgets.dart';
import 'package:dart_extras/dart_extras.dart';

extension WidgetExtensions on Widget {
  static Size getWidgetSize(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext
        ?.findRenderObject()
        ?.let<RenderBox?>((it) => it is RenderBox ? it : null);
    return renderBox?.size ?? Size.zero;
  }
}
