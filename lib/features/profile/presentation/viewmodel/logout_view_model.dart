import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';

final logoutViewModelProvider = StateNotifierProvider<LogoutViewModel, bool>(
  (ref) => LogoutViewModel(
    ref.read(userSharedPrefsProvider),
  ),
);

class LogoutViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  LogoutViewModel(this._userSharedPrefs) : super(false);

  void logout(BuildContext context) async {
    state = true;
    showSnackBar(
        message: 'Logging out ...', context: context, color: Colors.green);

    await _userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 2000), () {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginRoute,
        (route) => false,
      );
    });
  }
}
