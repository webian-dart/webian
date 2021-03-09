import 'package:flutter/material.dart';
import 'package:webian/navigation/destinations/destination.dart';

abstract class DestinationPage extends MaterialPage {
  final Destination destination;
  final List<Destination> altDestinations;
  final bool allowMultipleInstances;
  final bool removeOnLeaving;

  DestinationPage({
    this.allowMultipleInstances = false,
    this.removeOnLeaving = false,
    required Destination destination,
    required Widget child,
    List<Destination>? altDestinations,
    bool? maintainState,
    bool? fullscreenDialog,
    LocalKey? key,
    Object? arguments,
  })  : assert(destination.isToSomewhere),
        this.destination = destination,
        this.altDestinations = altDestinations != null
            ? _validAltDestinations(destination, altDestinations)
            : [],
        super(
            child: child,
            name: destination.uri.path,
            maintainState: maintainState ?? true,
            fullscreenDialog: fullscreenDialog ?? false,
            key: key,
            arguments: arguments);

  bool get isToNowhere => this is NowhereDestinationPage;

  static List<Destination> _validAltDestinations(
          Destination mainDestination, List<Destination> altDestinations) =>
      altDestinations
        ..where((it) => _isValidAltDestination(mainDestination, it)).toList();

  static bool _isValidAltDestination(
          Destination mainDestination, Destination? alt) =>
      alt != null && alt != mainDestination && alt.isToSomewhere;
}

class NowhereDestinationPage extends DestinationPage {
  NowhereDestinationPage() : super(
      child: Container(),
      destination: Destination.nowhere,
      maintainState: false,
      fullscreenDialog: false,
  );
}
