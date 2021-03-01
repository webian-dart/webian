import 'old_interactor.dart';

/// A Scene is a type of Interactor that supplies
/// its clients with state which is useful for
/// User Interfaces
abstract class Scene<T> extends OldInteractor {
  Scene();
  T data();
}
