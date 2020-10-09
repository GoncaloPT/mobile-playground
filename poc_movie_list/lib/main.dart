import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:movies/movies.dart';
import 'injection.dart';



void main() {
  // Logger
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: lines_longer_than_80_chars
    print('[${record.loggerName}] ${record.level.name}: '
        '${record.time}: ${record.message}');
  });


  configureInjection(Environments.development);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final _log = Logger('MyApp');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _log.info("build called");


    return MaterialApp(
      title: 'POC - Movie search',
      //theme: Theme,
      home: getIt<MainTabBar>(),
    );
  }
}

class JustATest{
  MoviesModule a;
}