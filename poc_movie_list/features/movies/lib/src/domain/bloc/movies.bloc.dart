import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:movies/movies.dart';
import 'package:movies/src/domain/entities/movie.dart';
import 'package:poc_movie_list/bloc/bloc.dart';


@injectable
class MoviesBloc implements Bloc{
  final _streamController = StreamController<Iterable<Movie>>();
  final MovieService _movieService;
  MoviesBloc(this._movieService);

  Stream<Iterable<Movie>> get stream => _streamController.stream;

  @override
  void dispose() {
    _streamController.close();
  }
  /// Searches movies by title
  void search(String title) async{
    _streamController.sink.add(await _movieService.searchMovies(title: title));
  }

}