import 'package:dartz/dartz.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../repository/movie_repository.dart';

final movieUseCaseProvider = Provider<MovieUseCase>(
  (ref) => MovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  ),
);

class MovieUseCase {
  final IMovieRepository movieRepository;

  MovieUseCase({
    required this.movieRepository,
  });

  Future<Either<Failure, List<TopRatedMovieEntity>>> getTopRatedMovies() async {
    return await movieRepository.getTopRatedMovies();
  }

  Future<Either<Failure, List<TrendingMovieEntity>>> getTrendingMovies() async {
    return await movieRepository.getTrendingMovies();
  }

  Future<Either<Failure, List<PopularMovieEntity>>> getPopularMovies() async {
    return await movieRepository.getPopularMovies();
  }

  Future<Either<Failure, List<AllMovieEntity>>> getMovieDetails(int id) async {
    return await movieRepository.getMovieDetails(id);
  }
}
