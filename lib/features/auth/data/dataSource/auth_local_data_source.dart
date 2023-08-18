import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/core/network/local/hive_service.dart';
import 'package:filmcrate/features/auth/data/model/auth_hive_model.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider(
  (ref) => AuthLocalDataSource(
    hiveService: ref.read(hiveServiceProvider),
    authHiveModel: ref.read(authHiveModelProvider),
  ),
);

class AuthLocalDataSource {
  final HiveService hiveService;
  final AuthHiveModel authHiveModel;

  AuthLocalDataSource({
    required this.hiveService,
    required this.authHiveModel,
  });

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    try {
      await hiveService.addUser(authHiveModel.toHiveModel(user));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
      String username, String password) async {
    try {
      AuthHiveModel? users = await hiveService.login(username, password);
      if (users == null) {
        return Left(Failure(error: 'Username or password is wrong'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
