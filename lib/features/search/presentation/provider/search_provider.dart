import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/core/network/api_client_provider.dart';
import 'package:my_ecomerse/features/search/data/models/search_model.dart';
import 'package:my_ecomerse/features/search/data/repositories/search_repositorie_impl.dart';
import 'package:my_ecomerse/features/search/domain/repositories/search_repositorie.dart';
import 'package:my_ecomerse/features/search/domain/use_case/get_search_result_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

class SearchProviderState {
  final List<Product> products;
  final bool isLoading;
  final bool isFetchingMore;
  final bool hasMore;
  final int offset;
  final String? errorMessage;
  final String searchKeyword;

  SearchProviderState({
    this.products = const [],
    this.isLoading = false,
    this.isFetchingMore = false,
    this.hasMore = true,
    this.offset = 1,
    this.errorMessage,
    this.searchKeyword = '',
  });

  SearchProviderState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isFetchingMore,
    bool? hasMore,
    int? offset,
    String? errorMessage,
    String? searchKeyword,
  }) {
    return SearchProviderState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
      errorMessage: errorMessage,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }
}

@riverpod
SearchRepositorie searchRepositorie(Ref ref) {
  return SearchRepositorieImpl(ref.watch(apiClientProvider));
}

@riverpod
GetSearchResultUseCase getsearchUseCase(Ref ref) {
  return GetSearchResultUseCase(ref.watch(searchRepositorieProvider));
}

@riverpod
class SearchNotifier extends _$SearchNotifier {
  static const int _limit = 10;
  Timer? _debounceTimer;
  
  @override
  SearchProviderState build() {
    return SearchProviderState();
  }

  Future<void> search(String keyword) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (keyword.trim().isEmpty) {
        state = SearchProviderState(); 
        return;
      }

      state = state.copyWith(
        isLoading: true,
        errorMessage: null,
        searchKeyword: keyword,
        offset: 1, // Reset pagination
        products: [],
        hasMore: true,
      );

      final useCase = ref.read(getsearchUseCaseProvider);
      final result = await useCase.execute(
        productName: keyword,
        limit: _limit,
        offset: 1,
      );

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          );
        },
        (products) {
          state = state.copyWith(
            isLoading: false,
            products: products,
            hasMore: products.length == _limit,
          );
        },
      );
    });
  }

  Future<void> fetchNextPage() async {
    // Prevent fetching if already fetching, no more data, or no search keyword
    if (state.isFetchingMore || !state.hasMore || state.searchKeyword.isEmpty) return;

    state = state.copyWith(isFetchingMore: true, errorMessage: null);

    final nextOffset = state.offset + 1;
    final useCase = ref.read(getsearchUseCaseProvider);
    
    final result = await useCase.execute(
      productName: state.searchKeyword,
      limit: _limit,
      offset: nextOffset,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isFetchingMore: false,
          errorMessage: failure.message,
        );
      },
      (newProducts) {
        state = state.copyWith(
          isFetchingMore: false,
          products: [...state.products, ...newProducts],
          offset: nextOffset,
          hasMore: newProducts.length == _limit,
        );
      },
    );
  }
}
