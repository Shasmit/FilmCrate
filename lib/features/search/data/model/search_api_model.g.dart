// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchApiModel _$SearchApiModelFromJson(Map<String, dynamic> json) =>
    SearchApiModel(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      title: json['title'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      releaseDate: json['release_date'] as String?,
      video: json['video'] as bool?,
      voteCount: json['vote_count'] as int?,
    );

Map<String, dynamic> _$SearchApiModelToJson(SearchApiModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'popularity': instance.popularity,
      'title': instance.title,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
      'video': instance.video,
      'vote_count': instance.voteCount,
    };
