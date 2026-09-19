import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/home/data/models/all_products_model';

abstract class AllItemsRepository {
  Future<Either<Failure, List<PexelsResponse>>> getAllProducts({
    required int limit,
    required int offset,
  });
}
