// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$featuredProductsRepositoryHash() =>
    r'3cd64edf0faf9dea4e7bce32944dbd26accd92e5';

/// See also [featuredProductsRepository].
@ProviderFor(featuredProductsRepository)
final featuredProductsRepositoryProvider =
    AutoDisposeProvider<FeaturedProductsRepository>.internal(
      featuredProductsRepository,
      name: r'featuredProductsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$featuredProductsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedProductsRepositoryRef =
    AutoDisposeProviderRef<FeaturedProductsRepository>;
String _$getFeaturedProductsHash() =>
    r'8a18cc6791fad06af3d884c6f7892cd3ff05a15c';

/// See also [getFeaturedProducts].
@ProviderFor(getFeaturedProducts)
final getFeaturedProductsProvider =
    AutoDisposeProvider<GetFeaturedProductsUseCase>.internal(
      getFeaturedProducts,
      name: r'getFeaturedProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getFeaturedProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetFeaturedProductsRef =
    AutoDisposeProviderRef<GetFeaturedProductsUseCase>;
String _$featuredProductsNotifierHash() =>
    r'c8e1b0b438ec3b35e6264eb10e9111cbe6dd0eba';

/// See also [FeaturedProductsNotifier].
@ProviderFor(FeaturedProductsNotifier)
final featuredProductsNotifierProvider =
    AutoDisposeNotifierProvider<
      FeaturedProductsNotifier,
      FeaturedProductsState
    >.internal(
      FeaturedProductsNotifier.new,
      name: r'featuredProductsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$featuredProductsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FeaturedProductsNotifier = AutoDisposeNotifier<FeaturedProductsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
