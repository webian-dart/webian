import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Store<T> extends StateNotifier<T> {
  Store(T state) : super(state);
}
