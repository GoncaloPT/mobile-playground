import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:poc_movie_list/features/movies/domain/entities/movie.dart';
import 'package:poc_movie_list/features/movies/domain/services/movie_service.dart';
import 'package:poc_movie_list/features/movies/presentation/widgets/movie_list_widget.dart';
import 'package:poc_movie_list/utils/app-bar.dart';
import 'dart:developer' as developer;

@injectable
class MovieSearch extends StatefulWidget {
  final MovieService _service;
  final AppBarFactory _appBarFactory;

  MovieSearch(this._service, this._appBarFactory);

  @override
  _MovieSearchState createState() =>
      _MovieSearchState(_service, _appBarFactory);

  ///https://www.youtube.com/watch?v=FDNitOxpUks&ab_channel=DesiProgrammer
  ///http://www.omdbapi.com/

}

class _MovieSearchState extends State<MovieSearch> {
  final MovieService _service;
  final AppBarFactory _appBarFactory;
  Future<Set<Movie>> searchFutureResult;

  Widget searchBar = Text("Search Movie");
  Icon searchIcon = Icon(Icons.search);

  _MovieSearchState(this._service, this._appBarFactory);

  @override
  void initState() {
    super.initState();
    searchFutureResult = Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarFactory.actions(<Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  if (searchIcon.icon == Icons.search) {
                    // Do search
                    searchIcon = Icon(Icons.cancel,);
                    searchBar = TextField(
                      textInputAction: TextInputAction.go,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 17),
                          hintText: "Search a movie"),
                      onSubmitted: (String value) {
                        setState(() {
                          searchFutureResult =
                              _service.searchMovies(title: value);
                        });
                      },
                    );
                  } else {
                    searchIcon = Icon(Icons.search);
                    searchBar = Text("Search Movie");
                    searchFutureResult = Future.value();
                  }
                });
              },
              icon: searchIcon),
        ]).build(title: searchBar),
        body: FutureBuilder<Set<Movie>>(
                future: searchFutureResult,
                builder: (ctx, snapshot) {
                  return MovieListWidget(ctx).buildMovieList(snapshot.data,
                      emptyListMessage: "Search for movies",
                      favoriteTapCallback: (index) => {
                            setState(() {
                              final movie = snapshot.data.elementAt(index);
                              if (_service.addFavorite(movie)) {
                                Scaffold.of(ctx).showSnackBar(SnackBar(
                                  duration: Duration(milliseconds: 2000),
                                  backgroundColor: Theme.of(ctx).primaryColor,
                                  content: Text(
                                    movie.title + " added as favorite",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ));
                              }
                            })
                          });
                }));
  }


}
