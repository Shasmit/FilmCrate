import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filmcrate/config/constants/api_endpoint.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/core/network/remote/http_service.dart';
import 'package:filmcrate/core/shared_prefs/user_shared_prefs.dart';
import 'package:filmcrate/features/auth/data/model/auth_api_model.dart';
import 'package:filmcrate/features/movies/data/dto/get_all_movies_dto.dart';
import 'package:filmcrate/features/movies/data/dto/get_top_rated_movies.dart';
import 'package:filmcrate/features/movies/data/dto/get_trending_movies.dart';
import 'package:filmcrate/features/movies/data/model/all_movies_api_model.dart';
import 'package:filmcrate/features/movies/data/model/movie_api_model.dart';
import 'package:filmcrate/features/movies/data/model/popular_hive_model.dart';
import 'package:filmcrate/features/movies/data/model/popular_movie_api_model.dart';
import 'package:filmcrate/features/movies/data/model/top_rated_hive_model.dart';
import 'package:filmcrate/features/movies/data/model/trending_hive_model.dart';
import 'package:filmcrate/features/movies/data/model/trending_movie_api_model.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final movieRemoteDataSourceProvider = Provider(
  (ref) => MovieRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    topRatedMovieApiModel: ref.read(TopRatedMovieApiModelProvider),
    trendingMovieApiModel: ref.read(TrendingMovieApiModelProvider),
    popularMovieApiModel: ref.read(PopularMovieApiModelProvider),
    allMovieApiModel: ref.read(allMovieApiModelProvider),
    authApiModel: ref.read(authApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    topRatedHiveModel: ref.read(topRatedHiveModelProvider),
    popularHiveModel: ref.read(popularHiveModelProvider),
    trendingMovieHiveModel: ref.read(trendingHiveModelProvider),
  ),
);

class MovieRemoteDataSource {
  final Dio dio;
  final TopRatedMovieApiModel topRatedMovieApiModel;
  final TrendingMovieApiModel trendingMovieApiModel;
  final PopularMovieApiModel popularMovieApiModel;
  final AllMovieApiModel allMovieApiModel;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;
  final TopRatedHiveModel topRatedHiveModel;
  final PopularHiveModel popularHiveModel;
  final TrendingMovieHiveModel trendingMovieHiveModel;

  MovieRemoteDataSource({
    required this.dio,
    required this.topRatedMovieApiModel,
    required this.trendingMovieApiModel,
    required this.popularMovieApiModel,
    required this.allMovieApiModel,
    required this.authApiModel,
    required this.userSharedPrefs,
    required this.topRatedHiveModel,
    required this.popularHiveModel,
    required this.trendingMovieHiveModel,
  });

  Future<Either<Failure, List<TopRatedMovieEntity>>> getTopRatedMovies() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      var response = await dio.get(
        ApiEndpoints.getTopRatedMovies,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetTopRatedMovies getTopRatedMoviesDTO =
            GetTopRatedMovies.fromJson(response.data);

        final topratedEntities =
            topRatedMovieApiModel.toEntityList(getTopRatedMoviesDTO.results);

        final topHiveModels =
            topRatedHiveModel.fromApiModelList(getTopRatedMoviesDTO.results);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final box = await Hive.openBox<TopRatedHiveModel>('topRatedMovieBox');

        box.clear();
        box.addAll(topHiveModels);

        return Right(topratedEntities);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<TrendingMovieEntity>>> getTrendingMovies() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      var response = await dio.get(
        ApiEndpoints.getTrendingMovies,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetTrendingMovies getTrendingMovies =
            GetTrendingMovies.fromJson(response.data);

        var data = response.data['results'] as List<dynamic>;
        List<TrendingMovieApiModel> trending = data.map((item) {
          return TrendingMovieApiModel.fromJson(item as Map<String, dynamic>);
        }).toList();

        final trendingHiveModels =
            trendingMovieHiveModel.fromApiModelList(trending);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final box =
            await Hive.openBox<TrendingMovieHiveModel>('trendingMovieBox');

        box.clear();
        box.addAll(trendingHiveModels);

        return Right(
            trendingMovieApiModel.toEntityList(getTrendingMovies.results));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<PopularMovieEntity>>> getPopularMovies() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      var response = await dio.get(
        ApiEndpoints.getPopularMovies,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data['results'] as List<dynamic>;
        List<PopularMovieApiModel> popular = data.map((item) {
          return PopularMovieApiModel.fromJson(item as Map<String, dynamic>);
        }).toList();

        final popularEntities = popularMovieApiModel.toEntityList(popular);

        final popularmovieHiveModel =
            popularHiveModel.fromApiModelList(popular);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final box = await Hive.openBox<PopularHiveModel>('popularMovieBox');

        box.clear();
        box.addAll(popularmovieHiveModel);

        return Right(popularEntities);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<AllMovieEntity>>> getMovieDetails(int id) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      String movieDetailsEndpoint = '${ApiEndpoints.getMovieDetails}/$id';
      var response = await dio.get(
        movieDetailsEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllMoviesDTO getAllMoviesDTO =
            GetAllMoviesDTO.fromJson(response.data);

        return Right(allMovieApiModel.toEntityList(getAllMoviesDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
