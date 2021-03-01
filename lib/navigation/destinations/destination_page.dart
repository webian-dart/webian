import 'package:flutter/material.dart';
import 'package:webian/navigation/destinations/destination.dart';

abstract class DestinationPage extends MaterialPage {
  final Destination destination;
  final List<Destination> altDestinations;
  final allowMultipleInstance;
  final removeOnLeaving;

  DestinationPage({
    @required Destination destination,
    @required Widget child,
    bool allowMultipleInstances,
    List<Destination> altDestinations,
    bool removeOnLeaving,
    bool maintainState,
    bool fullscreenDialog,
    LocalKey key,
    Object arguments,
  })  : assert(destination.isToSomewhere),
        this.destination = destination,
        this.altDestinations = altDestinations != null
            ? _validAltDestinations(destination, altDestinations)
            : [],
        this.allowMultipleInstance = allowMultipleInstances ?? false,
        this.removeOnLeaving = removeOnLeaving ?? false,
        super(
            child: child,
            name: destination.uri.path,
            maintainState: maintainState ?? true,
            fullscreenDialog: fullscreenDialog ?? false,
            key: key,
            arguments: arguments);

  static List<Destination> _validAltDestinations(
          Destination mainDestination, List<Destination> altDestinations) =>
      altDestinations
        ..where((it) => _isValidAltDestination(mainDestination, it)).toList();

  static bool _isValidAltDestination(
          Destination mainDestination, Destination alt) =>
      alt != null && alt != mainDestination && alt.isToSomewhere;
}
