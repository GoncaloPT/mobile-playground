import 'package:flutter/material.dart';
import 'package:poc_movie_list/features/movies/domain/entities/movie.dart';

/// This reusable widget purpose is to create a ListView for showing Movies
class MovieListWidget {
  final BuildContext _context;

  MovieListWidget(this._context);

  var _movies = <Movie>[];

  Widget buildMovieList(Set<Movie> elements,
      {Function(int) favoriteTapCallback,
      String emptyListMessage = "No data"}) {
    if (elements == null || elements.length < 1) {
      return _buildEmptyListWidget(emptyListMessage);
    }
    return _buildMovieList(elements, favoriteTapCallback: favoriteTapCallback);
  }

  Widget _buildRow(int index, Function favoriteTapCallback) {
    Movie movie = _movies[index];
    IconData icon = Icons.favorite;
    Color iconColor = Theme.of(_context).accentColor;
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(movie.posterUrl.toString()),
          radius: 31,
        ),
        title: Text(movie.title),
        subtitle: Text(movie.releaseYear),

        /// only show trailing fav button when a callback is defined
        trailing: favoriteTapCallback == null
            ? null
            : Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                IconButton(
                  icon: Icon(
                    icon,
                    color: iconColor,
                  ),
                  onPressed: () {
                    favoriteTapCallback(index);
                  },
                )
              ]));
  }

  ListView _buildMovieList(Set<Movie> elements,
      {Function(int p1) favoriteTapCallback}) {
    _movies.clear();
    if (elements != null) _movies.addAll(elements);
    return ListView.separated(
      itemCount: _movies.length,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildRow(i, favoriteTapCallback);
      },
      separatorBuilder: (context, index) => Divider(height: 20),
    );
  }

  Widget _buildEmptyListWidget(String emptyListMessage) {
    return Center(
        child: Text(
      emptyListMessage,
      style: TextStyle(
        fontSize: 26,
        color: Theme.of(_context).accentColor,
      ),
    ));
  }
}
