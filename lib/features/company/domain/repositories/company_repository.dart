
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';

import '../../../../core/error/failures.dart';

abstract class CompanyRepository {
  Future<Either<Failure, Company>> getCompanyProfile();
  Future<Either<Failure, Company>> getCompanyByUuid(String uuid);
  Future<Either<Failure, Company>> updateCompany(Company company);
  Future<Either<Failure, Company>> updateCompanyFcmToken(String uuid , String fcmToken);
  Future<Either<Failure, Company>> uploadImageCompany(String path,String id);
}