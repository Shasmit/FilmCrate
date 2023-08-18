import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/about_movie/domain/repository/all_reviews_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/review_entity.dart';

final reviewUseCaseProvider = Provider<ReviewUseCase>(
  (ref) => ReviewUseCase(
    reviewRepository: ref.watch(reviewRepositoryProvider),
  ),
);

class ReviewUseCase {
  final IReviewRepository reviewRepository;

  ReviewUseCase({required this.reviewRepository});

  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(int id) async {
    return await reviewRepository.getAllReviews(id);
  }

  Future<Either<Failure, bool>> likeReview(int movieId, String reviewId) async {
    return await reviewRepository.likeReview(movieId, reviewId);
  }

  Future<Either<Failure, bool>> dislikeReview(
      int movieId, String reviewId) async {
    return await reviewRepository.dislikeReview(movieId, reviewId);
  }

  Future<Either<Failure, bool>> addReview(
      int movieId, String review, int rating) async {
    return await reviewRepository.addReview(movieId, review, rating);
  }

  Future<Either<Failure, bool>> updateReview(
      int movieId, String review, int rating, String reviewId) async {
    return await reviewRepository.updateReview(
        movieId, review, rating, reviewId);
  }

  Future<Either<Failure, bool>> deleteReview(
      int movieId, String reviewId) async {
    return await reviewRepository.deleteReview(movieId, reviewId);
  }
}
