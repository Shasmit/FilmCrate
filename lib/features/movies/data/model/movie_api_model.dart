import 'package:equatable/equatable.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// ignore_for_file: non_constant_identifier_names

part 'movie_api_model.g.dart';

final TopRatedMovieApiModelProvider = Provider<TopRatedMovieApiModel>(
  (ref) => const TopRatedMovieApiModel.empty(),
);

@JsonSerializable()
class TopRatedMovieApiModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'original_language')
  final String? original_language;
  @JsonKey(name: 'original_title')
  final String? original_title;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String poster_path;
  @JsonKey(name: 'backdrop_path')
  final String? backdrop_path;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'vote_average')
  final num? vote_average;
  @JsonKey(name: 'release_date')
  final String? release_date;

  const TopRatedMovieApiModel({
    required this.id,
    this.original_language,
    this.original_title,
    this.overview,
    required this.poster_path,
    this.backdrop_path,
    required this.title,
    this.vote_average,
    this.release_date,
  });

  const TopRatedMovieApiModel.empty()
      : id = 0,
        original_language = '',
        original_title = '',
        overview = '',
        poster_path = '',
        backdrop_path = '',
        title = '',
        vote_average = 0,
        release_date = '';

  Map<String, dynamic> toJson() => _$TopRatedMovieApiModelToJson(this);

  factory TopRatedMovieApiModel.fromJson(Map<String, dynamic> json) =>
      _$TopRatedMovieApiModelFromJson(json);

  TopRatedMovieEntity toEntity() => TopRatedMovieEntity(
        id: id,
        original_language: original_language,
        original_title: original_title,
        overview: overview,
        poster_path: poster_path,
        backdrop_path: backdrop_path,
        title: title,
        vote_average: vote_average,
        release_date: release_date,
      );

  TopRatedMovieApiModel fromEntity(TopRatedMovieEntity entity) =>
      TopRatedMovieApiModel(
        id: entity.id ?? 0,
        original_language: entity.original_language ?? '',
        original_title: entity.original_title ?? '',
        overview: entity.overview ?? '',
        poster_path: entity.poster_path ?? '',
        backdrop_path: entity.backdrop_path ?? '',
        title: entity.title ?? '',
        vote_average: entity.vote_average ?? 0,
        release_date: entity.release_date ?? '',
      );

  List<TopRatedMovieEntity> toEntityList(List<TopRatedMovieApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        original_language,
        original_title,
        overview,
        poster_path,
        backdrop_path,
        title,
        vote_average,
        release_date,
      ];
}
