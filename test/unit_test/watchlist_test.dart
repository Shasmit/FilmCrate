import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/watchlist/domain/entity/watchlist_entity.dart';
import 'package:filmcrate/features/watchlist/domain/use_case/watchlist_use_case.dart';
import 'package:filmcrate/features/watchlist/presentation/viewmodel/watchlist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/watchlist_entity_test.dart';
import 'movie_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late WatchListUseCase mockWatchListUseCase;
  late List<WatchListEntity> watchListEntity;

  setUpAll(() async {
    mockWatchListUseCase = MockWatchListUseCase();
    watchListEntity = await getWatchListTest();
    when(mockWatchListUseCase.getWatchList())
        .thenAnswer((_) async => const Right([]));

    container = ProviderContainer(
      overrides: [
        watchListViewModelProvider.overrideWith(
          (ref) => WatchListViewModel(watchListUseCase: mockWatchListUseCase),
        )
      ],
    );
  });

  test('check watchlist initial state', () async {
    await container.read(watchListViewModelProvider.notifier).getWatchList();

    final watchListState = container.read(watchListViewModelProvider);
    expect(watchListState.isLoading, false);
    expect(watchListState.watchList, isEmpty);
  });

  test('should get watchlist', () async {
    when(mockWatchListUseCase.getWatchList())
        .thenAnswer((_) => Future.value(Right(watchListEntity)));

    await container.read(watchListViewModelProvider.notifier).getWatchList();

    final watchListState = container.read(watchListViewModelProvider);

    expect(watchListState.isLoading, false);
    expect(watchListState.watchList!.length, 1);
  });

  tearDownAll(() {
    container.dispose();
  });

  test('should not get watchlist', () async {
    when(mockWatchListUseCase.getWatchList())
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container.read(watchListViewModelProvider.notifier).getWatchList();

    final watchListState = container.read(watchListViewModelProvider);

    expect(watchListState.isLoading, false);
    expect(watchListState.error, isNotNull);

    //test fail garna isNotNull ko satta isNull rakhney
  });

  tearDownAll(() {
    container.dispose();
  });
}
