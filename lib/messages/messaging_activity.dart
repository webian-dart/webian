import 'package:webian/activities/activity.dart';
import 'package:webian/application/app_driver.dart';
import 'package:webian/events/watcher.dart';
import 'package:webian/messages/alerts/alert_message_event.dart';
import 'package:webian/messages/message.dart';
import 'package:webian/stores/application_store.dart';
import 'alerts/alert_message.dart';
import 'messaging_store.dart';

class MessagingActivity extends Activity {
  final MessagingStore messagingStore;
  final ApplicationStore appStore;

  MessagingActivity(
      {required ApplicationDriver app,
      required this.appStore,
      required this.messagingStore})
      : super(app);

  @override
  Future<void> start() {
    messagingStore.addListener(_checkForNewMessages);
    _startListeningToInteractions();
    return Future.value();
  }

  void _checkForNewMessages() {
//    final messages = messagingStore.state.messages;
//    if (messages.isEmpty) return;
//    final alert = messagingStore.state.alert;
//    if (alert.isNotEmpty)
//
  }

  void _startListeningToInteractions() {
    Watcher(onEvent: (AlertMessageEvent event) {
      final message = event.message;
      if (message.resolution == Resolution.DISMISSED) {
        _handleDismissedAlert(message);
      }
    });
  }

  void _handleDismissedAlert(AlertMessage alert) {
    messagingStore.clear(alert);
  }
}
