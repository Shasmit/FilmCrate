import 'package:json_annotation/json_annotation.dart';

import '../model/search_api_model.dart';

part 'search_movies_dto.g.dart';

@JsonSerializable()
class GetSearchedMovies {
  final int page;
  final List<SearchApiModel> results;

  const GetSearchedMovies({
    required this.page,
    required this.results,
  });

  Map<String, dynamic> toJson() => _$GetSearchedMoviesToJson(this);

  factory GetSearchedMovies.fromJson(Map<String, dynamic> json) =>
      _$GetSearchedMoviesFromJson(json);
}
