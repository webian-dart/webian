import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlurryBackground extends StatelessWidget {
  static const _sigmaX = 5.0; // from 0-10
  static const _sigmaY = 5.0; // from 0-10
  static const _opacity = 0.5; // from 0-1.0
  final Widget? child;

  const BlurryBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
      child: Container(
        color: Colors.black26.withOpacity(_opacity),
        child: child,
      ),
    ));
  }
}
