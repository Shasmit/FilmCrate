import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../config/constants/hive_table_constant.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String? username;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? password;

  @HiveField(3)
  final String? confirmPassword;

  AuthHiveModel({
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
  });

  AuthHiveModel.empty()
      : this(
          username: '',
          email: '',
          password: '',
          confirmPassword: '',
        );

  UserEntity toEntity() => UserEntity(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

  AuthHiveModel toHiveModel(UserEntity entity) => AuthHiveModel(
        username: entity.username,
        email: entity.email,
        password: entity.password,
        confirmPassword: entity.confirmPassword,
      );

  List<AuthHiveModel> toHiveModelList(List<UserEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'AuthHiveModel(username: $username, email: $email, password: $password, confirmPassword: $confirmPassword)';
  }
}
