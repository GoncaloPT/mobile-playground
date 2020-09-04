import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer/randomwords.dart';

void main() => runApp(StartupNamer());

class StartupNamer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup name generator',
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        home: RandomWords()
    );
  }
}



