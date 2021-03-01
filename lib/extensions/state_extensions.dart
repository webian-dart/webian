
import 'package:flutter/widgets.dart';

extension StateExtensions on State {

    postFirstBuild(Function action) {
        WidgetsBinding.instance.addPostFrameCallback((_){
            action();
        });
    }
}