import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/home/data/models/all_products_model';
import 'package:my_ecomerse/features/home/domain/repositories/all_items_repository.dart';

class GetAllProductsUseCase {
  final AllItemsRepository _allItemsRepository;

  GetAllProductsUseCase(this._allItemsRepository);

  Future<Either<Failure, List<PexelsResponse>>> execute({
    int limit = 10,
    int offset = 1,
  }) async {
    return await _allItemsRepository.getAllProducts(
      limit: limit,
      offset: offset,
    );
  }
}
