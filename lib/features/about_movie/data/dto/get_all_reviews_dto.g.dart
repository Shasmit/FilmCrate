// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_reviews_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllReviewsDTO _$GetAllReviewsDTOFromJson(Map<String, dynamic> json) =>
    GetAllReviewsDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => ReviewsApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllReviewsDTOToJson(GetAllReviewsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
