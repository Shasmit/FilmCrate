import 'package:dartz/dartz.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/config/themes/app_themes.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';
import 'package:filmcrate/features/profile/domain/use_case/profile_use_case.dart';
import 'package:filmcrate/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../test/unit_test/movie_test.mocks.dart';
import '../test_data/profile_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProfileUseCase mockProfileUseCase;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockProfileUseCase = MockProfileUseCase();
    profileEntity = await getProfileTest();
  });

  testWidgets('Profile View', (tester) async {
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.profileRoute,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.getApplicationTheme(false),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final textButtonFinder = find.byType(TextButton);

    expect(textButtonFinder, findsNWidgets(3));
  });

  //failed test
  testWidgets('Profile View but the data does not load', (tester) async {
    when(mockProfileUseCase.getUserProfile())
        .thenAnswer((_) async => Left(Failure(error: "Invalid")));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.profileRoute,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.getApplicationTheme(false),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final textButtonFinder = find.byType(TextButton);
    expect(textButtonFinder, findsNWidgets(3));
  });
}
