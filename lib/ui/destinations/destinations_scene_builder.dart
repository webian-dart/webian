import 'package:flutter/widgets.dart';
import 'package:webian/navigation/destinations/destination.dart';

abstract class DestinationsSceneBuilder {
  Destination get initialDestination;

  Destination get defaultDestination;

  /// Produces a widget to be wrapped in the default MaterialPageRoute
  ///
  final Map<String, WidgetBuilder> toWrapRoutesBuilders;

  /// Map to Widgets that extend the MaterialPageRoute
  ///
  final Map<String, Function> customPagesRouteBuilders;

  DestinationsSceneBuilder(
      {required this.toWrapRoutesBuilders,
      required this.customPagesRouteBuilders});
}
