import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/core/network/api_client.dart';
import 'package:my_ecomerse/features/home/data/models/all_products_model';
import 'package:my_ecomerse/features/home/domain/repositories/all_items_repository.dart';

class AllProductsImpl extends AllItemsRepository {
  // ignore: unused_field
  final ApiClient _apiClient;
  // Create a raw Dio instance specifically for Pexels so our ApiClient 
  // interceptors don't overwrite the Authorization header!
  final Dio _pexelsDio = Dio();

  AllProductsImpl(this._apiClient);

  @override
  Future<Either<Failure, List<PexelsResponse>>> getAllProducts({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _pexelsDio.get(
        'https://api.pexels.com/v1/search',
        queryParameters: {
          'query': 'meat',
          'per_page': limit,
          'page': offset, // Passing offset as page for pagination!
        },
        options: Options(
          headers: {
            'Authorization':
                '7YT8HjFsP6TMO8HRBkUJcz0bJuLHGRMp1LVTNwopd4af3hjiXF3Uhcly',
          },
        ),
      );

      if (response.statusCode == 200) {
        final pexelsResponse = PexelsResponse.fromJson(response.data);
        return Right([pexelsResponse]);
      } else {
        return Left(
          ServerFailure('Failed to fetch products: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
