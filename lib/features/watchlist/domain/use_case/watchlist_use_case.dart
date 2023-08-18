import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/watchlist/domain/repository/watchlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/watchlist_entity.dart';

final watchListUseCaseProvider = Provider<WatchListUseCase>(
  (ref) => WatchListUseCase(
    watchListRepository: ref.watch(watchListRepositoryProvider),
  ),
);

class WatchListUseCase {
  final IWatchListRepository watchListRepository;

  WatchListUseCase({
    required this.watchListRepository,
  });

  Future<Either<Failure, bool>> createWatchlist(int id) {
    return watchListRepository.createWatchlist(id);
  }

  Future<Either<Failure, bool>> deleteWatchlist(int id) {
    return watchListRepository.deleteWatchlist(id);
  }

  Future<Either<Failure, List<WatchListEntity>>> getWatchList() {
    return watchListRepository.getWatchList();
  }
}
