
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/home.dart';

class GetHomeUserCase {
  final HomeRepository repository;

  GetHomeUserCase(this.repository);

  Future<Either<Failure, Home>> call() async {
    return await repository.getHomeUser();
  }
  Future<Either<Failure, Home>> callCompanyHome() async {
    return await repository.getHomeUser();

  }
}