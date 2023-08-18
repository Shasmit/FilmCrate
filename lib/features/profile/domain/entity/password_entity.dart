import 'package:equatable/equatable.dart';

class PasswordEntity extends Equatable {
  final String? oldPassword;
  final String? newPassword;
  final String? confirmPassword;

  const PasswordEntity({
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  });

  factory PasswordEntity.fromJson(Map<String, dynamic> json) => PasswordEntity(
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
        confirmPassword: json["confirmPassword"],
      );

  Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      };

  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
        confirmPassword,
      ];
}
