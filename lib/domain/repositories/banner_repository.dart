import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/banner.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<Banner>>> getAllBanners();
}
