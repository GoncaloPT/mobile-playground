import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppBarFactory {
  //default value
  final String _title = "Movie App";
  final Set<Widget> _actions= new Set();
  AppBarFactory();

  /// Allows clients to add a action to the app bar
  AppBarFactory action(Widget action){
    _actions.add(action);
    return this;
  }
  /// Allows clients to add actions to the app bar
  AppBarFactory actions(List<Widget> actions){
    _actions.addAll(actions);
    return this;
  }


  AppBar build({Widget title}) {
    AppBar a=  AppBar(
      title: title != null ? title : Text(_title),
      actions: _actions.toList()
    );
    //massive workaround, this must change.
    // The problem is that factory is kept alive inside widgets
    _actions.removeWhere((element) => true);
    return a;
  }


}
