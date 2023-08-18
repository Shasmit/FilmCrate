import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/profile/domain/entity/password_entity.dart';
import 'package:filmcrate/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/profile_entity.dart';

final profileUseCaseProvider = Provider<ProfileUseCase>(
  (ref) => ProfileUseCase(
    profileRepository: ref.watch(profileRepositoryProvider),
  ),
);

class ProfileUseCase {
  final IProfileRepository profileRepository;

  ProfileUseCase({
    required this.profileRepository,
  });

  Future<Either<Failure, List<ProfileEntity>>> getUserProfile() async {
    return await profileRepository.getUserProfile();
  }

  Future<Either<Failure, bool>> updateUserProfile(PasswordEntity password) {
    return profileRepository.updateUserProfile(password);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await profileRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> editProfile(
      String username, String email) async {
    return await profileRepository.editProfile(username, email);
  }
}
