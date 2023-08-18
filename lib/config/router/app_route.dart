import 'package:filmcrate/features/about_movie/presentation/view/about_movie_view.dart';
import 'package:filmcrate/features/about_movie/presentation/view/all_reviews_view.dart';
import 'package:filmcrate/features/about_movie/presentation/view/update_review.dart';
import 'package:filmcrate/features/about_movie/presentation/view/write_review.dart';
import 'package:filmcrate/features/movies/presentation/view/movie_screen.dart';
import 'package:filmcrate/features/profile/presentation/view/edit_profile.dart';
import 'package:filmcrate/features/profile/presentation/view/profile_view.dart';
import 'package:filmcrate/features/profile/presentation/view/reset_password.dart';
import 'package:filmcrate/features/profile/presentation/view/update_password.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
import '../../features/home/presentation/view/bottom_navigation_view.dart';
import '../../features/splash/presentation/view/splash_screen_view.dart';
import '../../features/watchlist/presentation/view/watchlist_screen.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String watchlistRoute = '/watchlists';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String movieRoute = '/movies';
  static const String editprofileRoute = '/edit';
  static const String profileRoute = '/profile';
  static const String updatePassword = '/update';
  static const String resetPassword = '/reset';
  static const String allReviews = '/allReviews';
  static const String movieScreen = '/movieScreen';
  static const String writeReview = '/writeReview';
  static const String updateReview = '/updateReview';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashScreenView(),
      watchlistRoute: (context) => const WatchListScreen(),
      loginRoute: (context) => const LoginViews(),
      registerRoute: (context) => const RegisterViews(),
      dashboardRoute: (context) => const BottomNavView(),
      movieRoute: (context) => const AboutMovies(),
      movieScreen: (context) => const MovieScreen(),
      editprofileRoute: (context) => const EditProfile(),
      profileRoute: (context) => const ProfileScreen(),
      updatePassword: (context) => const UpdatePasswordView(),
      resetPassword: (context) => const ResetPassword(),
      allReviews: (context) => const AllReviewsView(),
      writeReview: (context) => const WriteReview(),
      updateReview: (context) => const UpdateReview(),
    };
  }
}
