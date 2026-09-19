import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/common/widgets/custom_title_widget.dart';
import 'package:my_ecomerse/features/home/presentation/widgets/category_card.dart';

class CategoriesSection extends HookConsumerWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyCategories = [
      {'name': 'Men', 'image': 'https://picsum.photos/800/400?image=2'},
      {'name': 'Women', 'image': 'https://picsum.photos/800/400?image=3'},
      {'name': 'Kids', 'image': 'https://picsum.photos/800/400?image=4'},
      {'name': 'Footwear', 'image': 'https://picsum.photos/800/400?image=5'},
      {'name': 'Electronics', 'image': 'https://picsum.photos/800/400?image=6'},
      {'name': 'Beauty', 'image': 'https://picsum.photos/800/400?image=7'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTitleWidget(
            title: 'Categories',
            size: HeadingSize.small,
            isBold: true,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 95,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: dummyCategories.length,
            itemBuilder: (BuildContext context, int index) {
              final category = dummyCategories[index];
              return CategoryCard(
                name: category['name'] ?? '',
                image: category['image'] ?? '',
                onTap: () {
                  // TODO: Navigate to Category Products screen
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Backward compatibility alias
typedef CategoriesShowingWidget = CategoriesSection;

