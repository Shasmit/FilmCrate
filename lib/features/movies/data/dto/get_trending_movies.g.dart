// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trending_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTrendingMovies _$GetTrendingMoviesFromJson(Map<String, dynamic> json) =>
    GetTrendingMovies(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => TrendingMovieApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTrendingMoviesToJson(GetTrendingMovies instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };
