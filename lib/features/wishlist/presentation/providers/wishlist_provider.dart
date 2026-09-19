import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/core/network/api_client_provider.dart';
import 'package:my_ecomerse/features/home/data/models/feature_model.dart';
import 'package:my_ecomerse/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:my_ecomerse/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:my_ecomerse/features/wishlist/domain/use_case/get_wishlist_products_use_case.dart';
import 'package:my_ecomerse/features/wishlist/domain/use_case/toggle_wishlist_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final String _cacheKey = 'cached_wishlist_ids';
  @override
  WishlistState build() {
    Future.microtask(() async {
      await loadWishListFromCache();
      await fetchWishlist();
    });
    return WishlistState(isLoading: true);
  }

  Future<void> loadWishListFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedJsonStrings = prefs.getStringList(_cacheKey);

      if (savedJsonStrings != null && savedJsonStrings.isNotEmpty) {
        final List<Product> cachedProducts = savedJsonStrings
            .map((str) => Product.fromJson(jsonDecode(str)))
            .toList();

        // Immediately show the cached items!
        state = state.copyWith(wishlistItems: cachedProducts, isLoading: false);
      }
    } catch (e) {
      // print(e);
    }
  }

  Future<void> saveWishListCache(List<Product> products) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> jsonStrings = products
          .map((prod) => jsonEncode(prod.toJson()))
          .toList();
      await prefs.setStringList(_cacheKey, jsonStrings);
    } catch (e) {}
  }

  Future<void> fetchWishlist() async {
    // Only show the full-screen spinner if there is no cached data yet.
    // If we already have cached items, fetch silently in the background.
    if (state.wishlistItems.isEmpty) {
      state = state.copyWith(isLoading: true, errorMessage: null);
    }

    final useCase = ref.read(getWishlistProductsUseCaseProvider);
    final result = await useCase.execute();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (wishlistModel) {
        final products = wishlistModel.products;
        state = state.copyWith(wishlistItems: products, isLoading: false);
        // Save the fresh data from the server to the local cache!
        saveWishListCache(products);
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
    saveWishListCache(updatedList);
    final useCase = ref.read(toggleWishlistUseCaseProvider);
    final result = await useCase.execute(product.id, isFav);
    result.fold((failure) {
      // Revert on error
      fetchWishlist();
    }, (_) {});
  }
}
