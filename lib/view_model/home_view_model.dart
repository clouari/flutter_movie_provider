import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_provider/model/movie.dart';

class HomeViewModel with ChangeNotifier {
  List<Movie> movies = []; // Movie? _movies;
  Timer? _debounce;

  final _api;

  HomeViewModel(this._api);

  Future<void> fetchMovies(String query) async {
    movies = await _api.fetchMovies(query);
    notifyListeners();
  }

  Future<void> searchWithQuery(String query) async {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final fetchedMovies = await _api.fetchMovies(query);
      movies =
          fetchedMovies.where((movie) => movie.title.contains(query)).toList();

      notifyListeners();
    });
  }
}
