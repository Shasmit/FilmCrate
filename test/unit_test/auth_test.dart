import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/auth/domain/entity/user_entity.dart';
import 'package:filmcrate/features/auth/domain/use_case/auth_usecase.dart';
import 'package:filmcrate/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

//yo test mileko xa

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late AuthUseCase mockAuthUseCase;
  late ProviderContainer container;
  late BuildContext context;
  late UserEntity userEntity;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    context = MockBuildContext();
    userEntity = const UserEntity(
      username: 'kirans',
      email: 'kirans@gmail.com',
      password: 'kirans123',
      confirmPassword: 'kirans123',
    );
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(mockAuthUseCase),
      ),
    ]);
  });

  test('check for inital state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
  });

  test('login test with valid username and password', () async {
    when(mockAuthUseCase.loginUser('kiran', 'kiran123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'kiran', 'kiran123');

    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('login test with invalid username and password', () async {
    when(mockAuthUseCase.loginUser('nischal', 'nischal1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: "Invalid"))));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'nischal', "nischal1234");

    final authState = container.read(authViewModelProvider);
    expect(authState.error, 'Invalid');
  });

  test('register test with valid user information', () async {
    when(mockAuthUseCase.registerUser(userEntity))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(context, userEntity);

    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('register test with invalid user information', () async {
    when(mockAuthUseCase.registerUser(userEntity))
        .thenAnswer((_) => Future.value(Left(Failure(error: "Invalid"))));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(context, userEntity);

    final authState = container.read(authViewModelProvider);
    expect(authState.error, 'Invalid');

    //test fail garna isNotNull ko satta isNull rakhney
  });

  tearDown(() {
    container.dispose();
  });
}
