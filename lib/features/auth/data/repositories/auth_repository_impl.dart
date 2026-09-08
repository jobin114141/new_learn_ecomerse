import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/storage/token_storage.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/api_error_handler.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;
  AuthRepositoryImpl(this._apiClient, this._tokenStorage);

  @override
  Future<Either<Failure, bool>> sendOtp(String phoneNumber) async {
    try {
      final response = await _apiClient.post(
        '${ApiEndpoints.checkPhoneUri}$phoneNumber',
        data: {'phone': phoneNumber},
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to send OTP',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String phone, String otp) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.verifyOtpUri,
        data: {"phone": phone.trim(), "token": otp},
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        await _tokenStorage.saveToken(response.data['token']);

        return const Right(true);
      } else {
        return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to send OTP',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
