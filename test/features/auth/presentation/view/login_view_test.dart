// import 'package:dartz/dartz.dart';
// import 'package:filmcrate/config/router/app_route.dart';
// import 'package:filmcrate/features/auth/domain/use_case/auth_usecase.dart';
// import 'package:filmcrate/features/auth/presentation/viewmodel/auth_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../../../unit_test/auth_test.mocks.dart';

// void main() {
//   late AuthUseCase mockAuthUseCase;
//   late bool isLogin;

//   setUpAll(() async {
//     mockAuthUseCase = MockAuthUseCase();
//     isLogin = true;
//   });

//   testWidgets(
//     'login test with username and password and open dashboard',
//     (tester) async {
//       // Arrange
//       when(mockAuthUseCase.loginUser('manjesh', 'manjesh123'))
//           .thenAnswer((_) async => Right(isLogin));

//       await tester.pumpWidget(
//         ProviderScope(
//           overrides: [
//             authViewModelProvider
//                 .overrideWith((ref) => AuthViewModel(mockAuthUseCase)),
//           ],
//           child: MaterialApp(
//             initialRoute: AppRoute.loginRoute,
//             routes: AppRoute.getApplicationRoute(),
//           ),
//         ),
//       );

//       await tester.pumpAndSettle();

//       await tester.enterText(find.byType(TextFormField).at(0), 'manjesh');
//       await tester.enterText(find.byType(TextFormField).at(1), 'manjesh123');

//       final loginbuttonFinder = find.widgetWithText(ElevatedButton, 'test');

//       await tester.dragUntilVisible(
//         loginbuttonFinder,
//         find.byType(SingleChildScrollView),
//         const Offset(201.4, 574.7),
//       );

//       await tester.tap(loginbuttonFinder);

//       await tester.pumpAndSettle(); // Assert
//       // // expect(
//       // //     find.widgetWithText(SnackBar, 'Login successfully'), findsOneWidget);

//       expect(find.text('MOVIES'), findsOneWidget);
//     },
//   );
// }
