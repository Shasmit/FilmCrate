import 'package:filmcrate/features/watchlist/domain/use_case/watchlist_use_case.dart';
import 'package:filmcrate/features/watchlist/presentation/state/watchlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchListViewModelProvider =
    StateNotifierProvider<WatchListViewModel, WatchListState>(
  (ref) => WatchListViewModel(
    watchListUseCase: ref.watch(watchListUseCaseProvider),
  ),
);

class WatchListViewModel extends StateNotifier<WatchListState> {
  final WatchListUseCase watchListUseCase;

  WatchListViewModel({
    required this.watchListUseCase,
  }) : super(WatchListState.initial()) {
    getWatchList();
  }

  Future<void> getWatchList() async {
    state = state.copyWith(isLoading: true);
    final result = await watchListUseCase.getWatchList();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (watchList) => state = state.copyWith(
        isLoading: false,
        watchList: watchList,
        error: null,
      ),
    );
  }

  createWatchlist(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await watchListUseCase.createWatchlist(id);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  deleteWatchlist(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await watchListUseCase.deleteWatchlist(id);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }
}
