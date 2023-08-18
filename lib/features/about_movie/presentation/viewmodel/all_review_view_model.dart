import 'package:filmcrate/features/about_movie/domain/use_case/all_review_use_case.dart';
import 'package:filmcrate/features/about_movie/presentation/state/all_review_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewViewModelProvider =
    StateNotifierProvider<ReviewViewModel, ReviewState>(
  (ref) => ReviewViewModel(
    ref.read(reviewUseCaseProvider),
  ),
);

class ReviewViewModel extends StateNotifier<ReviewState> {
  final ReviewUseCase reviewUseCase;

  ReviewViewModel(this.reviewUseCase)
      : super(
          ReviewState.initial(),
        );

  getAllReviews(int id) async {
    state = state.copyWith(isLoading: true);

    final result = await reviewUseCase.getAllReviews(id);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (reviews) => state = state.copyWith(
        isLoading: false,
        reviews: reviews,
        error: null,
      ),
    );
  }

  likeReview(int movieId, String reviewId) async {
    state = state.copyWith(isLoading: true);

    final result = await reviewUseCase.likeReview(movieId, reviewId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  dislikeReview(int movieId, String reviewId) async {
    state = state.copyWith(isLoading: true);

    final result = await reviewUseCase.dislikeReview(movieId, reviewId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> addReview(int movieId, String review, int rating) async {
    state = state.copyWith(isLoading: true);

    final result = await reviewUseCase.addReview(
      movieId,
      review,
      rating,
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> updateReview(
      int movieId, String review, int rating, String reviewId) async {
    state = state.copyWith(isLoading: true);

    final result = await reviewUseCase.updateReview(
      movieId,
      review,
      rating,
      reviewId,
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  deleteReview(int movieId, String reviewId) async {
    state = state.copyWith(isLoading: true);

    final result = await reviewUseCase.deleteReview(movieId, reviewId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }
}
