import '../../domain/entity/review_entity.dart';

class ReviewState {
  final bool isLoading;
  final List<ReviewEntity> reviews;
  final String? error;

  ReviewState({
    required this.isLoading,
    required this.reviews,
    required this.error,
  });

  factory ReviewState.initial() {
    return ReviewState(
      isLoading: false,
      reviews: [],
      error: null,
    );
  }

  ReviewState copyWith({
    bool? isLoading,
    List<ReviewEntity>? reviews,
    String? error,
  }) {
    return ReviewState(
      isLoading: isLoading ?? this.isLoading,
      reviews: reviews ?? this.reviews,
      error: error ?? this.error,
    );
  }
}
