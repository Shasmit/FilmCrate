import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/auth/data/dataSource/auth_local_data_source.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:filmcrate/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthLocalRepository({
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return authLocalDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return authLocalDataSource.registerUser(user);
  }
}
