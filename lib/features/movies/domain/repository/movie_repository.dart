import 'package:dartz/dartz.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/movie_remote_repo_impl.dart';

final movieRepositoryProvider = Provider<IMovieRepository>(
  (ref) {
    return ref.watch(movieRemoteRepoProvider);
  },
);

abstract class IMovieRepository {
  Future<Either<Failure, List<TopRatedMovieEntity>>> getTopRatedMovies();
  Future<Either<Failure, List<TrendingMovieEntity>>> getTrendingMovies();
  Future<Either<Failure, List<PopularMovieEntity>>> getPopularMovies();
  Future<Either<Failure, List<AllMovieEntity>>> getMovieDetails(int id);
}
