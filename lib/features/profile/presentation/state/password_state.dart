import '../../domain/entity/password_entity.dart';

class PasswordState {
  final bool isLoading;
  final List<PasswordEntity> passwordData;
  final String? error;

  PasswordState({
    required this.isLoading,
    required this.passwordData,
    this.error,
  });

  factory PasswordState.initial() {
    return PasswordState(isLoading: false, passwordData: []);
  }

  PasswordState copyWith({
    bool? isLoading,
    List<PasswordEntity>? passwordData,
    String? error,
  }) {
    return PasswordState(
      isLoading: isLoading ?? this.isLoading,
      passwordData: passwordData ?? this.passwordData,
      error: error ?? this.error,
    );
  }
}
