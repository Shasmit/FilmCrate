import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/core/common/snackbar/my_snackbar.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/auth_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState(isLoading: false));

  Future<void> registerUser(BuildContext context, UserEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
            message: failure.error.toString(),
            context: context,
            color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Registered successfully',
          context: context,
        );
        Navigator.pushNamed(context, AppRoute.loginRoute);
      },
    );
  }

  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.loginUser(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Navigator.pushNamed(context, AppRoute.dashboardRoute);

        showSnackBar(
          message: 'Login successfully',
          context: context,
        );
      },
    );
  }
}
