// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_movies_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchedMovies _$GetSearchedMoviesFromJson(Map<String, dynamic> json) =>
    GetSearchedMovies(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => SearchApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchedMoviesToJson(GetSearchedMovies instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };
