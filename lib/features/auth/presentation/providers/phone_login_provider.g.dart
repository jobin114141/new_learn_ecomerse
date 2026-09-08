// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sendOtpUseCaseHash() => r'cc960b30da3a413d2a50696b02108b468f65643a';

/// See also [sendOtpUseCase].
@ProviderFor(sendOtpUseCase)
final sendOtpUseCaseProvider = AutoDisposeProvider<SendOtpUseCase>.internal(
  sendOtpUseCase,
  name: r'sendOtpUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendOtpUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendOtpUseCaseRef = AutoDisposeProviderRef<SendOtpUseCase>;
String _$phoneLoginNotifierHash() =>
    r'33ee245537b20bf18805105207d64f02bcedf022';

/// See also [PhoneLoginNotifier].
@ProviderFor(PhoneLoginNotifier)
final phoneLoginNotifierProvider =
    AutoDisposeNotifierProvider<PhoneLoginNotifier, AsyncValue<void>>.internal(
      PhoneLoginNotifier.new,
      name: r'phoneLoginNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$phoneLoginNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PhoneLoginNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
