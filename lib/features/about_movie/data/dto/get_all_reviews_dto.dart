import 'package:filmcrate/features/about_movie/data/model/reviews_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_reviews_dto.g.dart';

@JsonSerializable()
class GetAllReviewsDTO {
  final List<ReviewsApiModel> data;

  const GetAllReviewsDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllReviewsDTOToJson(this);

  factory GetAllReviewsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllReviewsDTOFromJson(json);
}
