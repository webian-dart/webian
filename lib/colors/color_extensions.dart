import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'color_shade.dart';

extension ColorExtension on Color {
  Color applyhue(double newHueValue) =>
      HSLColor.fromColor(this).withHue(newHueValue).toColor();

  Color applySaturation(newSaturationValue) =>
      HSLColor.fromColor(this).withSaturation(newSaturationValue).toColor();

  Color applyLightness(newLightnessValue) =>
      HSLColor.fromColor(this).withLightness(newLightnessValue).toColor();

  /// Determines whether the given [Color] is [Brightness.light] or
  /// [Brightness.dark].
  /// Copied from [ThemeData.estimateBrightnessForColor(color)]
  /// change [kThreshold] from 0.15 to 0.45 to accept more color
  /// with [Brightness.dark]
  Brightness estimateBrightnessForColor() {
    final double relativeLuminance = this.computeLuminance();
    const double kThreshold = 0.45;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold)
      return Brightness.light;
    return Brightness.dark;
  }

  /// get the dark shades version of current color,
  List<Color> getDarkShades([ColorShade minShade = ColorShade.fifthLightest]) {
    final MaterialColor materialColor =
        this is MaterialColor ? this : this.getMaterialColor();
    final darkShades = <Color>[];

    for (final shade in shades.values) {
      if (shade < shades[minShade]) continue;

      final colorShade = materialColor[shade];
      if (colorShade.estimateBrightnessForColor() == Brightness.dark) {
        darkShades.add(colorShade);
      }
    }

    return darkShades.length > 0
        ? darkShades
        : [materialColor[shades[ColorShade.darkest]]];
  }

  MaterialColor getMaterialColor() {
    return Colors.primaries.firstWhere(
      (c) => c.value == this.value,
      orElse: () => MaterialColor(
        this.value,
        <int, Color>{
          shades[ColorShade.lightest]: this,
          shades[ColorShade.secondLightest]: this,
          shades[ColorShade.thirdLightest]: this,
          shades[ColorShade.fourthLightest]: this,
          shades[ColorShade.fifthLightest]: this,
          shades[ColorShade.normal]: this,
          shades[ColorShade.fourthDarkest]: this,
          shades[ColorShade.thirdDarkest]: this,
          shades[ColorShade.secondDarkest]: this,
          shades[ColorShade.darkest]: this,
        },
      ),
    );
  }

  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
