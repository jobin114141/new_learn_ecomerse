import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/core/constants/dimensions.dart';
import 'package:my_ecomerse/core/routes/route_name.dart';
import 'package:my_ecomerse/features/search/presentation/screen/search_screen.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final bool drower;
  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.drower = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true, // Keeps the app bar visible at the top when scrolling
      floating: true, // App bar slides into view immediately on scroll up
      backgroundColor: Colors.white,
      elevation: 0,
      leading: drower == true
          ? IconButton(icon: const Icon(Icons.menu), onPressed: () {})
          : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: Dimensions.fontSizeDefault,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.chat_bubble_outline_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            context.push(RouteNames.chatPage);
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            return IconButton(
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                context.push('/WishlistScreen');
              },
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            const cartCount = 3;
            return IconButton(
              icon: Badge(
                label: Text('$cartCount'),
                child: const Icon(Icons.shopping_cart, color: Colors.black),
              ),
              onPressed: () => context.push('/cart'),
            );
          },
        ),
      ],
    );
  }
}
