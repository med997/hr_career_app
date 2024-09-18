
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/home/domain/repositories/home_repository.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

import '../../../../core/error/failures.dart';
import '../entities/home.dart';

class GetHomeCompanyUserCase {
  final HomeRepository repository;

  GetHomeCompanyUserCase(this.repository);

  Future<Either<Failure, Home>> call() async {
    return await repository.getHomeUser();
  }

}