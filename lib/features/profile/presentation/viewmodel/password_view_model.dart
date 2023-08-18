import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/password_entity.dart';
import '../../domain/use_case/profile_use_case.dart';
import '../state/password_state.dart';

final passwordViewModelProvider =
    StateNotifierProvider<PasswordViewModel, PasswordState>(
  (ref) => PasswordViewModel(ref.read(profileUseCaseProvider)),
);

class PasswordViewModel extends StateNotifier<PasswordState> {
  final ProfileUseCase profileUseCase;

  PasswordViewModel(this.profileUseCase) : super(PasswordState.initial());

  changePassword(PasswordEntity password, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.updateUserProfile(password);

    data.fold((l) {
      state = state.copyWith(
        isLoading: false,
        error: l.error,
      );
      showSnackBar(
        message: l.error,
        context: context,
        color: Colors.red,
      );
    }, (r) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
      showSnackBar(
        message: 'Password changed successfully',
        context: context,
      );
      Navigator.pushNamed(context, AppRoute.loginRoute);
    });
  }
}
