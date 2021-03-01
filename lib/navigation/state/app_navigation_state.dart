import 'package:dart_extras/dart_extras.dart';
import 'package:webian/navigation/destinations/destination.dart';

abstract class AppNavigationState implements Cloneable {
  final List<Destination> destinationsStack;
  Destination get currentDestination => destinationsStack.last;

  AppNavigationState({List<Destination> destinations, List<Fault> faults})
      : assert(destinations.isNotEmpty),
        this.destinationsStack = destinations;

  @override
  clone({List<Destination> destinations});
}
