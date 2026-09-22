import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/home/data/models/banner_model.dart';
import 'package:my_ecomerse/features/home/domain/repositories/banner_repository.dart';

class GetBannersUseCase {
  final BannerRepository _repository;
  GetBannersUseCase(this._repository);

  Future<Either<Failure, List<BannerModel>>> execute() async {
    return await _repository.getBanners();
  }
  
}
