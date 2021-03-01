import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../activities/activity.dart';
import '../events/event.dart';
import '../services/services.dart';
import '../stores/stores.dart';
import 'old_interactor.dart';

abstract class Application {
  final OldInteractor interactor;
  final Stores stores;
  final PublishSubject<Event> channel;
  final Services services;

  Application(
      {@required OldInteractor interactor,
      @required Stores stores,
      @required PublishSubject<Event> channel,
      @required Services services})
      : this.interactor = interactor,
        this.stores = stores,
        this.channel = channel,
        this.services = services;

  close() {
    interactor.dispose();
    channel.close();
  }

  done(Activity activity);
}
