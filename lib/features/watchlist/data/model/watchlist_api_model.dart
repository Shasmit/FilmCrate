import 'package:equatable/equatable.dart';
import 'package:filmcrate/features/watchlist/domain/entity/watchlist_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watchlist_api_model.g.dart';

final watchListApiModelProvider = Provider<WatchListApiModel>(
  (ref) => WatchListApiModel.empty(),
);

@JsonSerializable()
class WatchListApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'user')
  final String user;

  @JsonKey(name: 'movieId')
  final String movieId;

  @JsonKey(name: 'movieDetails')
  final MovieDetailsApiModel movieDetails;

  @JsonKey(name: 'timestamp')
  final String timestamp;

  @JsonKey(name: '__v')
  final int v;

  const WatchListApiModel({
    required this.id,
    required this.user,
    required this.movieId,
    required this.movieDetails,
    required this.timestamp,
    required this.v,
  });

  factory WatchListApiModel.fromJson(Map<String, dynamic> json) =>
      _$WatchListApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WatchListApiModelToJson(this);

  factory WatchListApiModel.empty() => WatchListApiModel(
        id: '',
        user: '',
        movieId: '',
        movieDetails: MovieDetailsApiModel.empty(),
        timestamp: '',
        v: 0,
      );

  WatchListEntity toEntity() => WatchListEntity(
        id: id,
        user: user,
        movieId: movieId,
        movieDetails: movieDetails.toEntity(),
        timestamp: timestamp,
        v: v,
      );

  WatchListApiModel fromEntity(WatchListEntity entity) => WatchListApiModel(
        id: entity.id,
        user: entity.user,
        movieId: entity.movieId,
        movieDetails:
            MovieDetailsApiModel.empty().fromEntity(entity.movieDetails),
        timestamp: entity.timestamp,
        v: entity.v,
      );

  List<WatchListEntity> toEntityList(List<WatchListApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        user,
        movieId,
        movieDetails,
        timestamp,
        v,
      ];
}

@JsonSerializable()
class MovieDetailsApiModel extends Equatable {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: '_id')
  final String id;

  const MovieDetailsApiModel({
    required this.title,
    required this.posterPath,
    required this.id,
  });

  factory MovieDetailsApiModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsApiModelToJson(this);

  factory MovieDetailsApiModel.empty() => const MovieDetailsApiModel(
        title: '',
        posterPath: '',
        id: '',
      );

  MovieDetails toEntity() => MovieDetails(
        title: title,
        posterPath: posterPath,
        id: id,
      );

  MovieDetailsApiModel fromEntity(MovieDetails entity) => MovieDetailsApiModel(
        title: entity.title,
        posterPath: entity.posterPath,
        id: entity.id,
      );

  List<MovieDetails> toEntityList(List<MovieDetailsApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        title,
        posterPath,
        id,
      ];
}
