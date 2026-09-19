import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_ecomerse/features/home/data/models/banner_model.dart';
import '../providers/banner_provider.dart';
import 'banner_carousel.dart';

/// Clean Architecture Presentation Section for Banners
class BannerSection extends ConsumerWidget {
  final Function(BannerModel banner)? onBannerTap;

  const BannerSection({
    super.key,
    this.onBannerTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAsync = ref.watch(bannerListProvider);

    return bannerAsync.when(
      // --- DATA STATE ---
      data: (banners) {
        if (banners.isEmpty) {
          return const SizedBox.shrink();
        }
        return BannerCarousel(
          banners: banners,
          onBannerTap: onBannerTap,
        );
      },

      // --- LOADING SKELETON STATE ---
      loading: () => const _BannerShimmerSkeleton(),

      // --- ERROR STATE WITH RETRY ---
      error: (error, stackTrace) => _BannerErrorWidget(
        onRetry: () => ref.invalidate(bannerListProvider),
      ),
    );
  }
}

/// Shimmer Loading Skeleton Widget
class _BannerShimmerSkeleton extends StatelessWidget {
  const _BannerShimmerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}

/// Error Card Widget
class _BannerErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const _BannerErrorWidget({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            color: Theme.of(context).colorScheme.error,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Unable to load promotional banners',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: onRetry,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to retry',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
