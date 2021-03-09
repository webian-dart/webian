import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:dart_extras/dart_extras.dart';

import 'color_shade.dart';

extension ColorExtension on Color {
  Color applyHue(double newHueValue) =>
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
  List<Color> getDarkShades([ColorShade minShade = ColorShades.fifthLightest]) {
    
    final MaterialColor materialColor =
        this is MaterialColor ? this as MaterialColor : this.getMaterialColor();
    
    final darkShades = <Color>[];

    for (final shade in ColorShades.shades) {
      if (shade.value < minShade.value) continue;

      final colorShade = materialColor[shade.value];
      if (colorShade?.estimateBrightnessForColor() == Brightness.dark) {
        darkShades.add(colorShade!);
      }
    }

    return darkShades.length > 0
        ? darkShades
        : materialColor[ColorShades.darkest.value].either((it) => [it], () => []);
  }

  MaterialColor getMaterialColor() {
    return Colors.primaries.firstWhere(
      (c) => c.value == this.value,
      orElse: () => MaterialColor(
        this.value,
        <int, Color>{
          ColorShades.lightest.value: this,
          ColorShades.secondLightest.value: this,
          ColorShades.thirdLightest.value: this,
          ColorShades.fourthLightest.value: this,
          ColorShades.fifthLightest.value: this,
          ColorShades.normal.value: this,
          ColorShades.fourthDarkest.value: this,
          ColorShades.thirdDarkest.value: this,
          ColorShades.secondDarkest.value: this,
          ColorShades.darkest.value: this,
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
