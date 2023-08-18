// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsApiModel _$ReviewsApiModelFromJson(Map<String, dynamic> json) =>
    ReviewsApiModel(
      id: json['_id'] as String,
      movieID: json['movieID'] as String,
      user: UserApiModel.fromJson(json['user'] as Map<String, dynamic>),
      rating: json['rating'] as int,
      review: json['review'] as String,
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String,
      v: json['__v'] as int,
      isLiked: json['isLiked'] as bool?,
      isUserLoggedIn: json['isUserLoggedIn'] as bool?,
    );

Map<String, dynamic> _$ReviewsApiModelToJson(ReviewsApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'movieID': instance.movieID,
      'user': instance.user,
      'rating': instance.rating,
      'review': instance.review,
      'likes': instance.likes,
      'createdAt': instance.createdAt,
      '__v': instance.v,
      'isLiked': instance.isLiked,
      'isUserLoggedIn': instance.isUserLoggedIn,
    };
