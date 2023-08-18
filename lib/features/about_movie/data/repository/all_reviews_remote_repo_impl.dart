import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/about_movie/data/dataSource/all_reviews_remote_data_source.dart';
import 'package:filmcrate/features/about_movie/domain/entity/review_entity.dart';
import 'package:filmcrate/features/about_movie/domain/repository/all_reviews_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewRemoteRepositoryProvider = Provider<IReviewRepository>(
  (ref) => ReviewRemoteRepositoryImpl(
    reviewsRemoteDataSource: ref.read(reviewsRemoteDataSourceProvider),
  ),
);

class ReviewRemoteRepositoryImpl implements IReviewRepository {
  final ReviewsRemoteDataSource reviewsRemoteDataSource;
  ReviewRemoteRepositoryImpl({required this.reviewsRemoteDataSource});

  @override
  Future<Either<Failure, List<ReviewEntity>>> getAllReviews(int id) {
    return reviewsRemoteDataSource.getAllReviews(id);
  }

  @override
  Future<Either<Failure, bool>> likeReview(int movieId, String reviewId) {
    return reviewsRemoteDataSource.likeReview(movieId, reviewId);
  }

  @override
  Future<Either<Failure, bool>> dislikeReview(int movieId, String reviewId) {
    return reviewsRemoteDataSource.dislikeReview(movieId, reviewId);
  }

  @override
  Future<Either<Failure, bool>> addReview(
      int movieId, String review, int rating) async {
    return await reviewsRemoteDataSource.addReview(movieId, review, rating);
  }

  @override
  Future<Either<Failure, bool>> updateReview(
      int movieId, String review, int rating, String reviewId) async {
    return await reviewsRemoteDataSource.updateReview(
        movieId, review, rating, reviewId);
  }

  @override
  Future<Either<Failure, bool>> deleteReview(
      int movieId, String reviewId) async {
    return await reviewsRemoteDataSource.deleteReview(movieId, reviewId);
  }
}
