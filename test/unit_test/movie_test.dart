import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:filmcrate/features/movies/domain/use_case/movie_use_case.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
import 'package:filmcrate/features/profile/domain/use_case/profile_use_case.dart';
import 'package:filmcrate/features/watchlist/domain/use_case/watchlist_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/movie_entity_test.dart';
import 'movie_test.mocks.dart';

//yo test ni mileko xa

@GenerateNiceMocks([
  MockSpec<MovieUseCase>(),
  MockSpec<ProfileUseCase>(),
  MockSpec<WatchListUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late MovieUseCase mockMovieUseCase;
  late List<TopRatedMovieEntity> topRatedMovieEntity;

  setUpAll(() async {
    mockMovieUseCase = MockMovieUseCase();
    topRatedMovieEntity = await getTopRatedMoviesTest();
    when(mockMovieUseCase.getTopRatedMovies())
        .thenAnswer((_) async => const Right([]));
    when(mockMovieUseCase.getTrendingMovies())
        .thenAnswer((_) async => const Right([]));
    when(mockMovieUseCase.getPopularMovies())
        .thenAnswer((_) async => const Right([]));

    container = ProviderContainer(
      overrides: [
        movieViewModelProvider.overrideWith(
          (ref) => MovieViewModel(mockMovieUseCase),
        )
      ],
    );
  });

  test('check movie initial state', () async {
    await container.read(movieViewModelProvider.notifier).getTrendingMovies();

    final movieState = container.read(movieViewModelProvider);
    expect(movieState.isLoading, false);
    expect(movieState.trendingMovies, isEmpty);
  });

  test('should get top rated movies', () async {
    when(mockMovieUseCase.getTopRatedMovies())
        .thenAnswer((_) => Future.value(Right(topRatedMovieEntity)));

    await container.read(movieViewModelProvider.notifier).getTopRatedMovies();
    final movieState = container.read(movieViewModelProvider);

    expect(movieState.isLoading, false);
    expect(movieState.movies.length, 7);
  });

  tearDownAll(() {
    container.dispose();
  });

  test('should not get top rated movies', () async {
    when(mockMovieUseCase.getTopRatedMovies())
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container.read(movieViewModelProvider.notifier).getTopRatedMovies();
    final movieState = container.read(movieViewModelProvider);

    expect(movieState.isLoading, false);
    expect(movieState.error, isNull);
    //test fail garna isNotNull ko satta isNull rakhney
  });

  tearDownAll(() {
    container.dispose();
  });
}
