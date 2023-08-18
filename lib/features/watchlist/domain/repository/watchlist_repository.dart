import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/watchlist_remote_repo_impl.dart';
import '../entity/watchlist_entity.dart';

final watchListRepositoryProvider = Provider<IWatchListRepository>(
  (ref) => ref.watch(watchListRemoteRepoProvider),
);

abstract class IWatchListRepository {
  Future<Either<Failure, bool>> createWatchlist(int id);
  Future<Either<Failure, bool>> deleteWatchlist(int id);
  Future<Either<Failure, List<WatchListEntity>>> getWatchList();
}
