import 'package:equatable/equatable.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_movies_api_model.g.dart';

final allMovieApiModelProvider = Provider<AllMovieApiModel>(
  (ref) => AllMovieApiModel.empty(),
);

@JsonSerializable()
class AllMovieApiModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'movie')
  final MovieApiModel movie;
  @JsonKey(name: 'cast')
  final List<CastApiModel> cast;
  @JsonKey(name: 'similarMovies')
  final List<SimilarMoviesAPiModel> similarMovies;
  @JsonKey(name: 'topReviews')
  final List<TopReviewApiModel> topReviews;
  @JsonKey(name: 'isWatchListed')
  final bool isWatchListed;

  const AllMovieApiModel({
    required this.id,
    required this.movie,
    required this.cast,
    required this.similarMovies,
    required this.topReviews,
    required this.isWatchListed,
  });

  factory AllMovieApiModel.empty() => AllMovieApiModel(
        id: 0,
        movie: MovieApiModel.empty(),
        cast: const [],
        similarMovies: const [],
        topReviews: const [],
        isWatchListed: false,
      );

  @override
  List<Object?> get props =>
      [id, movie, cast, similarMovies, topReviews, isWatchListed];

  factory AllMovieApiModel.fromJson(Map<String, dynamic> json) =>
      _$AllMovieApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllMovieApiModelToJson(this);

  AllMovieEntity toEntity() {
    return AllMovieEntity(
      id: id,
      movie: movie.toEntity(),
      cast: cast.map((cast) => cast.toEntity()).toList(),
      similarMovies: similarMovies.map((movie) => movie.toEntity()).toList(),
      topReviews: topReviews.map((review) => review.toEntity()).toList(),
      isWatchListed: isWatchListed,
    );
  }

  AllMovieApiModel fromEntity(AllMovieEntity entity) {
    return AllMovieApiModel(
      id: entity.id ?? 0,
      movie: MovieApiModel.fromEntity(entity.movie ?? Movie.empty()),
      cast: entity.cast!.map((cast) => CastApiModel.fromEntity(cast)).toList(),
      similarMovies: entity.similarMovies!
          .map((movie) => SimilarMoviesAPiModel.fromEntity(movie))
          .toList(),
      topReviews: entity.topReviews!
          .map((review) => TopReviewApiModel.fromEntity(review))
          .toList(),
      isWatchListed: entity.isWatchListed ?? false,
    );
  }

  List<AllMovieEntity> toEntityList(List<AllMovieApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}

@JsonSerializable()
class MovieApiModel extends Equatable {
  @JsonKey(name: 'adult')
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genres')
  final List<GenreApiModel>? genres;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'popularity')
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'runtime')
  final int? runtime;
  @JsonKey(name: 'tagline')
  final String? tagline;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'video')
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  const MovieApiModel({
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

  factory MovieApiModel.empty() => const MovieApiModel(
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

  factory MovieApiModel.fromJson(Map<String, dynamic> json) =>
      _$MovieApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieApiModelToJson(this);
  Movie toEntity() {
    return Movie(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres!.map((genre) => genre.toEntity()).toList(),
      id: id,
      imdbId: imdbId,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      runtime: runtime,
      tagline: tagline,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  static MovieApiModel fromEntity(Movie entity) {
    return MovieApiModel(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      genres: entity.genres!
          .map((genre) => GenreApiModel.fromEntity(genre))
          .toList(),
      id: entity.id,
      imdbId: entity.imdbId,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      runtime: entity.runtime,
      tagline: entity.tagline,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }

  List<Movie> toEntityList(List<MovieApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}

@JsonSerializable()
class GenreApiModel extends Equatable {
  final int id;
  final String name;

  const GenreApiModel({
    required this.id,
    required this.name,
  });

  const GenreApiModel.empty()
      : id = 0,
        name = '';

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toJson() => _$GenreApiModelToJson(this);

  factory GenreApiModel.fromJson(Map<String, dynamic> json) =>
      _$GenreApiModelFromJson(json);

  Genre toEntity() {
    return Genre(
      id: id,
      name: name,
    );
  }

  static GenreApiModel fromEntity(Genre entity) {
    return GenreApiModel(
      id: entity.id,
      name: entity.name,
    );
  }

  List<Genre> toEntityList(List<GenreApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}

@JsonSerializable()
class CastApiModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'original_name')
  final String originalName;
  @JsonKey(name: 'cast_id')
  final int castId;

  const CastApiModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.castId,
  });

  const CastApiModel.empty()
      : id = 0,
        name = '',
        originalName = '',
        castId = 0;

  @override
  List<Object?> get props => [id, name, originalName, castId];

  Map<String, dynamic> toJson() => _$CastApiModelToJson(this);

  factory CastApiModel.fromJson(Map<String, dynamic> json) =>
      _$CastApiModelFromJson(json);

  Cast toEntity() {
    return Cast(
      id: id,
      name: name,
      originalName: originalName,
      castId: castId,
    );
  }

  static CastApiModel fromEntity(Cast entity) {
    return CastApiModel(
      id: entity.id,
      name: entity.name,
      originalName: entity.originalName,
      castId: entity.castId,
    );
  }

  List<Cast> toEntityList(List<CastApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}

@JsonSerializable()
class SimilarMoviesAPiModel extends Equatable {
  @JsonKey(name: 'adult')
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genres;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  @JsonKey(name: 'overview')
  final String overview;
  @JsonKey(name: 'popularity')
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'video')
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  const SimilarMoviesAPiModel({
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

  factory SimilarMoviesAPiModel.fromJson(Map<String, dynamic> json) =>
      _$SimilarMoviesAPiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarMoviesAPiModelToJson(this);

  SimilarMovies toEntity() {
    return SimilarMovies(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres,
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  static SimilarMoviesAPiModel fromEntity(SimilarMovies entity) {
    return SimilarMoviesAPiModel(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      genres: entity.genres,
      id: entity.id,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }

  List<SimilarMovies> toEntityList(List<SimilarMoviesAPiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

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

@JsonSerializable()
class TopReviewApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String movieID;
  final UserApiModel user;
  final int rating;
  final String review;
  final List<String> likes;
  final String createdAt;
  final int? v;
  final bool? isLiked;
  final bool? isUserLoggedIn;

  const TopReviewApiModel({
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

  factory TopReviewApiModel.fromJson(Map<String, dynamic> json) =>
      _$TopReviewApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopReviewApiModelToJson(this);

  TopReview toEntity() {
    return TopReview(
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

  static TopReviewApiModel fromEntity(TopReview entity) {
    return TopReviewApiModel(
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

  List<TopReview> toEntityList(List<TopReviewApiModel> models) {
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

@JsonSerializable()
class UserApiModel extends Equatable {
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

  const UserApiModel({
    required this.image,
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.totalMoviesReviewed,
    required this.watchlist,
    required this.v,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  factory UserApiModel.empty() => const UserApiModel(
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

  User toEntity() {
    return User(
      image: image,
      id: id,
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      totalMoviesReviewed: totalMoviesReviewed,
      watchlist: watchlist,
      v: v,
    );
  }

  static UserApiModel fromEntity(User entity) {
    return UserApiModel(
      image: entity.image,
      id: entity.id,
      username: entity.username,
      email: entity.email,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
      totalMoviesReviewed: entity.totalMoviesReviewed,
      watchlist: entity.watchlist,
      v: entity.v,
    );
  }

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
}
