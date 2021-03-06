import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../domain/entities/movie.dart';
import '../../domain/services/movie_service.dart';
import '../widgets/movie_list_widget.dart';
import 'movie_search.dart';

@injectable
class FavoriteMovies extends StatefulWidget {
  final AppBarFactory _appBarFactory;
  final MovieService _movieService;
  final MovieSearch _movieSearchWidget;

  FavoriteMovies(
      this._appBarFactory, this._movieService, this._movieSearchWidget);



  @override
  State<StatefulWidget> createState() {
    return _FavoriteMoviesState(
        _appBarFactory, _movieService, _movieSearchWidget);
  }
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  final AppBarFactory _appBarFactory;
  final MovieService _movieService;
  final MovieSearch _movieSearchWidget;

  Future<Set<Movie>> futureMovies;

  _FavoriteMoviesState(
      this._appBarFactory, this._movieService, this._movieSearchWidget);

  @override
  void initState() {
    super.initState();
    futureMovies = _movieService.getFavorites();
  }

  @override
  void reassemble() {
    super.reassemble();
    futureMovies = _movieService.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarFactory.build(title: Text("Favorite Movies")),
      body: FutureBuilder<Set<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          return MovieListWidget(context).buildMovieList(snapshot.data,
              favoriteTapCallback: (index) => {
                    setState(() {
                      _movieService
                          .removeFavorite(snapshot.data.elementAt(index));
                    })
                  });
        },
      ),
 /*     floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () async => {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => _movieSearchWidget))
              .whenComplete(() => setState(() {
                    futureMovies = _movieService.getFavorites();
                  }))
        },
      ),*/
    );
  }
}
