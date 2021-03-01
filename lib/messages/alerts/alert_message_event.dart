import 'package:webian/events/event.dart';
import 'package:webian/messages/alerts/alert_message.dart';

class AlertMessageEvent extends Event {
  static const Symbol SYMBOL = const Symbol("alert_message_event");
  final AlertMessage message;

  AlertMessageEvent(this.message) : super(SYMBOL);
}
