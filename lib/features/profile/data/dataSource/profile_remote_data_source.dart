import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filmcrate/config/constants/api_endpoint.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/core/shared_prefs/user_shared_prefs.dart';
import 'package:filmcrate/features/auth/data/model/auth_api_model.dart';
import 'package:filmcrate/features/profile/data/model/password_api_model.dart';
import 'package:filmcrate/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/remote/http_service.dart';
import '../../domain/entity/password_entity.dart';
import '../dto/profile_dto.dart';
import '../model/profile_api_model.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    profileApiModel: ref.read(profileApiModelProvider),
    passwordApiModel: ref.read(passwordApiModelProvider),
    authApiModel: ref.read(authApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final ProfileApiModel profileApiModel;
  final AuthApiModel authApiModel;
  final PasswordApiModel passwordApiModel;
  final UserSharedPrefs userSharedPrefs;

  ProfileRemoteDataSource({
    required this.dio,
    required this.profileApiModel,
    required this.authApiModel,
    required this.passwordApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> changePassword(PasswordEntity password) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.changePassword,
        data: {
          'currentPassword': password.oldPassword,
          'newPassword': password.newPassword,
          'confirmPassword': password.confirmPassword,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 204) {
        // Password changed successfully
        return const Right(true);
      } else if (response.statusCode == 401) {
        // Incorrect current password
        return Left(
          Failure(
            error: response.data['error'] ?? 'Incorrect current password',
          ),
        );
      } else {
        return Left(
          Failure(
            error: 'Failed to change password. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse && e.response?.data != null) {
        // Incorrect current password
        return Left(
          Failure(
            error: e.response!.data['error'] ?? 'Incorrect current password',
          ),
        );
      } else {
        return Left(
          Failure(
            error: e.error.toString(),
          ),
        );
      }
    }
  }

  Future<Either<Failure, bool>> editProfile(
      String username, String email) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.updateProfile,
        data: {"username": username, "email": email},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Profile edited successfully
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: 'Failed to edit profile. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<ProfileEntity>>> getUserProfile() async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      var response = await dio.get(
        ApiEndpoints.verifyUser,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetProfileDetials getProfileDetials =
            GetProfileDetials.fromJson(response.data);

        return Right(profileApiModel.toEntityList(getProfileDetials.user));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r!),
          );
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
