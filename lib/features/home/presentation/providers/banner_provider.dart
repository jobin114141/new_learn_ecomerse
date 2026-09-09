import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:my_ecomerse/core/network/api_client_provider.dart';
import 'package:my_ecomerse/features/home/data/models/banner_model.dart';
import 'package:my_ecomerse/features/home/data/repositories/banner_repository_impl.dart';
import 'package:my_ecomerse/features/home/domain/repositories/banner_repository.dart';
import 'package:my_ecomerse/features/home/domain/use_case/get_banners_use_case.dart';

part 'banner_provider.g.dart';

@riverpod
BannerRepository bannerRepository(Ref ref) {
  return BannerRepositoryImpl(ref.watch(apiClientProvider));
}

@riverpod
GetBannersUseCase getBanners(Ref ref) {
  return GetBannersUseCase(ref.watch(bannerRepositoryProvider));
}

@riverpod
Future<List<BannerModel>> bannerList(Ref ref) async {
  final useCase = ref.watch(getBannersProvider);
  final result = await useCase.execute();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (banners) => banners,
  );
}

