import 'dart:convert';

import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter/services.dart';

Future<List<TopRatedMovieEntity>> getTopRatedMoviesTest() async {
  final response =
      await rootBundle.loadString('test_data/movie_entity_test.json');
  final jsonList = await json.decode(response);

  final List<TopRatedMovieEntity> movieList = jsonList
      .map<TopRatedMovieEntity>(
        (json) => TopRatedMovieEntity.fromJson(json),
      )
      .toList();

  return Future.value(movieList);
}

Future<List<TrendingMovieEntity>> getTrendingMoviesTest() async {
  final response =
      await rootBundle.loadString('test_data/movie_entity_test.json');
  final jsonList = await json.decode(response);

  final List<TrendingMovieEntity> movieList = jsonList
      .map<TrendingMovieEntity>(
        (json) => TrendingMovieEntity.fromJson(json),
      )
      .toList();

  return Future.value(movieList);
}

Future<List<PopularMovieEntity>> getPopularMoviesTest() async {
  final response =
      await rootBundle.loadString('test_data/movie_entity_test.json');
  final jsonList = await json.decode(response);

  final List<PopularMovieEntity> movieList = jsonList
      .map<PopularMovieEntity>(
        (json) => PopularMovieEntity.fromJson(json),
      )
      .toList();

  return Future.value(movieList);
}
