

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/payment/domain/repositories/payment_repository.dart';

import '../../../../core/error/failures.dart';

class GetPackageUseCase {
  final PaymentRepository repository;

  GetPackageUseCase({required this.repository});


  Future<Either<Failure, List<Package>>> call(PkgType type) async {
    return await repository.getPackages(type);
  }

}