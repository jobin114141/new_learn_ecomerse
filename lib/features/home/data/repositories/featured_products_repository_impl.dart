import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/constants/api_endpoints.dart';
import 'package:my_ecomerse/core/error/api_error_handler.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/core/network/api_client.dart';
import 'package:my_ecomerse/features/home/data/models/feature_model.dart';
import 'package:my_ecomerse/features/home/domain/repositories/featured_products_repository.dart';

class FeaturedProductsRepositoryImpl implements FeaturedProductsRepository {
  final ApiClient _apiClient;
  FeaturedProductsRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, ProductModel>> getFeaturedProducts({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.featuredProduct,
        queryParameters: {'limit': limit, 'offset': offset},
      );
      if (response.statusCode == 200) {
        final productModel = ProductModel.fromJson(response.data);
        return right(productModel);
      }else{
         return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to fetch featured products',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
