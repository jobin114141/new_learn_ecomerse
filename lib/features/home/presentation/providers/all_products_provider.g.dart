// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allProductsHash() => r'0695b368ac8f757e96479147f96df438868eee79';

/// See also [allProducts].
@ProviderFor(allProducts)
final allProductsProvider = AutoDisposeProvider<AllItemsRepository>.internal(
  allProducts,
  name: r'allProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllProductsRef = AutoDisposeProviderRef<AllItemsRepository>;
String _$getAllProductsUseCaseHash() =>
    r'deddd879ea4ac230a1d2d2ab7a38b21dc4388fdc';

/// See also [getAllProductsUseCase].
@ProviderFor(getAllProductsUseCase)
final getAllProductsUseCaseProvider =
    AutoDisposeProvider<GetAllProductsUseCase>.internal(
      getAllProductsUseCase,
      name: r'getAllProductsUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getAllProductsUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllProductsUseCaseRef =
    AutoDisposeProviderRef<GetAllProductsUseCase>;
String _$allProductsNotifierHash() =>
    r'45576208c58bdf29fe5ab8b7ae31ba077e2ed450';

/// See also [AllProductsNotifier].
@ProviderFor(AllProductsNotifier)
final allProductsNotifierProvider =
    AutoDisposeNotifierProvider<
      AllProductsNotifier,
      AllProductsProviderState
    >.internal(
      AllProductsNotifier.new,
      name: r'allProductsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allProductsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AllProductsNotifier = AutoDisposeNotifier<AllProductsProviderState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
