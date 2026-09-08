import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/use_cases/verify_otp_use_case.dart';
import 'auth_repository_provider.dart';
import 'auth_state_provider.dart';

part 'otp_provider.g.dart';

// 1. Functional Provider for VerifyOtpUseCase
@riverpod
VerifyOtpUseCase verifyOtpUseCase(Ref ref) {
  return VerifyOtpUseCase(ref.watch(authRepositoryProvider));
}


@riverpod
class OtpNotifier extends _$OtpNotifier {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  // OTP Verification Method
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    state = const AsyncValue.loading();

    // Read the generated verifyOtpUseCaseProvider
    final verifyOtpUseCase = ref.read(verifyOtpUseCaseProvider);
    final result = await verifyOtpUseCase.execute(phoneNumber, otp);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
      (success) {
        state = const AsyncValue.data(null);

        // ✅ Built-in `ref` is used directly — no constructor parameter needed!
        ref.read(authNotifierProvider.notifier).setAuthenticated();

        return true;
      },
    );
  }
}
