# webian

##A Architectural Framework for Flutter

### Components:


  #### **Activity**
 
  An Activity (here nothing to do with Android) corresponds to a User Story or a 
  \ collection of Use Cases. For example, a Login Activity, or Registration Activity 
   \ are examples of this. In order to Login there might several Use Cases and tasks
    \ that need to happen. However, important to note that Activities have no visual
     \ representation, they are not UI components, but rather Business Layer features.

  #### **Interactor** -> Provide means to the client send messages to the application and for the client to get the result of these.

  #### **Stores** -> They are State managers.

 State -> They are observable, which allows the client to be notified and have access to the application state.

 Interactions -> They are predefined events that the application recognizes.


## Flutter Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).
