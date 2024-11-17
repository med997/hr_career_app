import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/tender/domain/entities/tender.dart';
import 'package:hr_career_platform/features/tender/domain/repositories/tender_repository.dart';

import '../../../../core/error/failures.dart';

class GetAllActiveTendersUseCase {
  final TenderRepository repository;

  GetAllActiveTendersUseCase(this.repository);

  Future<Either<Failure, List<Tender>>> call(String companyId) async {
    return await repository.getAllActiveTendersByCompany(companyId);
  }
}
