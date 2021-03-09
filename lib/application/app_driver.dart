import 'package:dart_extras/dart_extras.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';

/// ApplicationDriver is the Core Business Logic
/// main class. User this class on the Business Logic
/// and don't use this class on any other layer.
/// Instead, on the outer layers of the app use
/// ApplicationInterfacer. Why? Because this class
/// gives access to part of the app that should not be
/// accessible on any other layer. For example, the appBus
/// is used by the Core Business layer to pass messages among
/// different modules/activity/drivers on the Core layer.
abstract class ApplicationDriver {
  PublishSubject<Event> get appBus;
  PublishSubject<Event> get inputBus;
  ProviderContainer get scope;
  void close();
}
