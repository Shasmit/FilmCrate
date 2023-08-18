import 'package:filmcrate/features/movies/data/model/movie_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_top_rated_movies.g.dart';

@JsonSerializable()
class GetTopRatedMovies {
  final int page;
  final List<TopRatedMovieApiModel> results;

  const GetTopRatedMovies({
    required this.page,
    required this.results,
  });

  Map<String, dynamic> toJson() => _$GetTopRatedMoviesToJson(this);

  factory GetTopRatedMovies.fromJson(Map<String, dynamic> json) =>
      _$GetTopRatedMoviesFromJson(json);
}
