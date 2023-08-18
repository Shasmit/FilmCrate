import 'package:dartz/dartz.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/repository/auth_repository.dart';
import '../dataSource/auth_remote_data_source.dart';

final authRemoteRepositoryProvider =
    Provider.autoDispose<IAuthRepository>((ref) {
  return AuthRemoteRepository(ref.read(authRemoteDataSourceProvider));
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return _authRemoteDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }
}
