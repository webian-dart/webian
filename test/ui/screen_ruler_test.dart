import 'package:dart_extras/dart_extras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:webian/ui/screen_ruler.dart';

import '../mocks/mock_media_query_data.dart';

final List<Couple<double, double>> _defaultTestCases = <Couple<double, double>>[
  Couple(.01, 1),
  Couple(.1, 10),
  Couple(.27, 27),
  Couple(.33, 33),
  Couple(.5, 50),
  Couple(.66, 66),
  Couple(.80, 80),
  Couple(.999, 99.9),
  Couple(.9999, 99.99),
  Couple(1, 100)
];

void main() {
  MockMediaQueryData _mediaQueryData;
  ScreenRuler _screenRuler;

  setUp(() {
    _mediaQueryData = MockMediaQueryData();
    _screenRuler = ScreenRuler(_mediaQueryData);
  });

  group("Screen Ruler should", () {
    test("is portrait but not landscape", () {
      when(_mediaQueryData.orientation).thenReturn(Orientation.portrait);
      expect(_screenRuler.isInPortrait, true);
      expect(_screenRuler.isInLandscape, false);
    });

    test("is landscape but not portrait", () {
      when(_mediaQueryData.orientation).thenReturn(Orientation.landscape);
      expect(_screenRuler.isInPortrait, false);
      expect(_screenRuler.isInLandscape, true);
    });

    test("give us the width size when in portrait because it the smallest", () {
      when(_mediaQueryData.size).thenReturn(Size(123, 321));
      when(_mediaQueryData.orientation).thenReturn(Orientation.portrait);
      expect(_screenRuler.smallestAxisSize(), 123);
    });

    test("give us the height size when in landscape because it the smallest",
        () {
      when(_mediaQueryData.size).thenReturn(Size(99, 800));
      when(_mediaQueryData.orientation).thenReturn(Orientation.landscape);
      expect(_screenRuler.smallestAxisSize(), 800);
    });

    test(
        "give us the width size minus the padding when in portrait "
        "because it the smallest", () {
      when(_mediaQueryData.size).thenReturn(Size(1000, 800));
      when(_mediaQueryData.orientation).thenReturn(Orientation.portrait);
      expect(
          _screenRuler.smallestAxisSizePadded(
              heightPadding: 111, widthPadding: 300),
          700);
    });

    test(
        "give us the height size minus the padding when in landscape "
        "because it the smallest", () {
      when(_mediaQueryData.size).thenReturn(Size(1800, 800));
      when(_mediaQueryData.orientation).thenReturn(Orientation.landscape);
      expect(
          _screenRuler.smallestAxisSizePadded(
              heightPadding: 111, widthPadding: 300),
          689);
    });

    test("give us half the screen height", () {
      when(_mediaQueryData.size).thenReturn(Size(0, 800));
      expect(_screenRuler.halfHeight(), 400);
    });

    test("give us half the screen width", () {
      when(_mediaQueryData.size).thenReturn(Size(700, 0));
      expect(_screenRuler.halfWidth(), 350);
    });

    test("give us the quarter of the screen height", () {
      when(_mediaQueryData.size).thenReturn(Size(0, 800));
      expect(_screenRuler.quarterHeight(), 200);
    });

    test("give us the quarter of the screen width", () {
      when(_mediaQueryData.size).thenReturn(Size(200, 0));
      expect(_screenRuler.quarterWidth(), 50);
    });

    test("give us a percentage of the screen height", () {
      when(_mediaQueryData.size).thenReturn(Size(0, 100));
      var count = _defaultTestCases.length;
      _defaultTestCases.forEach((element) {
        expect(_screenRuler.heightPc(element.first), element.second);
        count--;
      });
      expect(count, 0);
    });

    test(
        "give us a the minimum provided value when height percentage "
        "result value is less than minimum", () {
      when(_mediaQueryData.size).thenReturn(Size(0, 100));
      final cases = <Couple<double, double>>[
        Couple(.01, 50),
        Couple(.1, 50),
        Couple(.27, 50),
        Couple(.33, 50),
        Couple(.5, 50),
        Couple(.66, 66),
        Couple(.80, 80),
        Couple(.999, 99.9),
        Couple(.9999, 99.99),
        Couple(1, 100)
      ];
      var count = cases.length;
      cases.forEach((element) {
        expect(_screenRuler.heightPc(element.first, min: 50), element.second);
        count--;
      });
      expect(count, 0);
    });

    test(
        "give us a the maximum provided value when height percentage "
        "result value is more than it maximum", () {
      when(_mediaQueryData.size).thenReturn(Size(0, 100));
      final cases = <Couple<double, double>>[
        Couple(.01, 1),
        Couple(.1, 10),
        Couple(.27, 27),
        Couple(.33, 33),
        Couple(.5, 50),
        Couple(.66, 65),
        Couple(.80, 65),
        Couple(.999, 65),
        Couple(.9999, 65),
        Couple(1, 65)
      ];
      var count = cases.length;
      cases.forEach((element) {
        expect(_screenRuler.heightPc(element.first, max: 65), element.second);
        count--;
      });
      expect(count, 0);
    });

    test("give us the max when the min is greater than", () {
      when(_mediaQueryData.size).thenReturn(Size(0, 100));
      final cases = <Couple<double, double>>[
        Couple(.01, 50),
        Couple(.1, 50),
        Couple(.27, 50),
        Couple(.33, 50),
        Couple(.5, 50),
        Couple(.66, 50),
        Couple(.80, 50),
        Couple(.999, 50),
        Couple(.9999, 50),
        Couple(1, 50)
      ];
      var count = cases.length;
      cases.forEach((element) {
        expect(_screenRuler.heightPc(element.first, min: 51, max: 50),
            element.second);
        count--;
      });
      expect(count, 0);
    });

    test("give us a percentage of the screen width", () {
      when(_mediaQueryData.size).thenReturn(Size(100, 0));
      var count = _defaultTestCases.length;
      _defaultTestCases.forEach((element) {
        expect(_screenRuler.widthPc(element.first), element.second);
        count--;
      });
      expect(count, 0);
    });

    test("give us a percentage of the screen width", () {
      when(_mediaQueryData.size).thenReturn(Size(100, 0));
      final cases = <Couple<double, double>>[
        Couple(.01, 10),
        Couple(.1, 10),
        Couple(.27, 27),
        Couple(.33, 33),
        Couple(.5, 50),
        Couple(.66, 66),
        Couple(.80, 80),
        Couple(.999, 90),
        Couple(.9999, 90),
        Couple(1, 90)
      ];
      var count = cases.length;
      cases.forEach((element) {
        expect(_screenRuler.widthPc(element.first, min: 10, max: 90),
            element.second);
        count--;
      });
      expect(count, 0);
    });

    test(
        "give us a the minimum provided value when width percentage "
        "result value is less than minimum", () {
      when(_mediaQueryData.size).thenReturn(Size(100, 0));
      final cases = <Couple<double, double>>[
        Couple(.01, 50),
        Couple(.1, 50),
        Couple(.27, 50),
        Couple(.33, 50),
        Couple(.5, 50),
        Couple(.66, 66),
        Couple(.80, 80),
        Couple(.999, 99.9),
        Couple(.9999, 99.99),
        Couple(1, 100)
      ];
      var count = cases.length;
      cases.forEach((element) {
        expect(_screenRuler.widthPc(element.first, min: 50), element.second);
        count--;
      });
      expect(count, 0);
    });

    test(
        "give us a the maximum provided value when width percentage "
        "result value is more than it maximum", () {
      when(_mediaQueryData.size).thenReturn(Size(100, 0));
      final cases = <Couple<double, double>>[
        Couple(.01, 1),
        Couple(.1, 10),
        Couple(.27, 27),
        Couple(.33, 33),
        Couple(.5, 50),
        Couple(.66, 65),
        Couple(.80, 65),
        Couple(.999, 65),
        Couple(.9999, 65),
        Couple(1, 65)
      ];
      var count = cases.length;
      cases.forEach((element) {
        expect(_screenRuler.widthPc(element.first, max: 65), element.second);
        count--;
      });
      expect(count, 0);
    });

    test("give us the max for width when the min is greater than", () {
      when(_mediaQueryData.size).thenReturn(Size(100, 0));
      final cases = <Couple<double, double>>[
        Couple(.01, 50),
        Couple(.1, 50),
        Couple(.27, 50),
        Couple(.33, 50),
        Couple(.5, 50),
        Couple(.66, 50),
        Couple(.80, 50),
        Couple(.999, 50),
        Couple(.9999, 50),
        Couple(1, 50)
      ];
      var count = cases.length;
      cases.forEach((element) {
        expect(_screenRuler.widthPc(element.first, min: 51, max: 50),
            element.second);
        count--;
      });
      expect(count, 0);
    });

    test("give us the smallest in list", () {
      expect(<double>[10, 100, 1000, 2].smallest(), 2);
    });

    test("give us the highest in list", () {
      expect(<double>[10, 100, 12345, 2].greatest(), 12345);
    });

    test("give us as percentage of the smallest axis", () {
      <Orientation>[Orientation.landscape, Orientation.portrait]
          .forEach((orientation) {
        when(_mediaQueryData.orientation).thenReturn(orientation);
        var size = orientation == Orientation.portrait
            ? Size(100, 400)
            : Size(400, 100);
        when(_mediaQueryData.size).thenReturn(size);
        var count = _defaultTestCases.length;
        _defaultTestCases.forEach((element) {
          expect(_screenRuler.smallestAxisPc(percentage: element.first),
              element.second);
          count--;
        });
        expect(count, 0);
      });
    });

    test("give us as percentage of the greatest axis", () {
      <Orientation>[Orientation.landscape, Orientation.portrait]
          .forEach((orientation) {
        when(_mediaQueryData.orientation).thenReturn(orientation);
        var size =
            orientation == Orientation.portrait ? Size(40, 100) : Size(100, 40);
        when(_mediaQueryData.size).thenReturn(size);
        var count = _defaultTestCases.length;
        _defaultTestCases.forEach((element) {
          expect(_screenRuler.greatestAxisPc(percentage: element.first),
              element.second);
          count--;
        });
        expect(count, 0);
      });
    });

    test("give us the size of the greatest axis", () {
      <Orientation>[Orientation.landscape, Orientation.portrait]
          .forEach((orientation) {
        when(_mediaQueryData.orientation).thenReturn(orientation);
        var size =
            orientation == Orientation.portrait ? Size(40, 100) : Size(100, 40);
        when(_mediaQueryData.size).thenReturn(size);
        expect(_screenRuler.greatestAxisSize(), 100);
      });
    });

    test("give us the width percentage per orientation", () {
      <Orientation>[Orientation.landscape, Orientation.portrait]
          .forEach((orientation) {
        when(_mediaQueryData.orientation).thenReturn(orientation);
        var size =
            orientation == Orientation.portrait ? Size(40, 100) : Size(100, 40);
        when(_mediaQueryData.size).thenReturn(size);
        final result = _screenRuler.widthPcForOrientation(
          portrait: .5,
          landscape: .25,
        );
        if (orientation == Orientation.portrait) {
          expect(result, 20);
        } else {
          expect(result, 25);
        }
      });
    });

    test("give us the height percentage per orientation", () {
      <Orientation>[Orientation.landscape, Orientation.portrait]
          .forEach((orientation) {
        when(_mediaQueryData.orientation).thenReturn(orientation);
        var size =
            orientation == Orientation.portrait ? Size(40, 100) : Size(100, 40);
        when(_mediaQueryData.size).thenReturn(size);
        final result = _screenRuler.heightPcForOrientation(
          portrait: .5,
          landscape: .25,
        );
        if (orientation == Orientation.portrait) {
          expect(result, 50);
        } else {
          expect(result, 10);
        }
      });
    });
  });
}
