import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:movies_app/model/movie_response.dart';
import 'package:movies_app/service/api.dart';

class MovieRepo {
  Future<List<Movie>?> getMovies(String category) async {
    dynamic response = await API().getMovies(category);

    try {
      if (response.statusCode == 200) {
        List<Movie>? movieList = [];
        if (response.data.containsKey('page')) {
          movieList = MovieResponse.fromJson(response.data).results;
        } else {
          movieList = [Movie.fromJson(response.data)];
        }
        return movieList;
      } else {
        return null;
      }
    } catch (exception, stackTrace) {
      if (!kReleaseMode) log(stackTrace.toString());
      return null;
    }
  }
}
