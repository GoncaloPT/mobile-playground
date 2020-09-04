import 'package:english_words/src/word_pair.dart';
import 'package:flutter/material.dart';
class FavoriteNamesList extends StatelessWidget {

  final _saved = <WordPair>[];
  FavoriteNamesList(Set<WordPair> saved){
    //should we clean?
    _saved.addAll(saved);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFavorites()
    );
  }
  Widget _buildFavorites(){
    final tiles =  _saved.map(
        (WordPair p){
          return _buildRow(p);
        }
    ).toList();
    return ListView(children: tiles);
  }

  Widget _buildRow(WordPair saved) {
    return ListTile(
      title: Text(
        saved.asPascalCase
      )
    );
  }


}
