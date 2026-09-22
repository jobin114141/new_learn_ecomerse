import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/home/data/models/feature_model.dart';

abstract class FeaturedProductsRepository {
  Future<Either<Failure, ProductModel>> getFeaturedProducts({
    required int limit,
    required int offset,
  });
}
