import 'package:equatable/equatable.dart';
import 'package:filmcrate/features/search/domain/entity/search_movies_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_api_model.g.dart';

final searchApiModelProvider = Provider<SearchApiModel>(
  (ref) => SearchApiModel.empty(),
);

@JsonSerializable()
class SearchApiModel extends Equatable {
  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'popularity')
  final double? popularity;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'video')
  final bool? video;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  const SearchApiModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.popularity,
    this.title,
    this.voteAverage,
    this.releaseDate,
    this.video,
    this.voteCount,
  });

  SearchApiModel.empty()
      : adult = false,
        backdropPath = '',
        genreIds = [],
        id = 0,
        originalLanguage = '',
        originalTitle = '',
        overview = '',
        posterPath = '',
        popularity = 0,
        title = '',
        voteAverage = 0,
        releaseDate = '',
        video = false,
        voteCount = 0;

  Map<String, dynamic> toJson() => _$SearchApiModelToJson(this);

  factory SearchApiModel.fromJson(Map<String, dynamic> json) =>
      _$SearchApiModelFromJson(json);

  SearchEntity toEntity() => SearchEntity(
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  SearchApiModel fromEntity(SearchEntity entity) => SearchApiModel(
        adult: entity.adult ?? false,
        backdropPath: entity.backdropPath ?? '',
        genreIds: entity.genreIds ?? [],
        id: entity.id ?? 0,
        originalLanguage: entity.originalLanguage ?? '',
        originalTitle: entity.originalTitle ?? '',
        overview: entity.overview ?? '',
        popularity: entity.popularity ?? 0,
        posterPath: entity.posterPath ?? '',
        releaseDate: entity.releaseDate ?? '',
        title: entity.title ?? '',
        video: entity.video ?? false,
        voteAverage: entity.voteAverage ?? 0,
        voteCount: entity.voteCount ?? 0,
      );

  List<SearchEntity> toEntityList(List<SearchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
