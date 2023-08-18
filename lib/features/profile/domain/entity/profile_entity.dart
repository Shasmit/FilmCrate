import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final dynamic image;
  final String id;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final int totalMoviesReviewed;
  final List<dynamic> watchlist;
  final int v;
  final bool? isUserLoggedIn;

  const ProfileEntity({
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

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        image: json['image'],
        id: json['_id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirmPassword'],
        totalMoviesReviewed: json['totalMoviesReviewed'],
        watchlist: json['watchlist'],
        v: json['__v'],
        isUserLoggedIn: json['isUserLoggedIn'],
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        '_id': id,
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'totalMoviesReviewed': totalMoviesReviewed,
        'watchlist': watchlist,
        '__v': v,
        'isUserLoggedIn': isUserLoggedIn,
      };

  ProfileEntity.empty()
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
}
