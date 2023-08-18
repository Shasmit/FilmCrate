import 'package:equatable/equatable.dart';

import '../../../movies/domain/entity/main_entity.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String movieID;
  final User user;
  final int rating;
  final String review;
  final List<String> likes;
  final String createdAt;
  final int v;
  final bool? isLiked;
  final bool? isUserLoggedIn;

  const ReviewEntity({
    required this.id,
    required this.movieID,
    required this.user,
    required this.rating,
    required this.review,
    required this.likes,
    required this.createdAt,
    required this.v,
    this.isLiked,
    this.isUserLoggedIn,
  });

  ReviewEntity.empty()
      : this(
          id: '',
          movieID: '',
          user: User.empty(),
          rating: 0,
          review: '',
          likes: [],
          createdAt: '',
          v: 0,
          isLiked: false,
          isUserLoggedIn: false,
        );

  @override
  List<Object?> get props => [
        id,
        movieID,
        user,
        rating,
        review,
        likes,
        createdAt,
        v,
        isLiked,
        isUserLoggedIn,
      ];
}
