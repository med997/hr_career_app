import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/job.dart';
import '../repositories/job_repository.dart';

class GetAllActiveJobsByCompany {
  final JobRepository repository;

  GetAllActiveJobsByCompany(this.repository);

  Future<Either<Failure, List<Job>>> call(String companyId) async {
    return await repository.getAllActiveJobsByCompany(companyId);
  }
}
