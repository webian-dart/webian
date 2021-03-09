import 'package:dart_extras/dart_extras.dart';
import 'package:webian/messages/message.dart';

class MessagingState extends Cloneable {
  Message alert;
  List<Message> messages;

  MessagingState({Message? alert, List<Message>? messages})
      : this.alert = alert ?? Message.empty,
        this.messages = messages?.toList() ?? <Message>[];

  @override
  MessagingState clone(
      {Message? alert,
      Message? remove,
      List<Message>? removeAll,
      Message? add,
      List<Message>? addAll}) {
    final newList = _addAll(add, addAll);
    final cleanedList = _removeAll(newList, remove, removeAll);
    return MessagingState(alert: alert ?? this.alert, messages: cleanedList);
  }

  List<Message> _addAll(Message? message, List<Message>? newMessages) {
    final List<Message> newList = List.from(messages);
    if (newMessages != null) newList.addAll(newMessages);
    if (message != null) newList.add(message);
    return newList;
  }

  List<Message> _removeAll(
      List<Message?> list, Message? message, List<Message>? toRemoveList) {
    final List<Message> newList = list.noNulls();
      if (message != null) toRemoveList?.add(message);
      newList.removeWhere((element) =>
          toRemoveList?.firstWhere((e) => element.key == e.key) != null);
    return newList;
  }
}
