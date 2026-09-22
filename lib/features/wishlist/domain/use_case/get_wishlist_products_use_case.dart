import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/wishlist/data/models/wishlist_models.dart';
import 'package:my_ecomerse/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlistProductsUseCase {
  final WishlistRepository _repository;

  GetWishlistProductsUseCase(this._repository);

  Future<Either<Failure, WishListModel>> execute() async {
    return await _repository.getWishlist();
  }
}
