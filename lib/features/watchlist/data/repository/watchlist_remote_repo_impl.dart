import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/watchlist/data/dataSource/watchlist_remote_data_source.dart';
import 'package:filmcrate/features/watchlist/domain/repository/watchlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/watchlist_entity.dart';

final watchListRemoteRepoProvider = Provider<IWatchListRepository>(
  (ref) => WatchListRemoteRepositoryImpl(
    watchListRemoteDataSource: ref.watch(watchListRemoteDataSourceProvider),
  ),
);

class WatchListRemoteRepositoryImpl implements IWatchListRepository {
  final WatchListRemoteDataSource watchListRemoteDataSource;

  WatchListRemoteRepositoryImpl({
    required this.watchListRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> createWatchlist(int id) {
    return watchListRemoteDataSource.createWatchlist(id);
  }

  @override
  Future<Either<Failure, bool>> deleteWatchlist(int id) {
    return watchListRemoteDataSource.deleteWatchlist(id);
  }

  @override
  Future<Either<Failure, List<WatchListEntity>>> getWatchList() {
    return watchListRemoteDataSource.getWatchList();
  }
}
