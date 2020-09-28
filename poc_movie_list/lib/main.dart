import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'injection.dart';


void main() {
  configureInjection(Environments.development);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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