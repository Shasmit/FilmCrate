import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        } else {
          Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      }
    });
  }

  bool isValidToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      int expirationTimestamp = decodedToken['exp'];
      final currentDate = DateTime.now().millisecondsSinceEpoch;
      // If the current date is greater than the expiration timestamp, the token is expired
      return currentDate > expirationTimestamp * 1000;
    } catch (e) {
      print('Error decoding token: $e');
      return false;
    }
  }
}
