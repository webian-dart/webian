import 'package:dart_extras/dart_extras.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webian/events/event.dart';

abstract class ApplicationDriver {
  PublishSubject<Event> get appBus;
  PublishSubject<Event> get inputBus;
  ProviderContainer get scope;
  Future<Result> close();
}
