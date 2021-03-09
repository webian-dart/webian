# webian

##A Architectural Framework for Flutter

### Components:


  #### **Activity**
 
  An Activity (here nothing to do with Android) corresponds to a User Story or a 
  collection of Use Cases. For example, a Login Activity, or Registration Activity 
  are examples of this. In order to Login there might several Use Cases and tasks
  that need to happen. However, important to note that Activities have no visual
  representation, they are not UI components, but rather Business Layer features.

 #### **State**
 
 These are observable components, which allows the client to be notified and have access to the application state.
 
 ```dart
 class InitializationState implements Cloneable {
  final bool initialized;
  final Fault fault;

  InitializationState({this.initialized = false, Fault fault})
      : his.fault = fault ?? Fault.Empty;

  @override
  clone({bool initialized, Fault fault}) => InitializationState(
      initialized: initialized ?? this.initialized, fault: fault ?? this.fault);
  }

 ```
 A simple example of how we can achieve this using [Riverpod](https://pub.dev/packages/riverpod). Riverpod allows us to create 
 a global factory of factories that instantiate a new factry for a given scope/context. 
 It is a form of Dependency injection that avoid the Service Locator pattern issues.
 
 ```dart
class States {
  final Provider<InitializationState> initialization;
  final Provider<NavigationState> navigation;
  final Provider<PermissionsState> permissions;

  States._()
      : this.initialization = Provider<InitializationState>((ref) {
          return ref.watch(Stores().initialization.state).clone();
        }),
        this.permissions = Provider<PermissionsState>((ref) {
          return ref.watch(Stores().permissions.state).clone();
        }),
        this.navigation = Provider<NavigationState>((ref) {
          return ref.watch(Stores().navigation.state).clone();
        });

  factory States() => _instance;

  static final States _instance = States._();
}

```
The above class is exported from the Core package so that the UI can observer it. 
Now, in the example we put it inside of States() class. but the important bits are:

```dart
final initializationProvider = Provider<InitializationState>((ref) {
          return ref.watch(Stores().initialization.state).clone();
        });
```

What is that? That is our Global factory (we recommend you check 
[Riverpod](https://pub.dev/packages/riverpod), or in Riverpod lingo the provider.
For example:

```dart
class Example extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final count = watch(initializationProvider.state);
    return Text(count.toString());
  }
}
```
What is happening here? Our consure widget has Scope, if initializationProvider already exists 
in that scope, then get me that instance, if not create us a new instance. So, in this way we 
can have a global initializationState but we can also override it in nested scopes. In anyway,
we recommend you learn [Riverpod](https://pub.dev/packages/riverpod). 

  #### **Stores**
  
  These are State managers. As the Use Cases process inputs they produce alterations 
  to the app state. These changes go through a Store that offers an Interface to take 
  changes. The Store then applies these changes by producing a State object that other
  components can listen to. The Stores, like Activities are Business Layer components.
  Any part of an app with access to one can change the state of the app. 
  
  Stores can be used to implement a version of the Repository pattern. However, the approach
  here adopted is a bit different a Repository normally manipulates the data, might interact with
  external Services and they offer the data requeste to the other client component (UI, module, etc).
  Instead, here it is prefered that the Store concerns itself with acepting updates, ensuring that the
  state is consistent, and notifying indirectly of state changes.
  
  Using Riverpods providers, State is made available to other dart packages outside the Core package.
  State is a produce of listeneing to 
  
  ```dart
  class InitializationStore extends StateNotifier<InitializationState> {
    InitializationStore(InitializationState initialValue) : super(initialValue);

    set initialized(bool initialized) {
      state = state.clone(initialized: initialized);
    }

    set faulted(Fault fault) {
      state = state.clone(initialized: false, fault: fault);
    }
}

  ```

 Interactions -> They are predefined events that the application recognizes.


  #### **Interactor** -> Provide means to the client send messages to the application and for the client to get the result of these.

## Flutter Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).
