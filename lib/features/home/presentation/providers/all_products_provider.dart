import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/core/network/api_client_provider.dart';
import 'package:my_ecomerse/features/home/data/models/all_products_model';
import 'package:my_ecomerse/features/home/data/repositories/all_products_impl.dart';
import 'package:my_ecomerse/features/home/domain/repositories/all_items_repository.dart';
import 'package:my_ecomerse/features/home/domain/use_case/get_all_products_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_products_provider.g.dart';

class AllProductsProviderState {
  final List<PexelsPhoto> products;
  final bool isLoading;
  final bool isFetchingMore;
  final bool hasMore;
  final int offset;
  final String? errorMessage;
  AllProductsProviderState({
    this.products = const [],
    this.isLoading = false,
    this.isFetchingMore = false,
    this.hasMore = true,
    this.offset = 1,
    this.errorMessage,
  });

  AllProductsProviderState copyWith({
    List<PexelsPhoto>? products,
    bool? isLoading,
    bool? isFetchingMore,
    bool? hasMore,
    int? offset,
    String? errorMessage,
  }) {
    return AllProductsProviderState(
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
AllItemsRepository allProducts(Ref ref) {
  return AllProductsImpl(ref.watch(apiClientProvider));
}

@riverpod
GetAllProductsUseCase getAllProductsUseCase(Ref ref) {
  return GetAllProductsUseCase(ref.watch(allProductsProvider));
}

@riverpod
class AllProductsNotifier extends _$AllProductsNotifier {
  static const int _limit = 10;

  @override
  AllProductsProviderState build() {
    _fetchInitialData();
    return AllProductsProviderState(isLoading: true);
  }

  Future<void> _fetchInitialData() async {
    final useCase = ref.read(getAllProductsUseCaseProvider);
    final result = await useCase.execute(limit: _limit, offset: 1);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (responseList) {
        if (responseList.isNotEmpty) {
          final pexelsResponse = responseList.first;
          final products = pexelsResponse.photos;

          state = state.copyWith(
            isLoading: false,
            products: products,
            offset: 1,
            hasMore: products.length >= _limit,
          );
        } else {
          state = state.copyWith(isLoading: false, hasMore: false);
        }
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isFetchingMore || state.isLoading) return;

    state = state.copyWith(isFetchingMore: true, errorMessage: null);

    final nextOffset = state.offset + 1;
    final useCase = ref.read(getAllProductsUseCaseProvider);
    final result = await useCase.execute(limit: _limit, offset: nextOffset);

    result.fold(
      (failure) {
        state = state.copyWith(
          isFetchingMore: false,
          errorMessage: failure.message,
        );
      },
      (responseList) {
        if (responseList.isNotEmpty) {
          final pexelsResponse = responseList.first;
          final newProducts = pexelsResponse.photos;

          state = state.copyWith(
            isFetchingMore: false,
            offset: nextOffset,
            products: [...state.products, ...newProducts],
            hasMore: newProducts.length >= _limit,
          );
        } else {
          state = state.copyWith(isFetchingMore: false, hasMore: false);
        }
      },
    );
  }
}
