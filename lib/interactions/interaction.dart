import 'package:webian/events/event.dart';

class Interaction extends Event {
  Interaction(Symbol tag, {dynamic data}) : super(tag, data: data);
}
