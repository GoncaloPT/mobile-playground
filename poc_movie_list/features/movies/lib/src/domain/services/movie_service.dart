import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../entities/movie.dart';

@immutable
@singleton
class MovieService {


  static final Set<Movie> _favorites = {

  };


  Future<Set<Movie>> getFavorites() async {
    return _favorites;
  }


  bool addFavorite(Movie favorite) {

    return _favorites.add(favorite);
  }

  bool isFavorite(Movie movie) {
    return _favorites.contains(movie);
  }

  void removeFavorite(Movie movie) {
    _favorites.remove(movie);
  }

  Future<Set<Movie>> searchMovies({String title}) async {
    var uri =
        Uri.http('www.omdbapi.com', '/', {"apiKey": "f4cb0232", "s": title});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      log("response was:${response.body}");
      return Set<Movie>.from(json
          .decode(response.body)['Search']
          .map((data) => Movie.fromJson(data))
          .toList());
    } else {
      throw Exception('Movie search failed, response ${response.statusCode}');
    }
  }
}
