import 'package:flutter/cupertino.dart';

/// DTO for movie class
@immutable
class Movie {

  /// Movie id
  final int id;
  /// Movie title
  final String title;
  /// Movie release year
  final String releaseYear;
  /// Uri for the thumbnail image
  final Uri posterUrl;
  /// Constructor for movie
  Movie(this.id, this.title, this.releaseYear, this.posterUrl);

  @override
  bool operator ==(Object other) => identical(this, other) ||
  other is Movie &&
  title == other.title;

  @override
  int get hashCode => title.hashCode;

  /// Builds movies from json. expects id, title, year and Poster fields
  factory Movie.fromJson(Map<String,Object> json){
    return Movie(
      json['id'],
      json['Title'],
      json['Year'],
      Uri.parse(json['Poster'])
    );
  }
}
