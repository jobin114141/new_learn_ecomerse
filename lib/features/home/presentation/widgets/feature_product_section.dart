import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/product_card_widget.dart';
import 'package:my_ecomerse/features/home/presentation/providers/featured_products_provider.dart';
import 'package:my_ecomerse/features/wishlist/presentation/providers/wishlist_provider.dart';

class FeatureProductSection extends HookConsumerWidget {
  const FeatureProductSection({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featuredProductsNotifierProvider);
    final wishlistState = ref.watch(wishlistNotifierProvider);
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          ref
              .read(featuredProductsNotifierProvider.notifier)
              .fetchMoreProducts();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    if (state.isLoading && state.products.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.errorMessage != null && state.products.isEmpty) {
      return SizedBox(
        height: 220,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.errorMessage!),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref
                    .read(featuredProductsNotifierProvider.notifier)
                    .refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(featuredProductsNotifierProvider.notifier).refresh();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Featured Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.products.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.products.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final product = state.products[index];
                final isFav = wishlistState.wishlistItems
                    .any((item) => item.id == product.id);

                return ProductCardWidget.fromProduct(
                  product: product,
                  isFavorite: isFav,
                  onFavoriteTap: () {
                    ref
                        .read(wishlistNotifierProvider.notifier)
                        .toggleWishlist(product);
                  },
                  onTap: () {
                    // Navigate to details if needed
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

