import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/wishlist/data/models/wishlist_models.dart';

abstract class WishlistRepository {
  Future<Either<Failure, WishListModel>> getWishlist();

  /// Add a product to wishlist
  Future<Either<Failure, String>> addToWishlist(int productId);

  /// Remove a product from wishlist
  Future<Either<Failure, String>> removeFromWishlist(int productId);
}

