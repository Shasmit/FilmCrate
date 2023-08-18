import 'package:filmcrate/features/movies/domain/use_case/movie_use_case.dart';
import 'package:filmcrate/features/movies/presentation/state/movie_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieViewModelProvider =
    StateNotifierProvider<MovieViewModel, MovieState>(
        (ref) => MovieViewModel(ref.read(movieUseCaseProvider)));

class MovieViewModel extends StateNotifier<MovieState> {
  final MovieUseCase movieUseCase;

  MovieViewModel(
    this.movieUseCase,
  ) : super(MovieState.initial()) {
    getTopRatedMovies();
    getTrendingMovies();
    getPopularMovies();
  }

  getTopRatedMovies() async {
    state = state.copyWith(isLoading: true);

    final result = await movieUseCase.getTopRatedMovies();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (movies) => state = state.copyWith(
        isLoading: false,
        movies: movies,
        error: null,
      ),
    );
  }

  getTrendingMovies() async {
    state = state.copyWith(isLoading: true);

    final result = await movieUseCase.getTrendingMovies();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (trendingMovies) => state = state.copyWith(
        isLoading: false,
        trendingMovies: trendingMovies,
        error: null,
      ),
    );
  }

  getPopularMovies() async {
    state = state.copyWith(isLoading: true);

    final result = await movieUseCase.getPopularMovies();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (popularMovies) => state = state.copyWith(
        isLoading: false,
        popularMovies: popularMovies,
        error: null,
      ),
    );
  }

  getMovieDetails(int id) async {
    state = state.copyWith(isLoading: true);

    final result = await movieUseCase.getMovieDetails(id);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (movies) => state = state.copyWith(
        isLoading: false,
        allMovies: movies,
        error: null,
      ),
    );
  }
}
