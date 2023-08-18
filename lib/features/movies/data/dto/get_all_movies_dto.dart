import 'package:json_annotation/json_annotation.dart';

import '../model/all_movies_api_model.dart';

part 'get_all_movies_dto.g.dart';

@JsonSerializable()
class GetAllMoviesDTO {
  final List<AllMovieApiModel> data;

  const GetAllMoviesDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllMoviesDTOToJson(this);

  factory GetAllMoviesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllMoviesDTOFromJson(json);
}
