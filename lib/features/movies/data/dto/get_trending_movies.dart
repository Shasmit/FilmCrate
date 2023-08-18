import 'package:filmcrate/features/movies/data/model/trending_movie_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_trending_movies.g.dart';

@JsonSerializable()
class GetTrendingMovies {
  final int page;
  final List<TrendingMovieApiModel> results;

  const GetTrendingMovies({
    required this.page,
    required this.results,
  });

  Map<String, dynamic> toJson() => _$GetTrendingMoviesToJson(this);

  factory GetTrendingMovies.fromJson(Map<String, dynamic> json) =>
      _$GetTrendingMoviesFromJson(json);
}
