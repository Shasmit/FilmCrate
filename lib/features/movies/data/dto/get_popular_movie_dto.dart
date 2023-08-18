import 'package:filmcrate/features/movies/data/model/popular_movie_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_popular_movie_dto.g.dart';

@JsonSerializable()
class GetPopularMovie {
  final int page;
  final List<PopularMovieApiModel> results;

  const GetPopularMovie({
    required this.page,
    required this.results,
  });

  Map<String, dynamic> toJson() => _$GetPopularMovieToJson(this);

  factory GetPopularMovie.fromJson(Map<String, dynamic> json) =>
      _$GetPopularMovieFromJson(json);
}
