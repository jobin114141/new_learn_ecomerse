import 'package:dartz/dartz.dart';
import 'package:my_ecomerse/core/error/failures.dart';
import 'package:my_ecomerse/features/home/data/models/banner_model.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<BannerModel>>> getBanners();
}
