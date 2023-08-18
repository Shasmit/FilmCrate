// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchListApiModel _$WatchListApiModelFromJson(Map<String, dynamic> json) =>
    WatchListApiModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      movieId: json['movieId'] as String,
      movieDetails: MovieDetailsApiModel.fromJson(
          json['movieDetails'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
      v: json['__v'] as int,
    );

Map<String, dynamic> _$WatchListApiModelToJson(WatchListApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'movieId': instance.movieId,
      'movieDetails': instance.movieDetails,
      'timestamp': instance.timestamp,
      '__v': instance.v,
    };

MovieDetailsApiModel _$MovieDetailsApiModelFromJson(
        Map<String, dynamic> json) =>
    MovieDetailsApiModel(
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$MovieDetailsApiModelToJson(
        MovieDetailsApiModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'poster_path': instance.posterPath,
      '_id': instance.id,
    };
