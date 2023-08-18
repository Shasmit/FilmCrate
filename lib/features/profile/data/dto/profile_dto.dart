import 'package:json_annotation/json_annotation.dart';

import '../model/profile_api_model.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class GetProfileDetials {
  final List<ProfileApiModel> user;

  const GetProfileDetials({
    required this.user,
  });

  Map<String, dynamic> toJson() => _$GetProfileDetialsToJson(this);

  factory GetProfileDetials.fromJson(Map<String, dynamic> json) =>
      _$GetProfileDetialsFromJson(json);
}
