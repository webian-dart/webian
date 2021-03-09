import 'package:equatable/equatable.dart';

import 'event_data.dart';

class Event extends Equatable {
  static final Event empty = Event(Symbol('empty_event'));

  final Symbol symbol;
  final Data data;

  Event(this.symbol, {Data? data}) : this.data = data ?? Data.empty;

  @override
  List<Object> get props => [symbol];

  @override
  bool get stringify => true;
}
