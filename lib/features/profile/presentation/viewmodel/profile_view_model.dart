import 'dart:io';

import 'package:filmcrate/core/common/snackbar/my_snackbar.dart';
import 'package:filmcrate/features/profile/domain/use_case/profile_use_case.dart';
import 'package:filmcrate/features/profile/presentation/state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>(
  (ref) => ProfileViewModel(
    ref.read(profileUseCaseProvider),
  ),
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileViewModel(this.profileUseCase) : super(ProfileState.initial()) {
    getUserProfile();
  }

  void resetState() {
    state = ProfileState.initial();
  }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> editProfile(
      String username, String email, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.editProfile(username, email);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showSnackBar(message: l.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Profile updated successfully',
          context: context,
        );
      },
    );
  }

  Future<void> getUserProfile() async {
    state = state.copyWith(isLoading: true);

    final result = await profileUseCase.getUserProfile();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (user) => state = state.copyWith(
        isLoading: false,
        user: user,
        error: null,
      ),
    );
  }

  void fetchUserProfile() {
    getUserProfile();
  }
}
