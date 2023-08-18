import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';

class ProfileState {
  final bool isLoading;
  final List<ProfileEntity> user;
  final String? error;
  final String? imageName;

  ProfileState({
    required this.isLoading,
    required this.user,
    required this.error,
    this.imageName,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      user: [],
      error: null,
      imageName: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    List<ProfileEntity>? user,
    String? error,
    String? imageName,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, user: $user, error: $error, imageName: $imageName)';
  }
}
