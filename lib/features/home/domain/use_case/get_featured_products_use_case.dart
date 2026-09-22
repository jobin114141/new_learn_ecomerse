import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/home/data/models/feature_model.dart';
import 'package:my_ecomerse/features/home/domain/repositories/featured_products_repository.dart';

class GetFeaturedProductsUseCase {
  final FeaturedProductsRepository _featureProductRepository;
  GetFeaturedProductsUseCase(this._featureProductRepository);

  Future<Either<Failure, ProductModel>> execute({
    int limit = 10,
    int offset = 1,
  }) async {
    return await _featureProductRepository.getFeaturedProducts(
      limit: limit,
      offset: offset,
    );
  }
}
