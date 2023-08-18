// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileApiModel _$ProfileApiModelFromJson(Map<String, dynamic> json) =>
    ProfileApiModel(
      image: json['image'],
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      totalMoviesReviewed: json['totalMoviesReviewed'] as int,
      watchlist: json['watchlist'] as List<dynamic>,
      v: json['__v'] as int,
      isUserLoggedIn: json['isUserLoggedIn'] as bool?,
    );

Map<String, dynamic> _$ProfileApiModelToJson(ProfileApiModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'totalMoviesReviewed': instance.totalMoviesReviewed,
      'watchlist': instance.watchlist,
      '__v': instance.v,
      'isUserLoggedIn': instance.isUserLoggedIn,
    };
