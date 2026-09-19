import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/constants/api_endpoints.dart';
import 'package:my_ecomerse/core/error/api_error_handler.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/core/network/api_client.dart';
import 'package:my_ecomerse/features/home/data/models/banner_model.dart';
import 'package:my_ecomerse/features/home/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final ApiClient _apiClient;
  BannerRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, List<BannerModel>>> getBanners() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.bannerUri);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final banners = data.map((json) => BannerModel.fromJson(json)).toList();
        return Right(banners);
      } else {
        return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to fetch banners',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
