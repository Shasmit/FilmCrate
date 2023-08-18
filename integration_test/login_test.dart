import 'package:dartz/dartz.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/config/themes/app_themes.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/auth/domain/use_case/auth_usecase.dart';
import 'package:filmcrate/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:filmcrate/features/movies/domain/use_case/movie_use_case.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
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

import '../test/unit_test/auth_test.mocks.dart';
import '../test/unit_test/movie_test.mocks.dart';
import '../test_data/movie_entity_test.dart';
import '../test_data/profile_entity_test.dart';
import '../test_data/watchlist_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUseCase;
  late MovieUseCase mockMovieUseCase;
  late WatchListUseCase mockWatchListUseCase;
  late ProfileUseCase mockProfileUseCase;
  late List<TopRatedMovieEntity> topRatedMovieEntity;
  late List<TrendingMovieEntity> trendingMovieEntiy;
  late List<PopularMovieEntity> popularMovieEntity;
  late List<ProfileEntity> profileEntity;
  late List<WatchListEntity> watchListEntity;
  late bool isLogin;

  setUpAll(() async {
    mockAuthUseCase = MockAuthUseCase();
    mockMovieUseCase = MockMovieUseCase();
    mockProfileUseCase = MockProfileUseCase();
    mockWatchListUseCase = MockWatchListUseCase();
    topRatedMovieEntity = await getTopRatedMoviesTest();
    trendingMovieEntiy = await getTrendingMoviesTest();
    popularMovieEntity = await getPopularMoviesTest();
    profileEntity = await getProfileTest();
    watchListEntity = await getWatchListTest();
    isLogin = true;
  });

//chalo
  testWidgets(
    'login test with username and password and open dashboard',
    (tester) async {
      // Arrange
      when(mockAuthUseCase.loginUser('ssid', 'ssid1234'))
          .thenAnswer((_) async => Right(isLogin));
      when(mockMovieUseCase.getTopRatedMovies())
          .thenAnswer((_) async => Right(topRatedMovieEntity));
      when(mockMovieUseCase.getTrendingMovies())
          .thenAnswer((_) async => Right(trendingMovieEntiy));
      when(mockMovieUseCase.getPopularMovies())
          .thenAnswer((_) async => Right(popularMovieEntity));
      when(mockProfileUseCase.getUserProfile())
          .thenAnswer((_) async => Right(profileEntity));
      when(mockWatchListUseCase.getWatchList())
          .thenAnswer((_) async => Right(watchListEntity));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authViewModelProvider
                .overrideWith((ref) => AuthViewModel(mockAuthUseCase)),
            movieViewModelProvider
                .overrideWith((ref) => MovieViewModel(mockMovieUseCase)),
            profileViewModelProvider
                .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
            watchListViewModelProvider.overrideWith(
              (ref) =>
                  WatchListViewModel(watchListUseCase: mockWatchListUseCase),
            ),
          ],
          child: MaterialApp(
            initialRoute: AppRoute.loginRoute,
            routes: AppRoute.getApplicationRoute(),
            debugShowCheckedModeBanner: false,
            theme: AppThemes.getApplicationTheme(false),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'ssid');
      await tester.enterText(find.byType(TextFormField).at(1), 'ssid1234');

      final loginbuttonFinder = find.widgetWithText(ElevatedButton, 'LOGIN');

      await tester.dragUntilVisible(
        loginbuttonFinder,
        find.byType(SingleChildScrollView),
        const Offset(201.4, 574.7),
      );

      await tester.tap(loginbuttonFinder);

      await tester.pumpAndSettle();

      expect(find.text('MOVIE'), findsOneWidget);
    },
  );

  //failed test case
  testWidgets(
    'login test with invalid username and password shows error message',
    (tester) async {
      // Arrange
      when(mockAuthUseCase.loginUser('invalid_username', 'invalid_password'))
          .thenAnswer((_) async => Left(Failure(error: "Invalid")));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authViewModelProvider
                .overrideWith((ref) => AuthViewModel(mockAuthUseCase)),
          ],
          child: MaterialApp(
            initialRoute: AppRoute.loginRoute,
            routes: AppRoute.getApplicationRoute(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).at(0), 'invalid_username');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'invalid_password');

      final loginButtonFinder = find.widgetWithText(ElevatedButton, 'LOGIN');

      await tester.dragUntilVisible(
        loginButtonFinder,
        find.byType(SingleChildScrollView),
        const Offset(201.4, 574.7),
      );

      await tester.tap(loginButtonFinder);

      await tester.pumpAndSettle();

      // this will fail
      // expect(find.text('Incorrect'), findsOneWidget);

      // this will pass
      expect(find.text('Invalid'), findsOneWidget);
    },
  );
}
