# webian

## An Architectural Framework for Flutter

This is a Flux and Clean Architecture inspired architecture.




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
      : initialization = Provider<InitializationState>((ref) {
          return ref.watch(Stores().initialization.state).clone();
        }),
        permissions = Provider<PermissionsState>((ref) {
          return ref.watch(Stores().permissions.state).clone();
        }),
        navigation = Provider<NavigationState>((ref) {
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

What is that? That is our Global factory or in Riverpod lingo: the provider.
(we recommend you check [Riverpod](https://pub.dev/packages/riverpod)
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
What is happening here? Our consumer widget has Scope, if initializationProvider already exists 
in that scope, then get me that instance, if not create, then us a new instance of the provider. So, in this way we 
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
  The Use Cases have access to the Stores and they interact with using its public interface. 
  For example, we could have singleton class where we keep all the references to our Stores using 
  [Riverpod](https://pub.dev/packages/riverpod). Again, access to these is restricted to the Business Layer.
  
  ```dart
  class Stores {
  final StateNotifierProvider<NavigationStore> navigation;
  final StateNotifierProvider<InitializationStore> initialization;
  final StateNotifierProvider<PermissionsStore> permissions;

  Stores._()
      :  navigation = StateNotifierProvider<NavigationStore>((ref) =>
            NavigationStore(initialState: NavigationState(destinations: [Destinations.start]))),
                
        permissions = StateNotifierProvider<PermissionsStore>(
            (ref) => PermissionsStore(initialState: PermissionsState())),
            
        initialization = StateNotifierProvider<InitializationStore>(
            (ref) => InitializationStore(initialState: InitializationState()));
       

  factory Stores() => _instance;

  static final Stores _instance = Stores._();
}

  ```
 
## App

```dart
class App implements ApplicationDriver, ApplicationInterfacer {
  Interactor _interactor;

  @override
  Interactor get interactor => _interactor;

  ProviderContainer _scope;
  @override
  ProviderContainer get scope => _scope;

  @override
  final PublishSubject<Event> appBus;
  @override
  final PublishSubject<Event> inputBus;

  //etc...
}
```

Our App implements two interfaces. The first is **ApplicationDriver**, this interface
is for the Business Layer. It is the reference that Activities and other components
of the app get, it provides the Application Business Layer context. Hence, you
will find the **appBus** (internal to business layer) and the inputBus how the core
the listens to events in the 'outside world'. Finally, provider is a [Riverpod](https://pub.dev/packages/riverpod)
component, it is the scope where all the Stores and States providers exist, it is like a Service Locator (please
see Stores and State above).

```dart
import 'package:flutter_riverpod/all.dart';
import 'package:mobiplay/events/event.dart';
import 'package:rxdart/rxdart.dart';

abstract class ApplicationDriver {
  PublishSubject<Event> get appBus;
  PublishSubject<Event> get inputBus;
  ProviderContainer get provider;
}

```

The other interface App implements is **ApplicationInterfacer**. 
This is the interface that will be made available to the outer layers;
like the UI layer. It has an **interactor** and **scope**. 

Now, the **scope** is the same as the **provider** on the **ApplicationDriver**.
At this point, you might think: oh wait! But you said the Store are accessible
through the **ProviderContainer**, does that mean the UI can access them? -
No, unless you made the reference to the Store provider available outside the core
package, you shouldn't do. Only that way you can reference them in scope to find them.

The **ProviderAllows** allows the rest of the app to have access to the app scope so that
it can get the different State usig the references (above in the **States** example they
were made accessible in the **States()** singleton.

The **Interactor** is just a wrapper for our inputBus. The Ui, for example, used
this to send events to the Business Layer; there different Activities handle events
as they see fit. Potentially, this causes subsequent State change that the UI listens to.
Say, the user wants to "sign out", the UI uses the Interactor to tell the Core.
Some Activity responsible for this, catches the event updates the app state and the UI
then updates when it sees those state changes; etc.

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'interactor.dart';

abstract class ApplicationInterfacer {
  Interactor get interactor;
  ProviderContainer get scope;
}
```

```dart
class Interactor {
  final PublishSubject<Event> _inputBus;

  Interactor([PublishSubject<Event>? inputBus]);

  emit(Event event);

  emitFor(Symbol symbol);

  StreamSubscription subscribe(Function(Event) onEvent);
  
  watch(Watcher<Event> watcher);
}
```

## Flutter Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).
