import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/wishlist/domain/repositories/wishlist_repository.dart';

class ToggleWishlistUseCase {
  final WishlistRepository _repository;
  ToggleWishlistUseCase(this._repository);

  Future<Either<Failure, String>> execute(
    int productId,
    bool isCurrentlyFavorite,
  ) async {
    if (isCurrentlyFavorite) {
      return await _repository.removeFromWishlist(productId);
    } else {
      return await _repository.addToWishlist(productId);
    }
  }
}
