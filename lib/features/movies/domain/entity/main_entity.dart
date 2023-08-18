// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

abstract class MovieEntity extends Equatable {
  final int? id;
  final String? original_language;
  final String? original_title;
  final String? overview;
  final String? poster_path;
  final String? backdrop_path;
  final String? title;
  final num? vote_average;
  final String? release_date;
  final Movie? movie;
  final List<Cast>? cast;
  final List<SimilarMovies>? similarMovies;
  final List<TopReview>? topReviews;
  final bool? isWatchListed;

  const MovieEntity({
    this.id,
    this.original_language,
    this.original_title,
    this.overview,
    this.poster_path,
    this.backdrop_path,
    this.title,
    this.vote_average,
    this.release_date,
    this.movie,
    this.cast,
    this.similarMovies,
    this.topReviews,
    this.isWatchListed,
  });

  @override
  List<Object?> get props => [
        id,
        original_language,
        original_title,
        overview,
        poster_path,
        backdrop_path,
        title,
        vote_average,
        release_date,
        movie,
        cast,
        isWatchListed,
      ];
}

class AllMovieEntity extends MovieEntity {
  const AllMovieEntity({
    required int id,
    required Movie movie,
    required List<Cast> cast,
    required List<SimilarMovies> similarMovies,
    required List<TopReview> topReviews,
    required bool isWatchListed,
  }) : super(
          id: id,
          movie: movie,
          cast: cast,
          similarMovies: similarMovies,
          topReviews: topReviews,
          isWatchListed: isWatchListed,
        );

  @override
  List<Object?> get props => super.props..addAll([movie, cast]);
}

class Movie extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<Genre>? genres;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final int? runtime;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const Movie({
    this.adult,
    this.backdropPath,
    this.genres,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.runtime,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        runtime,
        tagline,
        title,
        video,
        voteAverage,
        voteCount,
      ];

  Movie.empty()
      : this(
          adult: false,
          backdropPath: '',
          genres: [],
          id: 0,
          imdbId: '',
          originalLanguage: '',
          originalTitle: '',
          overview: '',
          popularity: 0,
          posterPath: '',
          releaseDate: '',
          runtime: 0,
          tagline: '',
          title: '',
          video: false,
          voteAverage: 0,
          voteCount: 0,
        );
}

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class Cast extends Equatable {
  final int id;
  final String name;
  final String originalName;
  final int castId;

  const Cast({
    required this.id,
    required this.name,
    required this.originalName,
    required this.castId,
  });

  @override
  List<Object?> get props => [id, name, originalName, castId];
}

