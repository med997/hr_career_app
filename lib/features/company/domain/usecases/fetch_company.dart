

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/company/domain/repositories/company_repository.dart';

import '../../../../core/error/failures.dart';

class FetchCompanyUserCase {
  final CompanyRepository companyRepository;

  FetchCompanyUserCase(this.companyRepository);

  Future<Either<Failure, Company>> getCompanyProfile() async {
    return await companyRepository.getCompanyProfile();
  }
  Future<Either<Failure, Company>> getCompanyByUuid(String uuid) async {
    return await companyRepository.getCompanyByUuid(uuid );
  }
}