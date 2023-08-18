// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_movies_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMoviesDTO _$GetAllMoviesDTOFromJson(Map<String, dynamic> json) =>
    GetAllMoviesDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => AllMovieApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMoviesDTOToJson(GetAllMoviesDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
