import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/constants/api_endpoints.dart';
import 'package:my_ecomerse/core/error/api_error_handler.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/core/network/api_client.dart';
import 'package:my_ecomerse/features/wishlist/data/models/wishlist_models.dart';
import 'package:my_ecomerse/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final ApiClient _apiClient;

  WishlistRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, WishListModel>> getWishlist() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.wishListUri);

      if (response.statusCode == 200) {
        final wishlistModel = WishListModel.fromJson(response.data);
        return Right(wishlistModel);
      } else {
        return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to fetch wishlist',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> addToWishlist(int productId) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.wishListUri,
        data: {
          'product_ids': [productId],
        },
      );

      if (response.statusCode == 200) {
        final message = response.data['message'] ?? 'Added to wishlist';
        return Right(message);
      } else {
        return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to add item to wishlist',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> removeFromWishlist(int productId) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoints.wishListUri,
        data: {
          'product_ids': [productId],
          '_method': 'delete',
        },
      );

      if (response.statusCode == 200) {
        final message = response.data['message'] ?? 'Removed from wishlist';
        return Right(message);
      } else {
        return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to remove item from wishlist',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}