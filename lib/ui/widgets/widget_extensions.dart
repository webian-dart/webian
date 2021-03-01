import 'package:flutter/widgets.dart';

extension WidgetExtensions on Widget {
  static Size getWidgetSize(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject();
    return renderBox?.size;
  }
}
