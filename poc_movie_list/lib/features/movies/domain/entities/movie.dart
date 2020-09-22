class Movie {
  final int id;
  final String title;
  final String releaseYear;
  final Uri posterUrl;
  Movie(this.id, this.title, this.releaseYear, this.posterUrl);

  @override
  bool operator ==(Object other) => identical(this, other) ||
  other is Movie &&
  title == other.title;

  @override
  int get hashCode => title.hashCode;

  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      json['id'],
      json['Title'],
      json['Year'],
      Uri.parse(json['Poster'])
    );
  }
}
