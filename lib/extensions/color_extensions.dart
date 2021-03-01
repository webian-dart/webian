import 'package:flutter/painting.dart';

extension ColorExtension on Color {
  Color applyhue(double newHueValue) =>
      HSLColor.fromColor(this).withHue(newHueValue).toColor();

  Color applySaturation(newSaturationValue) =>
      HSLColor.fromColor(this).withSaturation(newSaturationValue).toColor();

  Color applyLightness(newLightnessValue) =>
      HSLColor.fromColor(this).withLightness(newLightnessValue).toColor();
}
