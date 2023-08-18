// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_top_rated_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTopRatedMovies _$GetTopRatedMoviesFromJson(Map<String, dynamic> json) =>
    GetTopRatedMovies(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => TopRatedMovieApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTopRatedMoviesToJson(GetTopRatedMovies instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };
