import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/app_bar_base_widget.dart';
import 'package:my_ecomerse/features/home/presentation/providers/all_products_provider.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/all_products_section.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/banner_section.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/categories_showing_widget.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/feature_product_section.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useEffect(() {
      void listener() {
        // Load more when user scrolls within 200 pixels of the bottom
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
          ref.read(allProductsNotifierProvider.notifier).loadMore();
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: const [
            CustomSliverAppBar(title: 'My E-Commerce'),

            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              sliver: SliverToBoxAdapter(
                child: BannerSection(),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.only(bottom: 24.0),
              sliver: SliverToBoxAdapter(
                child: CategoriesSection(),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.only(bottom: 24.0),
              sliver: SliverToBoxAdapter(
                child: FeatureProductSection(),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'All Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

        
            AllProductsSection(),
            
            SliverPadding(padding: EdgeInsets.only(bottom: 32.0)),
          ],
        ),
      ),
    );
  }
}

