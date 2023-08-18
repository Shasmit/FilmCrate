import '../../domain/entity/search_movies_entity.dart';

class SearchState {
  final bool isLoading;
  final List<SearchEntity> movies;
  final String? error;

  SearchState({
    required this.isLoading,
    required this.movies,
    required this.error,
  });

  factory SearchState.initial() {
    return SearchState(
      isLoading: false,
      movies: [],
      error: null,
    );
  }

  SearchState copyWith({
    bool? isLoading,
    List<SearchEntity>? movies,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      error: error ?? this.error,
    );
  }
}
