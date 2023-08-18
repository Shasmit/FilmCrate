import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/password_entity.dart';

part 'password_api_model.g.dart';

final passwordApiModelProvider =
    Provider<PasswordApiModel>((ref) => const PasswordApiModel.empty());

@JsonSerializable()
class PasswordApiModel extends Equatable {
  final String? oldPassword;
  final String? newPassword;
  final String? confirmPassword;

  const PasswordApiModel({
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  });

  const PasswordApiModel.empty()
      : oldPassword = '',
        newPassword = '',
        confirmPassword = '';

  // Convert API Object to Entity
  PasswordEntity toEntity() => PasswordEntity(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

  // Convert Entity to API Object
  PasswordApiModel fromEntity(PasswordEntity entity) => PasswordApiModel(
        oldPassword: entity.oldPassword!,
        newPassword: entity.newPassword!,
        confirmPassword: entity.confirmPassword!,
      );

  // Convert API List to Entity List
  List<PasswordEntity> toEntityList(List<PasswordApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
        confirmPassword,
      ];

  factory PasswordApiModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordApiModelToJson(this);
}
