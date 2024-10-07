
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';

import '../../../../core/error/failures.dart';

abstract class CompanyRepository {
  Future<Either<Failure, Company>> getCompanyProfile();
  Future<Either<Failure, Company>> getCompanyByUuid(String uuid);
  Future<Either<Failure, Unit>> updateCompany(Company company);
}