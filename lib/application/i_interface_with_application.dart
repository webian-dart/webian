import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'interactor.dart';

abstract class IInterfaceWithApplication {
  Interactor get interactor;
  ProviderContainer get scope;
}
