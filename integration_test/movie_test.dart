import 'package:dartz/dartz.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:filmcrate/features/movies/domain/use_case/movie_use_case.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';
import 'package:filmcrate/features/profile/domain/use_case/profile_use_case.dart';
import 'package:filmcrate/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../test/unit_test/movie_test.mocks.dart';
import '../test_data/movie_entity_test.dart';
import '../test_data/profile_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late MovieUseCase mockMovieUseCase;
  late ProfileUseCase mockProfileUseCase;
  late List<TopRatedMovieEntity> topRatedMovieEntity;
  late List<TrendingMovieEntity> trendingMovieEntiy;
  late List<PopularMovieEntity> popularMovieEntity;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockMovieUseCase = MockMovieUseCase();
    mockProfileUseCase = MockProfileUseCase();
    topRatedMovieEntity = await getTopRatedMoviesTest();
    trendingMovieEntiy = await getTrendingMoviesTest();
    popularMovieEntity = await getPopularMoviesTest();
    profileEntity = await getProfileTest();
  });

  testWidgets('Dashboard View', (tester) async {
    when(mockMovieUseCase.getTopRatedMovies())
        .thenAnswer((_) async => Right(topRatedMovieEntity));
    when(mockMovieUseCase.getTrendingMovies())
        .thenAnswer((_) async => Right(trendingMovieEntiy));
    when(mockMovieUseCase.getPopularMovies())
        .thenAnswer((_) async => Right(popularMovieEntity));
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          movieViewModelProvider
              .overrideWith((ref) => MovieViewModel(mockMovieUseCase)),
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.movieScreen,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsWidgets);
    final listViewWidgets = tester.widgetList<ListView>(find.byType(ListView));

    final itemCounts = listViewWidgets
        .map((listView) => listView.childrenDelegate.estimatedChildCount ?? 0)
        .toList();

    expect(itemCounts.length, 4);
    expect(itemCounts[0], 6);
  });

  testWidgets('Dashboard View but failed with incorrect widget expectation',
      (tester) async {
    when(mockMovieUseCase.getTopRatedMovies())
        .thenAnswer((_) async => Left(Failure(error: "Invalid")));
    when(mockMovieUseCase.getTrendingMovies())
        .thenAnswer((_) async => Right(trendingMovieEntiy));
    when(mockMovieUseCase.getPopularMovies())
        .thenAnswer((_) async => Right(popularMovieEntity));
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          movieViewModelProvider
              .overrideWith((ref) => MovieViewModel(mockMovieUseCase)),
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.movieScreen,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsWidgets);
    final listViewWidgets = tester.widgetList<ListView>(find.byType(ListView));

    final itemCounts = listViewWidgets
        .map((listView) => listView.childrenDelegate.estimatedChildCount ?? 0)
        .toList();

    expect(itemCounts.length, 4);

    //this will pass
    expect(itemCounts[1], 0);

    //this will fail
    // expect(itemCounts[1], isNonZero);
  });
}
