import 'package:equatable/equatable.dart';
import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_api_model.g.dart';

final profileApiModelProvider = Provider<ProfileApiModel>(
  (ref) => ProfileApiModel.empty(),
);

@JsonSerializable()
class ProfileApiModel extends Equatable {
  @JsonKey(name: 'image')
  final dynamic image;

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'confirmPassword')
  final String confirmPassword;

  @JsonKey(name: 'totalMoviesReviewed')
  final int totalMoviesReviewed;

  @JsonKey(name: 'watchlist')
  final List<dynamic> watchlist;

  @JsonKey(name: '__v')
  final int v;

  @JsonKey(name: 'isUserLoggedIn')
  final bool? isUserLoggedIn;

  const ProfileApiModel({
    this.image,
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.totalMoviesReviewed,
    required this.watchlist,
    required this.v,
    this.isUserLoggedIn,
  });

  ProfileApiModel.empty()
      : this(
          image: '',
          id: '',
          username: '',
          email: '',
          password: '',
          confirmPassword: '',
          totalMoviesReviewed: 0,
          watchlist: [],
          v: 0,
          isUserLoggedIn: false,
        );

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  ProfileEntity toEntity() => ProfileEntity(
        image: image,
        id: id,
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        totalMoviesReviewed: totalMoviesReviewed,
        watchlist: watchlist,
        v: v,
        isUserLoggedIn: isUserLoggedIn,
      );

  ProfileApiModel fromEntity(ProfileEntity entity) => ProfileApiModel(
        image: image ?? '',
        id: id,
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        totalMoviesReviewed: totalMoviesReviewed,
        watchlist: watchlist,
        v: v,
        isUserLoggedIn: isUserLoggedIn,
      );

  List<ProfileEntity> toEntityList(List<ProfileApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        image,
        id,
        username,
        email,
        password,
        confirmPassword,
        totalMoviesReviewed,
        watchlist,
        v,
        isUserLoggedIn,
      ];
}
