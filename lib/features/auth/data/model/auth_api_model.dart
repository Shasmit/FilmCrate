import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) {
  return AuthApiModel(
    username: '',
    email: '',
    password: '',
    confirmPassword: '',
  );
});

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'confirmPassword')
  final String? confirmPassword;

  AuthApiModel({
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // convert AuthApiModel to AuthEntity
  UserEntity toEntity() => UserEntity(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

  // Convert AuthApiModel list to AuthEntity list
  List<UserEntity> listFromJson(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'AuthApiModel(username: $username, email: $email, password: $password, confirmPassword: $confirmPassword)';
  }
}
