import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, bool>> sendOtp(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2));

    if (phoneNumber == '0000000000') {
      return const Left(ServerFailure('Server error: Failed to send OTP. Try again.'));
    }

    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String phoneNumber, String otp) async {
    await Future.delayed(const Duration(seconds: 2));

    if (otp == '123456' || otp == '1234') {
      return const Right(true);
    } else {
      return const Left(ServerFailure('Invalid OTP. Please enter 123456'));
    }
  }
}
