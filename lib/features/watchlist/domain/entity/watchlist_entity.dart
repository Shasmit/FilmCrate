import 'package:equatable/equatable.dart';

class WatchListEntity extends Equatable {
  final String id;
  final String user;
  final String movieId;
  final MovieDetails movieDetails;
  final String timestamp;
  final int v;

  const WatchListEntity({
    required this.id,
    required this.user,
    required this.movieId,
    required this.movieDetails,
    required this.timestamp,
    required this.v,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        movieId,
        timestamp,
        v,
      ];

  factory WatchListEntity.fromJson(Map<String, dynamic> json) =>
      WatchListEntity(
        id: json["_id"],
        user: json["user"],
        movieId: json["movieId"],
        movieDetails: MovieDetails.fromJson(json["movieDetails"]),
        timestamp: json["timestamp"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "movieId": movieId,
        "movieDetails": movieDetails.toJson(),
        "timestamp": timestamp,
        "__v": v,
      };
}

class MovieDetails extends Equatable {
  final String title;
  final String posterPath;
  final String id;

  const MovieDetails({
    required this.title,
    required this.posterPath,
    required this.id,
  });

  const MovieDetails.empty()
      : this(
          title: '',
          posterPath: '',
          id: '',
        );

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        title: json["title"],
        posterPath: json["poster_path"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "poster_path": posterPath,
        "_id": id,
      };

  @override
  List<Object?> get props => [
        title,
        posterPath,
        id,
      ];
}
