import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/common/provider/internet_connectivity.dart';
import 'package:filmcrate/features/auth/data/dataSource/auth_local_data_source.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_remote_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) {
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      return ref.read(authRemoteRepositoryProvider);
    } else {
      return ref.read(
          authLocalDataSourceProvider as ProviderListenable<IAuthRepository>);
    }
  },
);

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
}
