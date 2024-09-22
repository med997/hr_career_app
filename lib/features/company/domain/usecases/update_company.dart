

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/company/domain/repositories/company_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/company.dart';

class UpdateCompany {
  final CompanyRepository companyRepository;

  UpdateCompany(this.companyRepository);

  Future<Either<Failure, Unit>> call(Company company) async {
    return await companyRepository.updateCompany(company);
  }
}