// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_movies_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllMovieApiModel _$AllMovieApiModelFromJson(Map<String, dynamic> json) =>
    AllMovieApiModel(
      id: json['id'] as int,
      movie: MovieApiModel.fromJson(json['movie'] as Map<String, dynamic>),
      cast: (json['cast'] as List<dynamic>)
          .map((e) => CastApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      similarMovies: (json['similarMovies'] as List<dynamic>)
          .map((e) => SimilarMoviesAPiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topReviews: (json['topReviews'] as List<dynamic>)
          .map((e) => TopReviewApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isWatchListed: json['isWatchListed'] as bool,
    );

Map<String, dynamic> _$AllMovieApiModelToJson(AllMovieApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movie': instance.movie,
      'cast': instance.cast,
      'similarMovies': instance.similarMovies,
      'topReviews': instance.topReviews,
      'isWatchListed': instance.isWatchListed,
    };

MovieApiModel _$MovieApiModelFromJson(Map<String, dynamic> json) =>
    MovieApiModel(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      runtime: json['runtime'] as int?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
    );

Map<String, dynamic> _$MovieApiModelToJson(MovieApiModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genres': instance.genres,
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'runtime': instance.runtime,
      'tagline': instance.tagline,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

GenreApiModel _$GenreApiModelFromJson(Map<String, dynamic> json) =>
    GenreApiModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreApiModelToJson(GenreApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CastApiModel _$CastApiModelFromJson(Map<String, dynamic> json) => CastApiModel(
      id: json['id'] as int,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      castId: json['cast_id'] as int,
    );

Map<String, dynamic> _$CastApiModelToJson(CastApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'cast_id': instance.castId,
    };

SimilarMoviesAPiModel _$SimilarMoviesAPiModelFromJson(
        Map<String, dynamic> json) =>
    SimilarMoviesAPiModel(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genres:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String,
      title: json['title'] as String,
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$SimilarMoviesAPiModelToJson(
        SimilarMoviesAPiModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genres,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

TopReviewApiModel _$TopReviewApiModelFromJson(Map<String, dynamic> json) =>
    TopReviewApiModel(
      id: json['_id'] as String,
      movieID: json['movieID'] as String,
      user: UserApiModel.fromJson(json['user'] as Map<String, dynamic>),
      rating: json['rating'] as int,
      review: json['review'] as String,
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String,
      v: json['v'] as int?,
      isLiked: json['isLiked'] as bool?,
      isUserLoggedIn: json['isUserLoggedIn'] as bool?,
    );

Map<String, dynamic> _$TopReviewApiModelToJson(TopReviewApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'movieID': instance.movieID,
      'user': instance.user,
      'rating': instance.rating,
      'review': instance.review,
      'likes': instance.likes,
      'createdAt': instance.createdAt,
      'v': instance.v,
      'isLiked': instance.isLiked,
      'isUserLoggedIn': instance.isUserLoggedIn,
    };

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      image: json['image'],
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      totalMoviesReviewed: json['totalMoviesReviewed'] as int,
      watchlist: json['watchlist'] as List<dynamic>,
      v: json['__v'] as int,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
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
    };
