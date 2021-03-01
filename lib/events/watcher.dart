import 'dart:async';

import 'package:rxdart/subjects.dart';

import 'event.dart';

class Watcher<T extends Event> {
    
    Function onEventAction = (T event){};
    Function onErrorAction = (object){};
    Function onDoneAction = (){};
    bool _cancelOnError = true;
    StreamSubscription<Event> _subscription;
    
    Watcher();
    
    watch(PublishSubject<Event> subject) {
        _subscription = subject.where((event) => event is T).listen(onEvent,
            onError: onError,
            onDone: onDone,
            cancelOnError: _cancelOnError
        );
    }
    
    stop() {
        _subscription?.cancel();
        _subscription = null;
    }
    
    onEvent(T data) => onEventAction(data);
    onDone() => onDoneAction();
    onError(Object error) => onErrorAction(error);
}
