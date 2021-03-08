class ColorShade {
  final int value;
  const ColorShade(this.value);
}

class ColorShades {
  static const ColorShade lightest = const ColorShade(50);
  static const ColorShade secondLightest = const ColorShade(100);
  static const ColorShade thirdLightest = const ColorShade(200);
  static const ColorShade fourthLightest = const ColorShade(300);
  static const ColorShade fifthLightest = const ColorShade(400);
  static const ColorShade normal = const ColorShade(500);
  static const ColorShade fourthDarkest = const ColorShade(600);
  static const ColorShade thirdDarkest = const ColorShade(700);
  static const ColorShade secondDarkest = const ColorShade(800);
  static const ColorShade darkest = const ColorShade(900);

  static const List<ColorShade> shades = const [
    lightest,
    secondLightest,
    thirdDarkest,
    fourthLightest,
    fifthLightest,
    normal,
    fourthDarkest,
    thirdDarkest,
    secondDarkest,
    darkest
  ];
}
