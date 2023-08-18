import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';

class MovieState {
  final bool isLoading;
  final List<TopRatedMovieEntity> movies;
  final List<TrendingMovieEntity> trendingMovies;
  final List<PopularMovieEntity> popularMovies;
  final List<AllMovieEntity> allMovies;
  final List<UserEntity> users;
  final String? error;

  MovieState({
    required this.isLoading,
    required this.movies,
    required this.trendingMovies,
    required this.popularMovies,
    required this.allMovies,
    required this.users,
    required this.error,
  });

  factory MovieState.initial() {
    return MovieState(
      isLoading: false,
      movies: [],
      trendingMovies: [],
      popularMovies: [],
      allMovies: [],
      users: [],
      error: null,
    );
  }

  MovieState copyWith({
    bool? isLoading,
    List<TopRatedMovieEntity>? movies,
    List<TrendingMovieEntity>? trendingMovies,
    List<PopularMovieEntity>? popularMovies,
    List<AllMovieEntity>? allMovies,
    List<UserEntity>? users,
    String? error,
  }) {
    return MovieState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      allMovies: allMovies ?? this.allMovies,
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }
}
