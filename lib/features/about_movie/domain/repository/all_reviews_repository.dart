import 'package:dartz/dartz.dart';
import 'package:filmcrate/features/about_movie/domain/entity/review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/all_reviews_remote_repo_impl.dart';

final reviewRepositoryProvider = Provider<IReviewRepository>(
  (ref) => ref.watch(reviewRemoteRepositoryProvider),
);

abstract class IReviewRepository {
  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(int id);
  Future<Either<Failure, bool>> likeReview(int movieId, String reviewId);
  Future<Either<Failure, bool>> dislikeReview(int movieId, String reviewId);
  Future<Either<Failure, bool>> addReview(
      int movieId, String review, int rating);
  Future<Either<Failure, bool>> updateReview(
      int movieId, String review, int rating, String reviewId);

  Future<Either<Failure, bool>> deleteReview(int movieId, String reviewId);
}
