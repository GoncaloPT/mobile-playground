import 'package:flutter/material.dart';
import 'package:poc_movie_list/injection.dart';
import 'features/movies/presentation/widgets/main_tab_bar.dart';

void main() {
  configureInjection(Environments.DEVELOPMENT);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POC - Movie search',
      //theme: Theme,
      home: getIt<MainTabBar>()
    );
  }
}
