import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/app_bar_base_widget.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/banner_carousel.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/categories_showing_widget.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/featured_showing_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const imageUrls = [
      'https://picsum.photos/800/400?image=1',
      'https://picsum.photos/800/400?image=2',
      'https://picsum.photos/800/400?image=3',
    ];

    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            CustomSliverAppBar(title: 'My E-Commerce'),

            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              sliver: SliverToBoxAdapter(
                child: BannerCarousel(imageUrls: imageUrls),
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
                child: FeaturedShowingWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

