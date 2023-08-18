import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/profile/domain/entity/password_entity.dart';
import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';
import 'package:filmcrate/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dataSource/profile_remote_data_source.dart';

final profileRemoteRepoProvider = Provider<IProfileRepository>(
  (ref) => ProfileRemoteRepositoryImpl(
    profileRemoteDataSource: ref.read(profileRemoteDataSourceProvider),
  ),
);

class ProfileRemoteRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRemoteRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, List<ProfileEntity>>> getUserProfile() {
    return profileRemoteDataSource.getUserProfile();
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(PasswordEntity password) {
    return profileRemoteDataSource.changePassword(password);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return profileRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, bool>> editProfile(
      String username, String email) async {
    return profileRemoteDataSource.editProfile(username, email);
  }
}
