
import '../message.dart';

class AlertMessage extends Message {
  
  static const Symbol SYMBOL = const Symbol("alert_message");

  AlertMessage({String text, String title, Presentation presentation, Resolution resolution})
      : super(SYMBOL, body: text, title: title, presentation: presentation, resolution: resolution);
  
  @override
  Message clone({Presentation presentation, Resolution resolution}) {
    return AlertMessage(
        text: this.body,
        title: this.title,
        presentation: presentation,
        resolution: resolution
    );
  }
}
