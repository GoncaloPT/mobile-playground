import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppBarFactory {
  //default value
  final String _title = "Movie App";
  final Set<Widget> _actions= {};
  AppBarFactory();

  /// Allows clients to add a action to the app bar
  void action(Widget action){
    _actions.add(action);
  }
  /// Allows clients to add actions to the app bar
  void actions(List<Widget> actions){
    _actions.addAll(actions);

  }

  /// Builds a new AppBar
  AppBar build({Widget title}) {
    var appBar=  AppBar(
      title: title != null ? title : Text(_title),
      actions: _actions.toList()
    );
    //massive workaround, this must change.
    // The problem is that factory is kept alive inside widgets
    _actions.removeWhere((element) => true);
    return appBar;
  }


}
