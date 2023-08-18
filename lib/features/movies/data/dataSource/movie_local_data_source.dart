import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/core/network/local/hive_service.dart';
import 'package:filmcrate/features/movies/data/model/top_rated_hive_model.dart';
import 'package:filmcrate/features/movies/data/model/trending_hive_model.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/popular_hive_model.dart';

final movieLocalDataSourceProvider = Provider(
  (ref) => MovieLocalDataSource(
    hiveService: ref.read(hiveServiceProvider),
    topRatedHiveModel: ref.read(topRatedHiveModelProvider),
    trendingMovieHiveModel: ref.read(trendingHiveModelProvider),
    popularHiveModel: ref.read(popularHiveModelProvider),
  ),
);

class MovieLocalDataSource {
  final HiveService hiveService;
  final TopRatedHiveModel topRatedHiveModel;
  final TrendingMovieHiveModel trendingMovieHiveModel;
  final PopularHiveModel popularHiveModel;

  MovieLocalDataSource({
    required this.hiveService,
    required this.topRatedHiveModel,
    required this.trendingMovieHiveModel,
    required this.popularHiveModel,
  });

  Future<Either<Failure, List<TopRatedMovieEntity>>>
      getAllTopRatedMovies() async {
    try {
      // Get all batches from Hive
      final topRated = await hiveService.getTopRatedMovies();
      // Convert Hive Object to Entity
      final topRatedEntities = topRatedHiveModel.toEntityList(topRated);
      print('top rated $topRatedEntities');

      return Right(topRatedEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<PopularMovieEntity>>>
      getAllPopularMovies() async {
    try {
      final popular = await hiveService.getPopularMovies();
      // Convert Hive Object to Entity
      final popularEntities = popularHiveModel.toEntityList(popular);
      print('popular $popularEntities');
      return Right(popularEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<TrendingMovieEntity>>>
      getAllTrendingMovies() async {
    try {
      final trending = await hiveService.getTrendingMovies();
      // Convert Hive Object to Entity
      final trendingEntities = trendingMovieHiveModel.toEntityList(trending);
      print('trending $trendingEntities');
      return Right(trendingEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
