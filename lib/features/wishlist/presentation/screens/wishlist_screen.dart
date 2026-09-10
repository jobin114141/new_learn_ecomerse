import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/product_card_widget.dart';
import 'package:my_ecomerse/features/wishlist/presentation/providers/wishlist_provider.dart';

class WishlistScreen extends HookConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistState = ref.watch(wishlistNotifierProvider);

    // Every time this screen opens (including navigating back to it),
    // fetch fresh data from the server to catch cross-device changes.
    useEffect(() {
      Future.microtask(() =>
          ref.read(wishlistNotifierProvider.notifier).fetchWishlist());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: Builder(
        builder: (context) {
          if (wishlistState.isLoading && wishlistState.wishlistItems.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wishlistState.errorMessage != null &&
              wishlistState.wishlistItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    wishlistState.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(wishlistNotifierProvider.notifier).fetchWishlist(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (wishlistState.wishlistItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 72,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your Wishlist is Empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore items and save your favorites here.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(wishlistNotifierProvider.notifier)
                  .fetchWishlist();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: wishlistState.wishlistItems.length,
              itemBuilder: (context, index) {
                final product = wishlistState.wishlistItems[index];

                return ProductCardWidget.fromProduct(
                  product: product,
                  isFavorite: true,
                  onFavoriteTap: () {
                    ref
                        .read(wishlistNotifierProvider.notifier)
                        .toggleWishlist(product);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
