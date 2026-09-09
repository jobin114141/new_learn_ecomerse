import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/features/home/data/models/banner_model.dart';

class BannerCarousel extends HookConsumerWidget {
  final List<BannerModel> banners;
  final Function(BannerModel banner)? onBannerTap;
  final Duration autoScrollDuration;
  final double height;

  const BannerCarousel({
    super.key,
    required this.banners,
    this.onBannerTap,
    this.autoScrollDuration = const Duration(seconds: 4),
    this.height = 170.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. PageController lifecycle managed automatically by hook
    final pageController = usePageController();

    // 2. Local state for current active dot index
    final currentIndex = useState(0);

    // 3. Auto-scroll Timer managed cleanly via useEffect
    useEffect(() {
      if (banners.length <= 1) return null;

      final timer = Timer.periodic(autoScrollDuration, (_) {
        if (pageController.hasClients) {
          final nextPage = (currentIndex.value + 1) % banners.length;
          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
          );
        }
      });

      return timer.cancel;
    }, [banners.length, autoScrollDuration]);

    if (banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            controller: pageController,
            itemCount: banners.length,
            onPageChanged: (index) => currentIndex.value = index,
            itemBuilder: (context, index) {
              final banner = banners[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () => onBannerTap?.call(banner),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        banner.fullImageUrl,
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
                              child: Icon(Icons.broken_image_rounded, size: 44, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Indicator Dots (Only if more than 1 banner)
        if (banners.length > 1) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              banners.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                height: 7.0,
                width: currentIndex.value == index ? 22.0 : 7.0,
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
      ],
    );
  }
}
