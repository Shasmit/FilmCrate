import 'package:dartz/dartz.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/config/themes/app_themes.dart';
import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';
import 'package:filmcrate/features/profile/domain/use_case/profile_use_case.dart';
import 'package:filmcrate/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:filmcrate/features/watchlist/domain/entity/watchlist_entity.dart';
import 'package:filmcrate/features/watchlist/domain/use_case/watchlist_use_case.dart';
import 'package:filmcrate/features/watchlist/presentation/viewmodel/watchlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../test/unit_test/movie_test.mocks.dart';
import '../test_data/profile_entity_test.dart';
import '../test_data/watchlist_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late WatchListUseCase mockWatchListUseCase;
  late ProfileUseCase mockProfileUseCase;
  late List<WatchListEntity> watchListEntity;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockWatchListUseCase = MockWatchListUseCase();
    mockProfileUseCase = MockProfileUseCase();
    watchListEntity = await getWatchListTest();
    profileEntity = await getProfileTest();
  });

  testWidgets('Watchlist View should have 1 gridview and 1 listview',
      (tester) async {
    when(mockWatchListUseCase.getWatchList())
        .thenAnswer((_) async => Right(watchListEntity));
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          watchListViewModelProvider.overrideWith((ref) =>
              WatchListViewModel(watchListUseCase: mockWatchListUseCase)),
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.watchlistRoute,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.getApplicationTheme(false),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);

    final gridViewWidgets = tester.widgetList<GridView>(find.byType(GridView));

    final itemCounts = gridViewWidgets
        .map((gridView) => gridView.childrenDelegate.estimatedChildCount ?? 0)
        .toList();

    expect(itemCounts.length, 1);
    expect(itemCounts[0], 1);
  });

  testWidgets('Watchlist View should be empty', (tester) async {
    when(mockWatchListUseCase.getWatchList())
        .thenAnswer((_) async => const Right([]));
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          watchListViewModelProvider.overrideWith((ref) =>
              WatchListViewModel(watchListUseCase: mockWatchListUseCase)),
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.watchlistRoute,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.getApplicationTheme(false),
        ),
      ),
    );

    await tester.pumpAndSettle();

    //THIS WILL PASS
    expect(find.text('No movies added to watchlist yet!🍿'), findsOneWidget);

    // this will fail
    // expect(find.byType(ListView), findsOneWidget);

    // final gridViewWidgets = tester.widgetList<GridView>(find.byType(GridView));

    // final itemCounts = gridViewWidgets
    //     .map((gridView) => gridView.childrenDelegate.estimatedChildCount ?? 0)
    //     .toList();

    // expect(itemCounts.length, 1);
    // expect(itemCounts[0], 1);
  });
}
