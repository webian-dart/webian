import 'dart:core';

class Destination {
  static const APP_SCHEME = "app";
  static const START_PATH = "/start";
  static const HOME_PATH = "/home";

  static final Destination nowhere = Destination(Uri());

  final Uri uri;

  const Destination(this.uri);

  factory Destination.make(String host, String path, {String fragment}) =>
      Destination(Uri(
        scheme: APP_SCHEME,
        host: host,
        path: path,
        fragment: fragment,
      ));

  bool get isNowhere => this == nowhere;
  bool get isToSomewhere => !isNowhere;
  bool get isStartDestination => this.uri.path == START_PATH;
  bool get isHomeDestination => this.uri.path == HOME_PATH;

  @override
  String toString() {
    return "Destination.uri = $uri";
  }
}
