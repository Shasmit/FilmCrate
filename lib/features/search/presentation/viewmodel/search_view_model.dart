import 'package:filmcrate/features/search/domain/use_case/search_use_case.dart';
import 'package:filmcrate/features/search/presentation/state/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>(
        (ref) => SearchViewModel(ref.read(searchUseCaseProvider)));

class SearchViewModel extends StateNotifier<SearchState> {
  final SearchUseCase searchUseCase;

  SearchViewModel(this.searchUseCase) : super(SearchState.initial());

  getSearchedMovies(String name) async {
    state = state.copyWith(isLoading: true);

    final result = await searchUseCase.getSearchedMovie(name);
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
}
