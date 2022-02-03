import 'dart:convert';

import 'package:flutter_movie_provider/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  Future<List<Movie>> fetchMovies(String query) async {
    String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=b55e255477dfd32ca8e25db4b225b076';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Movie.listToMovie(jsonDecode(response.body)['results']);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
