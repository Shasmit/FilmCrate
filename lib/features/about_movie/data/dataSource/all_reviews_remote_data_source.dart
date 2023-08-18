import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filmcrate/config/constants/api_endpoint.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/core/shared_prefs/user_shared_prefs.dart';
import 'package:filmcrate/features/about_movie/data/dto/get_all_reviews_dto.dart';
import 'package:filmcrate/features/about_movie/data/model/reviews_api_model.dart';
import 'package:filmcrate/features/about_movie/domain/entity/review_entity.dart';
import 'package:filmcrate/features/auth/data/model/auth_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/remote/http_service.dart';

final reviewsRemoteDataSourceProvider = Provider(
  (ref) => ReviewsRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    reviewsApiModel: ref.read(reviewApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    authApiModel: ref.read(authApiModelProvider),
  ),
);

class ReviewsRemoteDataSource {
  final Dio dio;
  final ReviewsApiModel reviewsApiModel;
  final UserSharedPrefs userSharedPrefs;
  final AuthApiModel authApiModel;

  ReviewsRemoteDataSource({
    required this.dio,
    required this.reviewsApiModel,
    required this.userSharedPrefs,
    required this.authApiModel,
  });

  Future<Either<Failure, bool>> likeReview(int movieId, String reviewId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String watchlistEndpoint =
          '${ApiEndpoints.getMovieDetails}/$movieId${ApiEndpoints.getAllReviews}/$reviewId${ApiEndpoints.likeReview}';
      var response = await dio.post(
        watchlistEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
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

  Future<Either<Failure, bool>> dislikeReview(
      int movieId, String reviewId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String watchlistEndpoint =
          '${ApiEndpoints.getMovieDetails}/$movieId${ApiEndpoints.getAllReviews}/$reviewId${ApiEndpoints.dislikeReview}';
      var response = await dio.post(
        watchlistEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
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

  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(int id) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      String reviewEndPoint =
          '${ApiEndpoints.getMovieDetails}/$id${ApiEndpoints.getAllReviews}';
      var response = await dio.get(
        reviewEndPoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllReviewsDTO reviews = GetAllReviewsDTO.fromJson(response.data);

        return right(reviewsApiModel.toEntityList(reviews.data));
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

  Future<Either<Failure, bool>> deleteReview(
      int movieId, String reviewId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String addReviewEndpoint =
          '${ApiEndpoints.getMovieDetails}/$movieId${ApiEndpoints.deleteReview}/$reviewId';

      var response = await dio.delete(
        addReviewEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 204) {
        // Review deleted successfully
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
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

  Future<Either<Failure, bool>> updateReview(
      int movieId, String review, int rating, String reviewId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String addReviewEndpoint =
          '${ApiEndpoints.getMovieDetails}/$movieId${ApiEndpoints.updateReview}/$reviewId';

      var requestBody = {
        "rating": rating,
        "review": review,
      };

      var response = await dio.put(
        addReviewEndpoint,
        data: requestBody,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
        // Review added successfully
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
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

  Future<Either<Failure, bool>> addReview(
      int movieId, String review, int rating) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );

      String addReviewEndpoint =
          '${ApiEndpoints.getMovieDetails}/$movieId${ApiEndpoints.addReview}';

      var requestBody = {
        "rating": rating,
        "review": review,
      };

      var response = await dio.post(
        addReviewEndpoint,
        data: requestBody,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 201) {
        // Review added successfully
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
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
