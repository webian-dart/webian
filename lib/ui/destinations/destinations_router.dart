import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webian/ui/destinations/destinations_scene_builder.dart';

class DestinationsRouter {
  DestinationsSceneBuilder _sceneBuilder;

  DestinationsRouter(this._sceneBuilder);

  onGenerateRoute(RouteSettings settings) {
    if (_isACustomPageRoute(settings))
      return _getCustomPageRoute(settings);
    else
      return _getSceneToWrapInPageRoute(settings);
  }

  _getSceneToWrapInPageRoute(RouteSettings settings) {
    WidgetBuilder builder = _sceneBuilder.toWrapRoutesBuilders[settings.name] ??
        _sceneBuilder.toWrapRoutesBuilders[_sceneBuilder.defaultDestination] ??
        (BuildContext context) => Container();
    return MaterialPageRoute(settings: settings, builder: builder);
  }

  bool _isACustomPageRoute(RouteSettings settings) =>
      _sceneBuilder.customPagesRouteBuilders.containsKey(settings.name);

  _getCustomPageRoute(RouteSettings settings) =>
      _sceneBuilder.customPagesRouteBuilders[settings.name]?.call(settings);
}
