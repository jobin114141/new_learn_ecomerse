import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/constants/api_endpoints.dart';
import 'package:my_ecomerse/core/error/api_error_handler.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/core/network/api_client.dart';
import 'package:my_ecomerse/features/search/data/models/search_model.dart';
import 'package:my_ecomerse/features/search/domain/repositories/search_repositorie.dart';

class SearchRepositorieImpl extends SearchRepositorie {
  final ApiClient _apiClient;
  SearchRepositorieImpl(this._apiClient);
  @override
  Future<Either<Failure, List<Product>>> getSearchProducts({
    required String productName,
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.searchProducts,
        queryParameters: {
          'name': productName,
          'limit': limit,
          'offset': offset,
        },
      );

      if (response.statusCode == 200) {
        final productResponse = ProductResponse.fromJson(response.data);
        return Right(productResponse.products);
      } else {
        return Left(
          ServerFailure(
            response.statusMessage ?? 'Failed to fetch search products',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e, stacktrace) {
      print('====================== SEARCH EXCEPTION ======================');
      print(e.toString());
      print(stacktrace.toString());
      print('==============================================================');
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
