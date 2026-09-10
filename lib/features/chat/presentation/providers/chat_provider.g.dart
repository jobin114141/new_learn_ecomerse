// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRepositoryHash() => r'658272e56d1b9a382881635c55a1a87aadffde82';

/// See also [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider =
    AutoDisposeProvider<ChatMessageRepository>.internal(
      chatRepository,
      name: r'chatRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRepositoryRef = AutoDisposeProviderRef<ChatMessageRepository>;
String _$getMessagesUseCaseHash() =>
    r'62a4a70abda3155e58315b08ee6b67802076939b';

/// See also [getMessagesUseCase].
@ProviderFor(getMessagesUseCase)
final getMessagesUseCaseProvider =
    AutoDisposeProvider<GetMessagesUseCase>.internal(
      getMessagesUseCase,
      name: r'getMessagesUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getMessagesUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetMessagesUseCaseRef = AutoDisposeProviderRef<GetMessagesUseCase>;
String _$sendMessageUseCaseHash() =>
    r'dda92eb2e903ee948d8c3f7f3ebaef1817d9b6fa';

/// See also [sendMessageUseCase].
@ProviderFor(sendMessageUseCase)
final sendMessageUseCaseProvider =
    AutoDisposeProvider<SendMessageUseCase>.internal(
      sendMessageUseCase,
      name: r'sendMessageUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sendMessageUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SendMessageUseCaseRef = AutoDisposeProviderRef<SendMessageUseCase>;
String _$chatNotifierHash() => r'a35bcbb6869c473f760d2b6000e23004a7356424';

/// See also [ChatNotifier].
@ProviderFor(ChatNotifier)
final chatNotifierProvider =
    AutoDisposeNotifierProvider<ChatNotifier, List<ChatMessageModel>>.internal(
      ChatNotifier.new,
      name: r'chatNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ChatNotifier = AutoDisposeNotifier<List<ChatMessageModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
