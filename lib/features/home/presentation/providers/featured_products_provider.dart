import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/core/network/api_client_provider.dart';
import 'package:my_ecomerse/features/home/data/models/feature_model.dart';
import 'package:my_ecomerse/features/home/data/repositories/featured_products_repository_impl.dart';
import 'package:my_ecomerse/features/home/domain/repositories/featured_products_repository.dart';
import 'package:my_ecomerse/features/home/domain/use_case/get_featured_products_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'featured_products_provider.g.dart';

class FeaturedProductsState {
  final List<Product> products;
  final bool isLoading;
  final bool isFetchingMore;
  final bool hasMore;
  final int offset;
  final String? errorMessage;
  FeaturedProductsState({
    this.products = const [],
    this.isLoading = false,
    this.isFetchingMore = false,
    this.hasMore = true,
    this.offset = 1,
    this.errorMessage,
  });

  FeaturedProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isFetchingMore,
    bool? hasMore,
    int? offset,
    String? errorMessage,
  }) {
    return FeaturedProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
      errorMessage: errorMessage,
    );
  }
}

@riverpod
FeaturedProductsRepository featuredProductsRepository(Ref ref) {
  return FeaturedProductsRepositoryImpl(ref.watch(apiClientProvider));
}

@riverpod
GetFeaturedProductsUseCase getFeaturedProducts(Ref ref) {
  return GetFeaturedProductsUseCase(
    ref.watch(featuredProductsRepositoryProvider),
  );
}

@riverpod
class FeaturedProductsNotifier extends _$FeaturedProductsNotifier {
  static const int _limit = 10;

  @override
  FeaturedProductsState build() {
    Future.microtask(() => fetchInitialProducts());
    return FeaturedProductsState(isLoading: true);
  }

  Future<void> fetchInitialProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final useCase = ref.read(getFeaturedProductsProvider);
    final result = await useCase.execute(limit: _limit, offset: 1);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (productModel) {
        final newProducts = productModel.products ?? [];
        final totalSize = productModel.totalSize ?? 0;
        final hasMore =
            newProducts.isNotEmpty && (newProducts.length < totalSize);

        state = state.copyWith(
          products: newProducts,
          isLoading: false,
          offset: 1,
          hasMore: hasMore,
        );
      },
    );
  }

  Future<void> fetchMoreProducts() async {
    if (state.isFetchingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isFetchingMore: true, errorMessage: null);
    final nextOffset = state.offset + 1;
    final useCase = ref.read(getFeaturedProductsProvider);
    final result = await useCase.execute(limit: _limit, offset: nextOffset);
    result.fold(
      (failure) {
        state = state.copyWith(
          isFetchingMore: false,
          errorMessage: failure.message,
        );
      },
      (productModel) {
        final newProducts = productModel.products ?? [];
        final updatedProducts = [...state.products, ...newProducts];
        final totalSize = productModel.totalSize ?? 0;
        final hasMore =
            newProducts.isNotEmpty && (updatedProducts.length < totalSize);
        state = state.copyWith(
          products: updatedProducts,
          isFetchingMore: false,
          offset: nextOffset,
          hasMore: hasMore,
        );
      },
    );
  }

  Future<void> refresh() async {
    await fetchInitialProducts();
  }
}
