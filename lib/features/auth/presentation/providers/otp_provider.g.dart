// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifyOtpUseCaseHash() => r'031122716f3e2b5d80082d3460d7dab6ab4998f1';

/// See also [verifyOtpUseCase].
@ProviderFor(verifyOtpUseCase)
final verifyOtpUseCaseProvider = AutoDisposeProvider<VerifyOtpUseCase>.internal(
  verifyOtpUseCase,
  name: r'verifyOtpUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifyOtpUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VerifyOtpUseCaseRef = AutoDisposeProviderRef<VerifyOtpUseCase>;
String _$otpNotifierHash() => r'355b8d2fc6479adccb973ba570957ba018ce0ed0';

/// See also [OtpNotifier].
@ProviderFor(OtpNotifier)
final otpNotifierProvider =
    AutoDisposeNotifierProvider<OtpNotifier, AsyncValue<void>>.internal(
      OtpNotifier.new,
      name: r'otpNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$otpNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OtpNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
