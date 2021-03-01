import 'package:webian/messages/alerts/alert_message.dart';
import 'package:webian/messages/message.dart';
import 'package:webian/stores/store.dart';

import 'messaging_state.dart';

class MessagingStore extends Store<MessagingState> {
  static const Symbol symbol = const Symbol("messaging_store");

  MessagingStore() : super(MessagingState());

  set alertMessage(Message message) {
    value = value.clone(alert: message);
  }

  add(Message message) {
    value = value.clone(add: message);
  }

  remove(Message message) {
    value = value.clone(remove: message);
  }

  void clear(AlertMessage message) {
    alertMessage = Message.empty;
  }
}
