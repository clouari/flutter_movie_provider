class Movie {
  final String title;
  final String overView;
  final String posterPath;
  final String? backdropPath;
  final String releaseDate;
  final num voteAverage;
  final int voteCount;

  String get posterUrl => 'https://image.tmdb.org/t/p/original' + posterPath;

  Movie({
    required this.title,
    required this.overView,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      overView: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  static List<Movie> listToMovie(List jsonList) {
    return jsonList.map((e) => Movie.fromJson(e)).toList();
  }
}
