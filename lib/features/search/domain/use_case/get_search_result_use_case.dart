import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/search/data/models/search_model.dart';
import 'package:my_ecomerse/features/search/domain/repositories/search_repositorie.dart';

class GetSearchResultUseCase {
  final SearchRepositorie _searchRepositorie;
  GetSearchResultUseCase(this._searchRepositorie);

  Future<Either<Failure, List<Product>>> execute({
    required String productName,
    required int limit,
    required int offset,
  }) async {
    return await _searchRepositorie.getSearchProducts(
      productName: productName,
      limit: limit,
      offset: offset,
    );
  }
}
