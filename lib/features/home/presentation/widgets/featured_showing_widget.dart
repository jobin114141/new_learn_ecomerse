import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/custom_title_widget.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/product_card_widget.dart';

class FeaturedShowingWidget extends HookConsumerWidget {
  const FeaturedShowingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyFeaturedValue = [
      {'name': 'Men', 'image': 'https://picsum.photos/800/400?image=2', 'price': '1200' , 'rating': 4.4},
      {'name': 'Women', 'image': 'https://picsum.photos/800/400?image=3', 'price': '2200','rating': 4.5},
      {'name': 'Kids', 'image': 'https://picsum.photos/800/400?image=4', 'price': '200','rating': 4.1},
      {'name': 'Footwear', 'image': 'https://picsum.photos/800/400?image=5', 'price': '1200','rating': 1.5},
      {'name': 'Electronics', 'image': 'https://picsum.photos/800/400?image=6', 'price': '400','rating': 1.5},
      {'name': 'Beauty', 'image': 'https://picsum.photos/800/400?image=7', 'price': '21200','rating': 3.5,}
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: const CustomTitleWidget(
                  title: 'Featured Items',
                  size: HeadingSize.small,
                  isBold: true,
                ),
              ),

              const CustomTitleWidget(
                title: 'View all',
                size: HeadingSize.small,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: dummyFeaturedValue.length,
                  itemBuilder: (BuildContext context, int index) {
                    final featureditems = dummyFeaturedValue[index];
                    return ProductCardWidget(
                      name: featureditems['name']?.toString() ?? '',
                      image: featureditems['image']?.toString() ?? '',
                      price: featureditems['price']?.toString() ?? '',
                      rating: featureditems['rating']?.toString() ?? '',
                      onTap: () {
                        // TODO: Navigate to Category Products screen
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
