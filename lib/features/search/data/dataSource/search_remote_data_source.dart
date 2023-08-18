import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/core/network/remote/http_service.dart';
import 'package:filmcrate/core/shared_prefs/user_shared_prefs.dart';
import 'package:filmcrate/features/auth/data/model/auth_api_model.dart';
import 'package:filmcrate/features/search/data/dto/search_movies_dto.dart';
import 'package:filmcrate/features/search/data/model/search_api_model.dart';
import 'package:filmcrate/features/search/domain/entity/search_movies_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';

final searchRemoteDataSourceProvider = Provider(
  (ref) => SearchRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    searchApiModel: ref.read(searchApiModelProvider),
    authApiModel: ref.read(authApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class SearchRemoteDataSource {
  final Dio dio;
  final SearchApiModel searchApiModel;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  SearchRemoteDataSource({
    required this.dio,
    required this.searchApiModel,
    required this.authApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<SearchEntity>>> getSearchedMovies(
      String name) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      String serachEndPoint = '${ApiEndpoints.searchMovies}/$name';

      var response = await dio.get(
        serachEndPoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetSearchedMovies getSearchedMovies =
            GetSearchedMovies.fromJson(response.data);

        return Right(searchApiModel.toEntityList(getSearchedMovies.results));
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
