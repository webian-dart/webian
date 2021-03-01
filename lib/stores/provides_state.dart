
import 'package:flutter/cupertino.dart';

abstract class ProvidesState<T> extends Listenable {
    T get state;
}