class SimilarMovies extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> genres;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const SimilarMovies({
    required this.adult,
    this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}

class TopReview extends Equatable {
  final String id;
  final String movieID;
  final User user;
  final int rating;
  final String review;
  final List<String> likes;
  final String createdAt;
  final int? v;
  final bool? isLiked;
  final bool? isUserLoggedIn;

  const TopReview({
    required this.id,
    required this.movieID,
    required this.user,
    required this.rating,
    required this.review,
    required this.likes,
    required this.createdAt,
    this.v,
    this.isLiked,
    this.isUserLoggedIn,
  });

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

class User extends Equatable {
  final dynamic image;
  final String id;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final int totalMoviesReviewed;
  final List<dynamic> watchlist;
  final int v;

  const User({
    this.image,
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.totalMoviesReviewed,
    required this.watchlist,
    required this.v,
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
      ];

  User.empty()
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
        );
}

class TrendingMovieEntity extends MovieEntity {
  const TrendingMovieEntity({
    required int id,
    String? original_language,
    String? original_title,
    String? overview,
    required String poster_path,
    String? backdrop_path,
    required String title,
    num? vote_average,
    String? release_date,
  }) : super(
          id: id,
          original_language: original_language,
          original_title: original_title,
          overview: overview,
          poster_path: poster_path,
          backdrop_path: backdrop_path,
          title: title,
          vote_average: vote_average,
          release_date: release_date,
        );

  factory TrendingMovieEntity.fromJson(Map<String, dynamic> json) =>
      TrendingMovieEntity(
        id: json['id'],
        original_language: json['original_language'],
        original_title: json['original_title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        backdrop_path: json['backdrop_path'],
        title: json['title'],
        vote_average: json['vote_average'],
        release_date: json['release_date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'original_language': original_language,
        'original_title': original_title,
        'overview': overview,
        'poster_path': poster_path,
        'backdrop_path': backdrop_path,
        'title': title,
        'vote_average': vote_average,
        'release_date': release_date,
      };

  @override
  String toString() {
    return 'TrendingMovieEntity(id: $id, original_language: $original_language, original_title: $original_title, overview: $overview, poster_path: $poster_path, backdrop_path: $backdrop_path, title: $title, vote_average: $vote_average, release_date: $release_date)';
  }
}

class TopRatedMovieEntity extends MovieEntity {
  // Additional properties specific to TopRatedMovieEntity

  const TopRatedMovieEntity({
    required int id,
    String? original_language,
    String? original_title,
    String? overview,
    required String poster_path,
    String? backdrop_path,
    required String title,
    num? vote_average,
    String? release_date,
    // Additional parameters specific to TopRatedMovieEntity
  }) : super(
          id: id,
          original_language: original_language,
          original_title: original_title,
          overview: overview,
          poster_path: poster_path,
          backdrop_path: backdrop_path,
          title: title,
          vote_average: vote_average,
          release_date: release_date,
        );

  factory TopRatedMovieEntity.fromJson(Map<String, dynamic> json) =>
      TopRatedMovieEntity(
        id: json['id'],
        original_language: json['original_language'],
        original_title: json['original_title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        backdrop_path: json['backdrop_path'],
        title: json['title'],
        vote_average: json['vote_average'],
        release_date: json['release_date'],
        // Additional parsing for TopRatedMovieEntity properties
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'original_language': original_language,
        'original_title': original_title,
        'overview': overview,
        'poster_path': poster_path,
        'backdrop_path': backdrop_path,
        'title': title,
        'vote_average': vote_average,
        'release_date': release_date,
        // Additional serialization for TopRatedMovieEntity properties
      };

  @override
  String toString() {
    return 'TopRatedMovieEntity(id: $id, original_language: $original_language, original_title: $original_title, overview: $overview, poster_path: $poster_path, backdrop_path: $backdrop_path, title: $title, vote_average: $vote_average, release_date: $release_date)';
  }
}

class PopularMovieEntity extends MovieEntity {
  const PopularMovieEntity({
    required int id,
    String? original_language,
    String? original_title,
    String? overview,
    required String poster_path,
    String? backdrop_path,
    required String title,
    num? vote_average,
    String? release_date,
  }) : super(
          id: id,
          original_language: original_language,
          original_title: original_title,
          overview: overview,
          poster_path: poster_path,
          backdrop_path: backdrop_path,
          title: title,
          vote_average: vote_average,
          release_date: release_date,
        );

  factory PopularMovieEntity.fromJson(Map<String, dynamic> json) =>
      PopularMovieEntity(
        id: json['id'],
        original_language: json['original_language'],
        original_title: json['original_title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        backdrop_path: json['backdrop_path'],
        title: json['title'],
        vote_average: json['vote_average'],
        release_date: json['release_date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'original_language': original_language,
        'original_title': original_title,
        'overview': overview,
        'poster_path': poster_path,
        'backdrop_path': backdrop_path,
        'title': title,
        'vote_average': vote_average,
        'release_date': release_date,
      };

  @override
  String toString() {
    return 'PopularMovieEntity(id: $id, original_language: $original_language, original_title: $original_title, overview: $overview, poster_path: $poster_path, backdrop_path: $backdrop_path, title: $title, vote_average: $vote_average, release_date: $release_date)';
  }
}
