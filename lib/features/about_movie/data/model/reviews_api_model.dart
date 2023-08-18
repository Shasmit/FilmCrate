import 'package:equatable/equatable.dart';
import 'package:filmcrate/features/about_movie/domain/entity/review_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../movies/data/model/all_movies_api_model.dart';

part 'reviews_api_model.g.dart';

final reviewApiModelProvider = Provider<ReviewsApiModel>(
  (ref) => ReviewsApiModel.empty(),
);

@JsonSerializable()
class ReviewsApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String movieID;
  final UserApiModel user;
  final int rating;
  final String review;
  final List<String> likes;
  final String createdAt;
  @JsonKey(name: '__v')
  final int v;
  final bool? isLiked;
  final bool? isUserLoggedIn;

  const ReviewsApiModel({
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

  factory ReviewsApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewsApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsApiModelToJson(this);

  factory ReviewsApiModel.empty() => ReviewsApiModel(
        id: '',
        movieID: '',
        user: UserApiModel.empty(),
        rating: 0,
        review: '',
        likes: const [],
        createdAt: '',
        v: 0,
        isLiked: false,
        isUserLoggedIn: false,
      );

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      movieID: movieID,
      user: user.toEntity(),
      rating: rating,
      review: review,
      likes: likes,
      createdAt: createdAt,
      v: v,
      isLiked: isLiked,
      isUserLoggedIn: isUserLoggedIn,
    );
  }

  static ReviewsApiModel fromEntity(ReviewEntity entity) {
    return ReviewsApiModel(
      id: entity.id,
      movieID: entity.movieID,
      user: UserApiModel.fromEntity(entity.user),
      rating: entity.rating,
      review: entity.review,
      likes: entity.likes,
      createdAt: entity.createdAt,
      v: entity.v,
      isLiked: entity.isLiked,
      isUserLoggedIn: entity.isUserLoggedIn,
    );
  }

  List<ReviewEntity> toEntityList(List<ReviewsApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

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
