import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/banner.dart';
import 'package:beliyuk/domain/repositories/banner_repository.dart';

class GetAllBanners {
  final BannerRepository repository;

  GetAllBanners(this.repository);

  Future<Either<Failure, List<Banner>>> execute() async {
    return await repository.getAllBanners();
  }
}
