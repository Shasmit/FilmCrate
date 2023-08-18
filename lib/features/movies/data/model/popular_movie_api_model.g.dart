// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMovieApiModel _$PopularMovieApiModelFromJson(
        Map<String, dynamic> json) =>
    PopularMovieApiModel(
      id: json['id'] as int,
      original_language: json['original_language'] as String?,
      original_title: json['original_title'] as String?,
      overview: json['overview'] as String?,
      poster_path: json['poster_path'] as String,
      backdrop_path: json['backdrop_path'] as String?,
      title: json['title'] as String,
      vote_average: json['vote_average'] as num?,
      release_date: json['release_date'] as String?,
    );

Map<String, dynamic> _$PopularMovieApiModelToJson(
        PopularMovieApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'poster_path': instance.poster_path,
      'backdrop_path': instance.backdrop_path,
      'title': instance.title,
      'vote_average': instance.vote_average,
      'release_date': instance.release_date,
    };
