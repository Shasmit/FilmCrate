import 'package:filmcrate/features/watchlist/domain/entity/watchlist_entity.dart';

class WatchListState {
  final bool isLoading;
  final List<WatchListEntity>? watchList;
  final String? error;

  const WatchListState({
    required this.isLoading,
    this.watchList,
    this.error,
  });

  factory WatchListState.initial() {
    return const WatchListState(
      isLoading: false,
    );
  }

  WatchListState copyWith({
    bool? isLoading,
    List<WatchListEntity>? watchList,
    bool? isBookmarked,
    String? error,
  }) {
    return WatchListState(
      isLoading: isLoading ?? this.isLoading,
      watchList: watchList ?? this.watchList,
      error: error ?? this.error,
    );
  }
}
