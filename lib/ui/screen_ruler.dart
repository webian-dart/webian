import 'dart:math';

import 'package:flutter/widgets.dart';

class ScreenRuler {
  static of(BuildContext context) => ScreenRuler(MediaQuery.of(context));

  MediaQueryData _mediaQueryData;

  ScreenRuler(this._mediaQueryData);

  EdgeInsets get padding => _mediaQueryData.padding;

  bool get isInPortrait => _mediaQueryData.orientation == Orientation.portrait;

  bool get isInLandscape =>
      _mediaQueryData.orientation == Orientation.landscape;

  double smallestAxisSizePadded(
          {double heightPadding = 0, double widthPadding = 0}) =>
      isInPortrait ? width() - widthPadding : height() - heightPadding;

  double width() => _mediaQueryData.size.width;

  double height() => _mediaQueryData.size.height;

  double smallestAxisSize() => isInPortrait ? width() : height();

  double smallestAxisPc({double percentage = 100}) =>
      isInPortrait ? widthPc(percentage) : heightPc(percentage);

  double greatestAxisSize() => isInPortrait ? height() : width();

  double greatestAxisPc({double percentage = 100}) =>
      isInPortrait ? heightPc(percentage) : widthPc(percentage);

  double widthPcForOrientation(
      {double portrait = 100, double landscape = 100}) {
    if (isInPortrait) return widthPc(portrait);
    return widthPc(landscape);
  }

  double heightPcForOrientation(
      {double portrait = 100, double landscape = 100}) {
    if (isInPortrait) return heightPc(portrait);
    return heightPc(landscape);
  }

  double halfHeight() => height() / 2;

  double halfWidth() => width() / 2;

  double quarterWidth() => width() / 4;

  double quarterHeight() => height() / 4;

  double heightPc(double percentage, {double min = 0, double max = -1}) {
    return percentage.percentageOf(dimension: height(), min: min, max: max);
  }

  double widthPc(double percentage, {double min = 0, double max = -1}) {
    return percentage.percentageOf(dimension: width(), min: min, max: max);
  }
}

extension ScreenRulerDoubleExtensions on double {
  double percentageOf({double dimension, double min = 0, double max = -1}) {
    if (max != -1 && min > max) return max;
    if (dimension < 1) return 1;
    var pc = this < 1 && this > 0.0001 ? this : 1;
    var result = dimension * pc;
    if (result < min) {
      return min;
    } else if (max > 0 && result > max) {
      return max;
    } else {
      return result;
    }
  }
}

extension ScreenRulerListExtensions on List<double> {
  double greatest() => this.reduce(max);
  double smallest() => this.reduce(min);
}
