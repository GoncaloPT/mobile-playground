import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer/favorite_names_list.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

/// _ means that the class is only visible inside this library
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

  /// build method for the widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('startup name generator'),
          actions: [
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildSuggestions()
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Saved ones!')
          ),
          body: FavoriteNamesList(_saved))
        )
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index >= _suggestions.length) {
        //_suggestions.add(WordPair('generated', '!!!!!'));
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
          pair.asPascalCase,
          style: _biggerFont
      ),
      trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red: null
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }


}