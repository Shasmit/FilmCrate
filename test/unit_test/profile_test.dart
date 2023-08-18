import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';
import 'package:filmcrate/features/profile/domain/use_case/profile_use_case.dart';
import 'package:filmcrate/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/profile_entity_test.dart';
import 'movie_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late ProfileUseCase mockProfileUseCase;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockProfileUseCase = MockProfileUseCase();
    profileEntity = await getProfileTest();
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => const Right([]));

    container = ProviderContainer(
      overrides: [
        profileViewModelProvider.overrideWith(
          (ref) => ProfileViewModel(mockProfileUseCase),
        )
      ],
    );
  });

  test('check profile initial state', () async {
    await container.read(profileViewModelProvider.notifier).getUserProfile();

    final profileState = container.read(profileViewModelProvider);
    expect(profileState.isLoading, false);
    expect(profileState.user, isEmpty);
  });

  test('should get profile', () async {
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) => Future.value(Right(profileEntity)));

    await container.read(profileViewModelProvider.notifier).getUserProfile();

    final profileState = container.read(profileViewModelProvider);

    expect(profileState.isLoading, false);
    expect(profileState.user.length, 1);
  });

  tearDownAll(() {
    container.dispose();
  });

  test('should not get profile', () async {
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) => Future.value(Left(Failure(error: "Invalid"))));

    await container.read(profileViewModelProvider.notifier).getUserProfile();

    final profileState = container.read(profileViewModelProvider);

    expect(profileState.isLoading, false);
    expect(profileState.error, isNull);
    //test fail garna isNotNull ko satta isNull rakhney
  });

  tearDownAll(() {
    container.dispose();
  });
}
