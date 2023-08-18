import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/movies/data/dataSource/movie_local_data_source.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:filmcrate/features/movies/domain/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieLocalRepoProvider = Provider<IMovieRepository>(
  (ref) {
    return MovieLocalRepositoryImpl(
      movieLocalDataSource: ref.read(movieLocalDataSourceProvider),
    );
  },
);

class MovieLocalRepositoryImpl implements IMovieRepository {
  final MovieLocalDataSource movieLocalDataSource;

  MovieLocalRepositoryImpl({
    required this.movieLocalDataSource,
  });

  @override
  Future<Either<Failure, List<TopRatedMovieEntity>>> getTopRatedMovies() {
    return movieLocalDataSource.getAllTopRatedMovies();
  }

  @override
  Future<Either<Failure, List<TrendingMovieEntity>>> getTrendingMovies() {
    return movieLocalDataSource.getAllTrendingMovies();
  }

  @override
  Future<Either<Failure, List<PopularMovieEntity>>> getPopularMovies() {
    return movieLocalDataSource.getAllPopularMovies();
  }

  @override
  Future<Either<Failure, List<AllMovieEntity>>> getMovieDetails(int id) {
    throw UnimplementedError();
  }
}
