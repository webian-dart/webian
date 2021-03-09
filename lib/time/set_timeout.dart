
import 'dart:async';

class SetTimeout {
    Function _action;
    Duration _duration;
    Timer? _timer;
    SetTimeout(this._duration, this._action);
    
    run() async {
        _timer = Timer(_duration, _onTimeout);
    }
    
    _onTimeout() {
        _timer?.cancel();
        _action();
    }
}
