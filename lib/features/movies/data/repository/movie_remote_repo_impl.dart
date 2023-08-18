import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/common/provider/network_connection.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/movies/data/dataSource/movie_local_data_source.dart';
import 'package:filmcrate/features/movies/data/dataSource/movie_remote_data_source.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:filmcrate/features/movies/domain/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRemoteRepoProvider = Provider<IMovieRepository>(
  (ref) => MovieRemoteRepositoryImpl(
    movieRemoteDataSource: ref.read(movieRemoteDataSourceProvider),
    movieLocalDataSource: ref.read(movieLocalDataSourceProvider),
  ),
);

class MovieRemoteRepositoryImpl implements IMovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final MovieLocalDataSource movieLocalDataSource;
  MovieRemoteRepositoryImpl(
      {required this.movieRemoteDataSource,
      required this.movieLocalDataSource});

  @override
  Future<Either<Failure, List<TopRatedMovieEntity>>> getTopRatedMovies() async {
    final a = await checkConnectivity();

    if (a) {
      return await movieRemoteDataSource.getTopRatedMovies();
    } else {
      return movieLocalDataSource.getAllTopRatedMovies();
    }
  }

  @override
  Future<Either<Failure, List<TrendingMovieEntity>>> getTrendingMovies() async {
    final a = await checkConnectivity();

    if (a) {
      return movieRemoteDataSource.getTrendingMovies();
    } else {
      return movieLocalDataSource.getAllTrendingMovies();
    }
  }

  @override
  Future<Either<Failure, List<AllMovieEntity>>> getMovieDetails(int id) {
    return movieRemoteDataSource.getMovieDetails(id);
  }

  @override
  Future<Either<Failure, List<PopularMovieEntity>>> getPopularMovies() async {
    final a = await checkConnectivity();

    if (a) {
      return movieRemoteDataSource.getPopularMovies();
    } else {
      return movieLocalDataSource.getAllPopularMovies();
    }
  }
}
