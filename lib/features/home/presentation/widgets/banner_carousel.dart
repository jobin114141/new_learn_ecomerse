import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BannerCarousel extends HookConsumerWidget {
  final List<String> imageUrls;
  final Duration autoScrollDuration;
  final double height;

  const BannerCarousel({
    super.key,
    required this.imageUrls,
    this.autoScrollDuration = const Duration(seconds: 4),
    this.height = 180.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. PageController lifecycle managed automatically by hook
    final pageController = usePageController();

    // 2. Local state for current active dot index
    final currentIndex = useState(0);

    // 3. useEffect handles Timer creation & automatic disposal when widget unmounts
    useEffect(() {
      if (imageUrls.length <= 1) return null;

      final timer = Timer.periodic(autoScrollDuration, (timer) {
        if (pageController.hasClients) {
          final nextPage = (currentIndex.value + 1) % imageUrls.length;
          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
          );
        }
      });

      // Cleanup callback called automatically on unmount
      return timer.cancel;
    }, [imageUrls.length, autoScrollDuration]);

    if (imageUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            onPageChanged: (index) => currentIndex.value = index,
            itemBuilder: (context, index) {
              final imageUrl = imageUrls[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        // Animated Page Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageUrls.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: currentIndex.value == index ? 24.0 : 8.0,
              decoration: BoxDecoration(
                color: currentIndex.value == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
