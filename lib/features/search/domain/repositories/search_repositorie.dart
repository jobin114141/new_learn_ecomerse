import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/search/data/models/search_model.dart';

abstract class SearchRepositorie {
  Future<Either<Failure, List<Product>>> getSearchProducts({
    required String productName,
    required int limit,
    required int offset,
  });
}
