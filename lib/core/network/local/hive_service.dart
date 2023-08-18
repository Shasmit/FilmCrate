import 'package:filmcrate/features/auth/data/model/auth_hive_model.dart';
import 'package:filmcrate/features/movies/data/model/popular_hive_model.dart';
import 'package:filmcrate/features/movies/data/model/top_rated_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constants/hive_table_constant.dart';
import '../../../features/movies/data/model/trending_hive_model.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(TopRatedHiveModelAdapter());
    Hive.registerAdapter(TrendingMovieHiveModelAdapter());
    Hive.registerAdapter(PopularHiveModelAdapter());

    // Add dummy data
    // await addDummyTopRated();
    // await addDummyTrending();
  }

  // ======================== Toprated Movies Queries ========================

  Future<List<TopRatedHiveModel>> getTopRatedMovies() async {
    var box = await Hive.openBox<TopRatedHiveModel>(
        HiveTableConstant.topRatedMovieBox);
    var toprated = box.values.toList();
    box.close();
    return toprated;
  }

  // ======================== Popular Movies Queries ========================

  Future<List<PopularHiveModel>> getPopularMovies() async {
    var box =
        await Hive.openBox<PopularHiveModel>(HiveTableConstant.popularMovieBox);
    var popular = box.values.toList();
    box.close();
    return popular;
  }

  // ======================== Trending Movie Queries ========================

  Future<List<TrendingMovieHiveModel>> getTrendingMovies() async {
    var box = await Hive.openBox<TrendingMovieHiveModel>(
        HiveTableConstant.trendingMovieBox);
    var trending = box.values.toList();
    box.close();
    return trending;
  }

  // ======================== Student Queries ========================
  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.username, user);
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  //Login
  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  // // ======================== Insert Dummy Data ========================
  // // Toprated Dummy Data
  // Future<void> addDummyTopRated() async {
  //   // check of batch box is empty
  //   var box = await Hive.openBox<TopRatedHiveModel>(
  //       HiveTableConstant.topRatedMovieBox);
  //   if (box.isEmpty) {
  //     TopRatedHiveModel topRated1 = const TopRatedHiveModel(
  //         id: 1,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TopRatedHiveModel topRated2 = const TopRatedHiveModel(
  //         id: 2,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TopRatedHiveModel topRated3 = const TopRatedHiveModel(
  //         id: 3,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TopRatedHiveModel topRated4 = const TopRatedHiveModel(
  //         id: 4,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TopRatedHiveModel topRated5 = const TopRatedHiveModel(
  //         id: 5,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     List<TopRatedHiveModel> toprateds = [
  //       topRated1,
  //       topRated2,
  //       topRated3,
  //       topRated4,
  //       topRated5
  //     ];

  //     // Insert batch with key
  //     for (var toprated in toprateds) {
  //       await addTopRatedMovies(toprated);
  //     }
  //   }
  // }

  // Future<void> addDummyTrending() async {
  //   // check of batch box is empty
  //   var box = await Hive.openBox<TrendingMovieHiveModel>(
  //       HiveTableConstant.trendingMovieBox);
  //   if (box.isEmpty) {
  //     TrendingMovieHiveModel trending1 = const TrendingMovieHiveModel(
  //         id: 1,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TrendingMovieHiveModel trending2 = const TrendingMovieHiveModel(
  //         id: 2,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TrendingMovieHiveModel trending3 = const TrendingMovieHiveModel(
  //         id: 3,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TrendingMovieHiveModel trending4 = const TrendingMovieHiveModel(
  //         id: 4,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     TrendingMovieHiveModel trending5 = const TrendingMovieHiveModel(
  //         id: 5,
  //         original_language: 'en',
  //         original_title: 'Banshees',
  //         overview: 'Some overview',
  //         poster_path: 'Some path',
  //         backdrop_path: 'Some path',
  //         title: 'Banshees',
  //         vote_average: 5,
  //         release_date: '2021-09-09');

  //     List<TrendingMovieHiveModel> trendings = [
  //       trending1,
  //       trending2,
  //       trending3,
  //       trending4,
  //       trending5
  //     ];

  //     // Insert batch with key
  //     for (var trending in trendings) {
  //       await addTrendingMovies(trending);
  //     }
  //   }
  // }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.topRatedMovieBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.trendingMovieBox);
    await Hive.deleteFromDisk();
  }
}
