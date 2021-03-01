import 'package:flutter/widgets.dart';

typedef RunAfterBuildCallbackOn(BuildContext context);
typedef RunAfterBuildCallback();
typedef RunAfterBuildCallbackWith<T>(T value);
typedef RunAfterBuildCallbackOnWith<T>(BuildContext context, T value);

class AfterBuild {
  static run(RunAfterBuildCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }

  static runOn(BuildContext context, RunAfterBuildCallbackOn callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback(context));
  }

  static runWith<T>(T value, RunAfterBuildCallbackWith callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback(value));
  }

  static runOnWith<T>(
      BuildContext context, T value, RunAfterBuildCallbackOnWith callback) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => callback(context, value));
  }
}
