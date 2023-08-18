// ignore_for_file: non_constant_identifier_names

import 'package:filmcrate/config/constants/hive_table_constant.dart';
import 'package:filmcrate/features/movies/data/model/movie_api_model.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

part 'top_rated_hive_model.g.dart';

final topRatedHiveModelProvider = Provider(
  (ref) => TopRatedHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.topRatedMovieId)
class TopRatedHiveModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String original_language;

  @HiveField(2)
  final String original_title;

  @HiveField(3)
  final String overview;

  @HiveField(4)
  final String poster_path;

  @HiveField(5)
  final String backdrop_path;

  @HiveField(6)
  final String title;

  @HiveField(7)
  final num vote_average;

  @HiveField(8)
  final String release_date;

  const TopRatedHiveModel({
    required this.id,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.backdrop_path,
    required this.title,
    required this.vote_average,
    required this.release_date,
  });

  TopRatedHiveModel.empty()
      : this(
          id: 0,
          original_language: '',
          original_title: '',
          overview: '',
          poster_path: '',
          backdrop_path: '',
          title: '',
          vote_average: 0,
          release_date: '',
        );

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

  TopRatedHiveModel toHiveModel(TopRatedMovieEntity entity) =>
      TopRatedHiveModel(
        id: entity.id!,
        original_language: entity.original_language!,
        original_title: entity.original_title!,
        overview: entity.overview!,
        poster_path: entity.poster_path!,
        backdrop_path: entity.backdrop_path!,
        title: entity.title!,
        vote_average: entity.vote_average!,
        release_date: entity.release_date!,
      );

  List<TopRatedHiveModel> fromApiModelList(
      List<TopRatedMovieApiModel> apiModels) {
    return apiModels
        .map((apiModel) => TopRatedHiveModel(
              id: apiModel.id,
              original_language: apiModel.original_language!,
              original_title: apiModel.original_title!,
              overview: apiModel.overview!,
              poster_path: apiModel.poster_path,
              backdrop_path: apiModel.backdrop_path!,
              title: apiModel.title,
              vote_average: apiModel.vote_average!,
              release_date: apiModel.release_date!,
            ))
        .toList();
  }

  List<TopRatedMovieEntity> toEntityList(List<TopRatedHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'TopRatedHiveModel(id: $id, original_language: $original_language, original_title: $original_title, overview: $overview, poster_path: $poster_path, backdrop_path: $backdrop_path, title: $title, vote_average: $vote_average, release_date: $release_date)';
  }
}
