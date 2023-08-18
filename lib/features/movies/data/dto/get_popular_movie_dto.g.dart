// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_popular_movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPopularMovie _$GetPopularMovieFromJson(Map<String, dynamic> json) =>
    GetPopularMovie(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => PopularMovieApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPopularMovieToJson(GetPopularMovie instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };
