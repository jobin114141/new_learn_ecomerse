import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/features/search/presentation/provider/search_provider.dart';
import 'package:my_ecomerse/features/search/presentation/widget/search_product_card.dart';

class SearchResultsList extends HookConsumerWidget {
  const SearchResultsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
          ref.read(searchNotifierProvider.notifier).fetchNextPage();
        }
      }
      
      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    final searchState = ref.watch(searchNotifierProvider);

    if (searchState.searchKeyword.isEmpty) {
      return const Center(
        child: Text('Type something to start searching'),
      );
    }

    if (searchState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchState.errorMessage != null && searchState.products.isEmpty) {
      return Center(
        child: Text(
          searchState.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (searchState.products.isEmpty) {
      return const Center(
        child: Text('No products found.'),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: searchState.products.length + (searchState.isFetchingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == searchState.products.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final product = searchState.products[index];
        return SearchProductCard(product: product);
      },
    );
  }
}
