// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bannerRepositoryHash() => r'dd378fd8e7b3be9331737560ee4795c9b2b17d30';

/// See also [bannerRepository].
@ProviderFor(bannerRepository)
final bannerRepositoryProvider = AutoDisposeProvider<BannerRepository>.internal(
  bannerRepository,
  name: r'bannerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bannerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BannerRepositoryRef = AutoDisposeProviderRef<BannerRepository>;
String _$getBannersHash() => r'b00dc8842f6704d43c8c541896d8c203f4daa3c6';

/// See also [getBanners].
@ProviderFor(getBanners)
final getBannersProvider = AutoDisposeProvider<GetBannersUseCase>.internal(
  getBanners,
  name: r'getBannersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBannersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetBannersRef = AutoDisposeProviderRef<GetBannersUseCase>;
String _$bannerListHash() => r'b1ff250d8f552301a13c00bf65c0ed4542b56c65';

/// See also [bannerList].
@ProviderFor(bannerList)
final bannerListProvider =
    AutoDisposeFutureProvider<List<BannerModel>>.internal(
      bannerList,
      name: r'bannerListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bannerListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BannerListRef = AutoDisposeFutureProviderRef<List<BannerModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
