import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? username;
  final String? email;
  final String? password;
  final String? confirmPassword;

  const UserEntity({
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        confirmPassword,
      ];
}
