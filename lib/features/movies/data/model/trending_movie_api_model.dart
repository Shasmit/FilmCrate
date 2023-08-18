// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trending_movie_api_model.g.dart';

final TrendingMovieApiModelProvider = Provider<TrendingMovieApiModel>(
  (ref) => const TrendingMovieApiModel.empty(),
);

@JsonSerializable()
class TrendingMovieApiModel extends Equatable {
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

  const TrendingMovieApiModel({
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

  const TrendingMovieApiModel.empty()
      : id = 0,
        original_language = '',
        original_title = '',
        overview = '',
        poster_path = '',
        backdrop_path = '',
        title = '',
        vote_average = 0,
        release_date = '';

  Map<String, dynamic> toJson() => _$TrendingMovieApiModelToJson(this);

  factory TrendingMovieApiModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingMovieApiModelFromJson(json);

  TrendingMovieEntity toEntity() => TrendingMovieEntity(
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

  TrendingMovieApiModel fromEntity(TrendingMovieEntity entity) =>
      TrendingMovieApiModel(
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

  List<TrendingMovieEntity> toEntityList(List<TrendingMovieApiModel> models) =>
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
