import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  /// Sends OTP to the provided phone number.
  Future<Either<Failure, bool>> sendOtp(String phoneNumber);

  /// Verifies the OTP code.
  Future<Either<Failure, bool>> verifyOtp(String phone, String otp);
}
