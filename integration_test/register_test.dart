import 'package:dartz/dartz.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/config/themes/app_themes.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:filmcrate/features/auth/domain/use_case/auth_usecase.dart';
import 'package:filmcrate/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/unit_test/auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])

//chalo

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;

  late UserEntity authEntity;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();

      authEntity = const UserEntity(
        username: 'achyut',
        email: 'achyut@gmail.com',
        password: 'achyut123',
        confirmPassword: 'achyut123',
      );
    },
  );

  //passed test case
  testWidgets('register a user with correct details ...', (tester) async {
    when(mockAuthUsecase.registerUser(authEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getApplicationRoute(),
          debugShowCheckedModeBanner: false,
          theme: AppThemes.getApplicationTheme(false),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'achyut');

    await tester.enterText(
        find.byType(TextFormField).at(1), 'achyut@gmail.com');

    await tester.enterText(find.byType(TextFormField).at(2), 'achyut123');

    await tester.enterText(find.byType(TextFormField).at(3), 'achyut123');

    //=========================== Find the register button===========================
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'REGISTER');

    await tester.dragUntilVisible(
      registerButtonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(201.4, 574.7), // delta to move
    );

    await tester.tap(registerButtonFinder);

    await tester.pump();

    // Check weather the snackbar is displayed or not
    expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);

    expect(find.text('Username'), findsOneWidget);
  });

  //failed test case
  testWidgets('register a user but pass it as invalid', (tester) async {
    when(mockAuthUsecase.registerUser(authEntity))
        .thenAnswer((_) async => Left(Failure(error: 'Invalid registration')));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'achyut');

    await tester.enterText(
        find.byType(TextFormField).at(1), 'achyut@gmail.com');

    await tester.enterText(find.byType(TextFormField).at(2), 'achyut123');

    await tester.enterText(find.byType(TextFormField).at(3), 'achyut123');

    //=========================== Find the register button===========================
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'REGISTER');

    await tester.dragUntilVisible(
      registerButtonFinder,
      find.byType(SingleChildScrollView),
      const Offset(201.4, 574.7),
    );

    await tester.tap(registerButtonFinder);

    await tester.pump();

    // this will fail
    expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);

    // //if i do this, it will pass
    // expect(
    //     find.widgetWithText(SnackBar, 'Invalid registration'), findsOneWidget);
  });
}
