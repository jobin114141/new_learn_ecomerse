import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/use_cases/send_otp_use_case.dart';
import 'auth_repository_provider.dart';

part 'phone_login_provider.g.dart';

// 1. Functional Provider for SendOtpUseCase
@riverpod
SendOtpUseCase sendOtpUseCase(Ref ref) {
  return SendOtpUseCase(ref.watch(authRepositoryProvider));
}

// 2. Class Notifier Provider for Phone Login
@riverpod
class PhoneLoginNotifier extends _$PhoneLoginNotifier {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  // Send OTP Method
  Future<bool> sendOtp(String phoneNumber) async {
    state = const AsyncValue.loading();

    final sendOtpUseCase = ref.read(sendOtpUseCaseProvider);
    final result = await sendOtpUseCase.execute(phoneNumber);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
      (success) {
        state = const AsyncValue.data(null);
        return success;
      },
    );
  }
}
