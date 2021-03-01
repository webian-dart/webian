import 'package:dart_extras/dart_extras.dart';
import 'package:flutter/cupertino.dart';

enum Presentation { PRESENTED, PENDING, UNKNOWN }

enum Resolution { RESOLVED, UNRESOLVED, DISMISSED, UNKNOWN }

class Message extends Cloneable {
  static const Symbol EMPTY_SYMBOL = const Symbol("empty_message");
  static final Message empty = Message(EMPTY_SYMBOL);

  final Symbol symbol;
  final String body;
  final String title;
  final Presentation presentation;
  final Resolution resolution;
  final UniqueKey key;

  Message(
    this.symbol, {
    String body,
    String title,
    Presentation presentation,
    Resolution resolution,
    UniqueKey uniqueKey,
  })  : this.body = body ?? "",
        this.title = title ?? "",
        this.presentation = presentation ?? Presentation.UNKNOWN,
        this.resolution = resolution ?? Resolution.UNKNOWN,
        this.key = uniqueKey ?? UniqueKey();

  @override
  Message clone({Presentation presentation, Resolution resolution}) =>
      Message(this.symbol,
          resolution: resolution ?? this.resolution,
          presentation: presentation ?? this.presentation,
          uniqueKey: key);

  bool get isEmpty => this == empty;

  bool get isNotEmpty => !isEmpty;
}

abstract class CallToAction extends Message {
  final List<CallToActionQuery<dynamic>> callToActionQueries;

  CallToAction(Symbol symbol, String body, Presentation presentation,
      Resolution resolution, this.callToActionQueries)
      : super(symbol);
}

class CallToActionQuery<T> {
  final Symbol symbol;
  final ResultOf<T> result;

  CallToActionQuery(this.symbol, {ResultOf<T> result})
      : result = result ?? ResultOf.empty(isPending: true);
}
