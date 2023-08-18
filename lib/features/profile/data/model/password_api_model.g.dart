// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordApiModel _$PasswordApiModelFromJson(Map<String, dynamic> json) =>
    PasswordApiModel(
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$PasswordApiModelToJson(PasswordApiModel instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
