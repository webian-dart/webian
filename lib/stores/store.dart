import 'package:dart_extras/dart_extras.dart';
import 'package:flutter/cupertino.dart';
import 'package:webian/stores/provides_state.dart';

abstract class Store<T extends Cloneable> extends ValueNotifier<T>
    implements ProvidesState<T> {
  static const noStoreSymbol = const Symbol("does_not_have_a_store");

  Store(T initialValue) : super(initialValue);

  @override
  T get state => value.clone();
}
