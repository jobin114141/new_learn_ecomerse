import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/core/network/api_client_provider.dart';
import 'package:my_ecomerse/features/home/data/models/feature_model.dart';
import 'package:my_ecomerse/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:my_ecomerse/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:my_ecomerse/features/wishlist/domain/use_case/get_wishlist_products_use_case.dart';
import 'package:my_ecomerse/features/wishlist/domain/use_case/toggle_wishlist_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_provider.g.dart';

class WishlistState {
  final List<Product> wishlistItems;
  final bool isLoading;
  final String? errorMessage;
  WishlistState({
    this.wishlistItems = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  WishlistState copyWith({
    List<Product>? wishlistItems,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WishlistState(
      wishlistItems: wishlistItems ?? this.wishlistItems,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

@riverpod
WishlistRepository wishlistRepository(Ref ref) {
  return WishlistRepositoryImpl(ref.watch(apiClientProvider));
}

@riverpod
GetWishlistProductsUseCase getWishlistProductsUseCase(Ref ref) {
  return GetWishlistProductsUseCase(ref.watch(wishlistRepositoryProvider));
}

@riverpod
ToggleWishlistUseCase toggleWishlistUseCase(Ref ref) {
  return ToggleWishlistUseCase(ref.watch(wishlistRepositoryProvider));
}

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  @override
  WishlistState build() {
    Future.microtask(() => fetchWishlist());
    return WishlistState(isLoading: true);
  }

  Future<void> fetchWishlist() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final useCase = ref.read(getWishlistProductsUseCaseProvider);
    final result = await useCase.execute();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (wishlistModel) {
        state = state.copyWith(
          wishlistItems: wishlistModel.products,
          isLoading: false,
        );
      },
    );
  }

  Future<void> toggleWishlist(Product product) async {
    final isFav = state.wishlistItems.any((item) => item.id == product.id);
    // Optimistic Update
    final updatedList = isFav
        ? state.wishlistItems.where((item) => item.id != product.id).toList()
        : [...state.wishlistItems, product];
    state = state.copyWith(wishlistItems: updatedList);
    final useCase = ref.read(toggleWishlistUseCaseProvider);
    final result = await useCase.execute(product.id, isFav);
    result.fold((failure) {
      // Revert on error
      fetchWishlist();
    }, (_) {});
  }
}
